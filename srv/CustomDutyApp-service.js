const cds = require('@sap/cds');
cds.on('bootstrap', (app) => {
  app.use(cds.odata.batch()); // Enable batch processing
});

module.exports = async (srv) => {
  // Using CDS API      
  const CustomDutyMaster = await cds.connect.to("CustomDutyInvoiceSrv");
  srv.on('READ', 'POVendorVH', req => CustomDutyMaster.run(req.query));
  srv.on('READ', 'PlantVH', req => CustomDutyMaster.run(req.query));
  srv.on('READ', 'ZA_MM_CustomDutyInvDetails', req => CustomDutyMaster.run(req.query));

  // Using CDS API      
  const API_SUPPLIERINVOICE_PROCESS_SRV = await cds.connect.to("API_SUPPLIERINVOICE_PROCESS_SRV");
  srv.on('READ', 'SupplierInvoice', req => API_SUPPLIERINVOICE_PROCESS_SRV.run(req.query));

  //const InvoiceSrv = await cds.connect.to("API_SUPPLIERINVOICE_PROCESS_SRV"); 

  const { SupplierInvoice } = srv.entities;
  //Service Call to POST Supplier Invoice

  srv.on('PostSupplierInvoice', async (req) => {
    const { InvoiceData } = req.data; // Extract the payload
    const { SupplierInvoice } = srv.entities; // Get the entity reference
    const InvoiceSrv = await cds.connect.to("API_SUPPLIERINVOICE_PROCESS_SRV");
    const tx = cds.transaction(req); // Create a CAP transaction instance

    try {
      // Use Promise.all to execute inserts in parallel and capture individual results
      const results = await Promise.all(
        InvoiceData.map(async (invoice) => {
          try {
            // Perform the insertion using the CAP transaction
            const result = await InvoiceSrv.run(INSERT.into(SupplierInvoice).entries(invoice));
            return { success: true, invoice, result };
          } catch (err) {
            // Capture errors and allow other operations to proceed
            return { success: false, invoice, error: err.message.split(': ')[1] };
          }
        })
      );

      const InvoicePostResult = [];
      results.forEach(element => {

        if (element.success == true) {
          element.invoice.Message = "Invoice Posted Successfully";
          element.invoice.Status = "Success";
          element.invoice.SupplierInvoice = element.result.SupplierInvoice;
          InvoicePostResult.push(element.invoice);
        } else if (element.success == false) {
          element.invoice.Message = element.error;
          element.invoice.Status = 'Error';
          InvoicePostResult.push(element.invoice);
        };

      });

      return InvoicePostResult;
      // Filter out failed operations
      //   const failed = results.filter((res) => !res.success);    
      //   if (failed.length > 0) {
      //     // If any invoice fails, rollback the transaction         
      //     req.error(400, `Some invoices failed: ${JSON.stringify(failed)}`);
      //   } else {
      //     // Commit the transaction if all invoices succeed         
      //     return { message: "All invoices processed successfully.", results };
      //   }
    } catch (error) {
      // Handle unexpected errors by rolling back the transaction       
      req.error(500, `Transaction failed: ${error.message}`);
    }
  });

  srv.on('PostInvoice', async (req) => {
    const { ID } = req.data; // Extract the payload    
    const { CustomDutyHdr, CustomDutyItem, CustomDutyLog, SupplierInvoice } = srv.entities;

    // Optional: Add business logic here
    //const query = SELECT.from(CustomDutyHdr).columns('*', 'to_CustomDutyItem.*');
    const tx = cds.transaction(req);
    var header = await tx.run(
      SELECT.one.from(CustomDutyHdr).where({ ID })                     // Filter by ID
    );
    if (!header) {
      req.error(404, `Record with ID ${ID} not found`);
      return false;
    } else {      
      var item = await tx.run(
        SELECT.from(CustomDutyItem).where({ BENoKey_ID: ID })                     // Filter by ID
      );

      var log = await tx.run(
        SELECT.from(CustomDutyLog).where({ BENoKey_ID: ID })                     // Filter by ID
      );
      if (log.length > 0) {
        header.to_CustomDutyLog = log;
      } else {
        header.to_CustomDutyLog = [];
      }

      var trxProcessed = false;
      var InvoiceDomCompleted = true;
      var InvoiceOverCompleted = true;
      var InvoiceCusCompleted = true;
      const InvoiceCustSrv = await cds.connect.to("API_SUPPLIERINVOICE_PROCESS_SRV");
      const InvoiceDomSrv = await cds.connect.to("API_SUPPLIERINVOICE_PROCESS_SRV");
      const InvoiceOverSrv = await cds.connect.to("API_SUPPLIERINVOICE_PROCESS_SRV");

      //Domestic Invoice Posting
      if (header.DomesticVendInvStat == 'Saved' || header.DomesticVendInvStat == 'Error') {
        trxProcessed = true;
        InvoiceDomCompleted = false;
        await UPDATE(CustomDutyHdr)
          .set({ OverallStatus: 'In Progress' })
          .where({ ID });

        var DomPayload = {};
        var invItem = [];
        DomPayload.Process = 'Domestic';
        DomPayload.FiscalYear = new Date().getFullYear().toString();
        DomPayload.CompanyCode = 'IN10';
        DomPayload.DocumentDate = item[0].Invoicedate;
        DomPayload.PostingDate = item[0].Invoicedate;
        DomPayload.SupplierInvoiceIDByInvcgParty = item[0].BENo;
        DomPayload.InvoicingParty = header.DomesticVendor;
        DomPayload.DocumentCurrency = 'INR';
        DomPayload.BusinessPlace = 'MH01';
        DomPayload.TaxDeterminationDate = new Date();
        DomPayload.TaxReportingDate = new Date();
        DomPayload.TaxFulfillmentDate = new Date();
        DomPayload.TaxIsCalculatedAutomatically = true;
        var SupplierInvoiceItem = 0;
        var totalAmt = 0;
        item.forEach(element => {
          for (let index = 1; index < 3; index++) {
            SupplierInvoiceItem = SupplierInvoiceItem + 1;
            var itemData = {};
            itemData.SupplierInvoiceItem = SupplierInvoiceItem.toString();
            itemData.PurchaseOrder = element.PurchaseOrder;
            itemData.PurchaseOrderItem = element.PurchaseorderItem;
            itemData.Plant = header.Plant;
            if (index == 1) {
              totalAmt = totalAmt + element.DomesticFreightperitem1;
              itemData.SupplierInvoiceItemAmount = element.DomesticFreightperitem1;           
              itemData.TaxCode = element.DomesticFrtAmtTAX1;
              itemData.SuplrInvcDeliveryCostCndnType = "ZFR1";
            } else {
              totalAmt = totalAmt + element.DomesticFreightperitem2;
              itemData.SupplierInvoiceItemAmount = element.DomesticFreightperitem2;           
              itemData.TaxCode = element.DomesticFrtAmtTAX2
              itemData.SuplrInvcDeliveryCostCndnType = "ZMIS";
            }            
            itemData.DocumentCurrency = 'INR';
            itemData.PurchaseOrderQuantityUnit = element.Unit;
            itemData.QuantityInPurchaseOrderUnit = element.Quantity;
            itemData.PurchaseOrderPriceUnit = element.Unit;
            itemData.QtyInPurchaseOrderPriceUnit = element.Quantity;             
            itemData.FreightSupplier = header.DomesticVendor;
            itemData.TaxDeterminationDate = new Date();
            invItem.push(itemData);
          }
        }); 
        let addedAmount = (18 / 100) * totalAmt;
        // Add the percentage amount to the original totalAmt
        totalAmt += addedAmount;
        DomPayload.InvoiceGrossAmount = totalAmt;        
        if (invItem) {
          DomPayload.to_SuplrInvcItemPurOrdRef = invItem;
        } else {
          DomPayload.to_SuplrInvcItemPurOrdRef = [];
        }
        if (DomPayload) {
          InvoiceDomSrv.run(INSERT.into(SupplierInvoice).entries(DomPayload)).then(async (result) => {
            InvoiceDomCompleted = true;
            if (InvoiceDomCompleted == true && InvoiceOverCompleted == true && InvoiceCusCompleted == true) {
              header.OverallStatus = 'Completed';
            }
            header.DomesticVendInvStat = 'Success';
            header.DomesticVendInv = result.SupplierInvoice;
            header.DomesticVendInvMsg = 'Invoice Posted Successfully';
            item.forEach(element => {
              //element.Remarks = 'Invoice Posted';
              //element.status = 'Success';
              element.DomFreightInvoice = result.SupplierInvoice;
            });
            header.to_CustomDutyItem = item;
            let Message = {};
            Message.type = 'Success';
            Message.message = 'Domestic vendor invoice '  + result.SupplierInvoice + 'posted';
            header.to_CustomDutyLog.push(Message);
            try {
              await UPDATE(CustomDutyHdr)
                .set(header)
                .where({ ID });
            } catch (err) {
              req.error(500, `Error updating record with ID ${ID}: ${err.message}`);
              return false;
            }
          })
            .catch(async (err) => {
              InvoiceDomCompleted = true;
              if (InvoiceDomCompleted == true && InvoiceOverCompleted == true && InvoiceCusCompleted == true) {
                header.OverallStatus = 'Completed';
              }
              header.DomesticVendInvStat = 'Error';
              header.DomesticVendInvMsg = err.message.split(': ')[1];
              item.forEach(element => {
                //element.Remarks = err.message.split(': ')[1];
                //element.status = 'Error';
              });
              header.to_CustomDutyItem = item;
              let Message = {};
              Message.type = 'Error';
              Message.message = 'Domestic Vendor posting :' + header.DomesticVendInvMsg;
              header.to_CustomDutyLog.push(Message);
              try {
                await UPDATE(CustomDutyHdr)
                  .set(header)
                  .where({ ID });
              } catch (err) {
                req.error(500, `Error updating record with ID ${ID}: ${err.message}`);
                return false;
              }

            });
        }
      }

      //OverSeas Invoice Posting
      if (header.OverSeasVendInvStat == 'Saved' || header.OverSeasVendInvStat == 'Error') {
        trxProcessed = true;
        InvoiceOverCompleted = false;
        await UPDATE(CustomDutyHdr) 
          .set({ OverallStatus: 'In Progress' })
          .where({ ID });

        var OverseasPayload = {}; 
        var invItem = [];
        OverseasPayload.Process = 'Overseas';
        OverseasPayload.FiscalYear = new Date().getFullYear().toString();
        OverseasPayload.CompanyCode = 'IN10';
        OverseasPayload.DocumentDate = item[0].Invoicedate;
        OverseasPayload.PostingDate = item[0].Invoicedate;
        OverseasPayload.SupplierInvoiceIDByInvcgParty = item[0].BENo;
        OverseasPayload.InvoicingParty = header.OverSeasVendor;
        OverseasPayload.DocumentCurrency = 'INR';
        OverseasPayload.BusinessPlace = 'MH01';
        OverseasPayload.TaxDeterminationDate = new Date();
        OverseasPayload.TaxReportingDate = new Date();
        OverseasPayload.TaxFulfillmentDate = new Date();
        OverseasPayload.TaxIsCalculatedAutomatically = true;
        var SupplierInvoiceItem = 0;
        var totalAmt = 0;
        item.forEach(element => {
          for (let index = 1; index < 3; index++) {
          SupplierInvoiceItem = SupplierInvoiceItem + 1;
          var itemData = {};
          itemData.SupplierInvoiceItem = SupplierInvoiceItem.toString();
          itemData.PurchaseOrder = element.PurchaseOrder;
          itemData.PurchaseOrderItem = element.PurchaseorderItem;
          itemData.Plant = header.Plant;          
          if (index == 1) {
            itemData.TaxCode = element.OverseasFrtAmtTAX1;
            itemData.SuplrInvcDeliveryCostCndnType = "ZFR2";
            totalAmt = totalAmt + element.OverFreightperitem1;
            itemData.SupplierInvoiceItemAmount = element.OverFreightperitem1;
          } else {
            itemData.TaxCode = element.OverseasFrtAmtTAX2;
            itemData.SuplrInvcDeliveryCostCndnType = "FVA1";
            totalAmt = totalAmt + element.OverFreightperitem2;
          itemData.SupplierInvoiceItemAmount = element.OverFreightperitem2;
          } 
          itemData.DocumentCurrency = 'INR';
          itemData.PurchaseOrderQuantityUnit = element.Unit;
          itemData.QuantityInPurchaseOrderUnit = element.Quantity;
          itemData.PurchaseOrderPriceUnit = element.Unit;
          itemData.QtyInPurchaseOrderPriceUnit = element.Quantity;          
          itemData.FreightSupplier = header.OverSeasVendor;
          itemData.TaxDeterminationDate = new Date();
          invItem.push(itemData);
          }
        });

        let addedAmount = (18 / 100) * totalAmt;
        // Add the percentage amount to the original totalAmt
        totalAmt += addedAmount;
        OverseasPayload.InvoiceGrossAmount = totalAmt;
        if (invItem) {
          OverseasPayload.to_SuplrInvcItemPurOrdRef = invItem;
        } else {
          OverseasPayload.to_SuplrInvcItemPurOrdRef = [];
        }
        if (OverseasPayload) {
          InvoiceOverSrv.run(INSERT.into(SupplierInvoice).entries(OverseasPayload)).then(async (result) => {
            InvoiceOverCompleted = true;
            if (InvoiceDomCompleted == true && InvoiceOverCompleted == true && InvoiceCusCompleted == true) {
              header.OverallStatus = 'Completed';
            }
            header.OverSeasVendInvStat = 'Success';
            header.OverSeasVendInv = result.SupplierInvoice;
            header.OverSeasVendInvMsg = 'Invoice Posted Successfully';
            item.forEach(element => {
              //element.Remarks = 'Invoice Posted';
              //element.status = 'Success';
              element.OverFreighInvoice = result.SupplierInvoice;
            });
            header.to_CustomDutyItem = item;
            let Message = {};
            Message.type = 'Success';
            Message.message = 'Overseas vendor invoice '  + result.SupplierInvoice + 'posted';
            header.to_CustomDutyLog.push(Message);
            try {
              await UPDATE(CustomDutyHdr)
                .set(header)
                .where({ ID });
            } catch (err) {
              req.error(500, `Error updating record with ID ${ID}: ${err.message}`);
              return false;
            }
          })
            .catch(async (err) => {
              InvoiceOverCompleted = true;
              if (InvoiceDomCompleted == true && InvoiceOverCompleted == true && InvoiceCusCompleted == true) {
                header.OverallStatus = 'Completed';
              }
              header.OverSeasVendInvStat = 'Error';
              header.OverSeasVendInvMsg = err.message.split(': ')[1];
              item.forEach(element => {
                //element.Remarks = err.message.split(': ')[1];
                //element.status = 'Error';
              });
              header.to_CustomDutyItem = item;
              let Message = {};
              Message.type = 'Error';
              Message.message = 'Overseas Vendor posting :' + header.OverSeasVendInvMsg;
              header.to_CustomDutyLog.push(Message);
              try {
                await UPDATE(CustomDutyHdr)
                  .set(header)
                  .where({ ID });
              } catch (err) {
                req.error(500, `Error updating record with ID ${ID}: ${err.message}`);
                return false;
              }

            });
        }
      }

      //Custom Invoice Posting
      if (header.CustomVendInvStat == 'Saved' || header.CustomVendInvStat == 'Error') {
        trxProcessed = true;
        InvoiceCusCompleted = false;
        await UPDATE(CustomDutyHdr)
          .set({ OverallStatus: 'In Progress' })
          .where({ ID });

        var CustomPayload = {};
        var invItem = [];
        CustomPayload.Process = 'Custom';
        CustomPayload.FiscalYear = new Date().getFullYear().toString();
        CustomPayload.CompanyCode = 'IN10';
        CustomPayload.DocumentDate = item[0].Invoicedate;
        CustomPayload.PostingDate = item[0].Invoicedate;
        CustomPayload.SupplierInvoiceIDByInvcgParty = item[0].BENo;
        CustomPayload.InvoicingParty = header.CustomVendor;
        CustomPayload.DocumentCurrency = 'INR';
        CustomPayload.BusinessPlace = 'MH01';        
        //CustomPayload.UnplannedDeliveryCostTaxCode = 'A3';
        CustomPayload.TaxIsCalculatedAutomatically = true;
        CustomPayload.TaxDeterminationDate = new Date();
        CustomPayload.TaxReportingDate = new Date();
        CustomPayload.TaxFulfillmentDate = new Date();
        var SupplierInvoiceItem = 0;
        var totalAmt = 0;
        item.forEach(element => { 
          totalAmt = totalAmt + element.IGST;
          for (let index = 1; index < 3; index++) {
            SupplierInvoiceItem = SupplierInvoiceItem + 1;
            var itemData = {};
            itemData.SupplierInvoiceItem = SupplierInvoiceItem.toString();
            itemData.PurchaseOrder = element.PurchaseOrder;
            itemData.PurchaseOrderItem = element.PurchaseorderItem;
            itemData.Plant = header.Plant;
            itemData.TaxCode = 'A3';
            itemData.DocumentCurrency = 'INR';
            itemData.PurchaseOrderQuantityUnit = element.Unit;
            itemData.QuantityInPurchaseOrderUnit = element.Quantity;
            itemData.PurchaseOrderPriceUnit = element.Unit;
            itemData.QtyInPurchaseOrderPriceUnit = element.Quantity;
            if (index == 1) {
              totalAmt = totalAmt + element.BCDAmount;
              itemData.SupplierInvoiceItemAmount = element.BCDAmount;
              itemData.SuplrInvcDeliveryCostCndnType = 'JCDB';
              itemData.IN_CustomDutyAssessableValue = element.AssessableValue;
            } else {
              totalAmt = totalAmt + element.SocWelSurDutyAmt;
              itemData.SupplierInvoiceItemAmount = element.SocWelSurDutyAmt;
              itemData.SuplrInvcDeliveryCostCndnType = 'JSWC';
              itemData.IN_CustomDutyAssessableValue = 0;
            }
            itemData.FreightSupplier = header.CustomVendor;
            itemData.TaxDeterminationDate = new Date();
            invItem.push(itemData);
          }
        });
        CustomPayload.InvoiceGrossAmount = totalAmt;
        if (invItem) {
          CustomPayload.to_SuplrInvcItemPurOrdRef = invItem;
        } else {
          CustomPayload.to_SuplrInvcItemPurOrdRef = [];
        }
        if (CustomPayload) {
          InvoiceCustSrv.run(INSERT.into(SupplierInvoice).entries(CustomPayload)).then(async (result) => {
            InvoiceCusCompleted = true;
            if (InvoiceDomCompleted == true && InvoiceOverCompleted == true && InvoiceCusCompleted == true) {
              header.OverallStatus = 'Completed';
            }
            header.CustomVendInvStat = 'Success';
            header.CustomVendInv = result.SupplierInvoice;
            header.CustomVendInvMsg = 'Invoice Posted Successfully';
            item.forEach(element => {
              //element.Remarks = 'Invoice Posted';
              //element.status = 'Success';
              element.CustomInvoice = result.SupplierInvoice;
            });
            let Message = {};
            Message.type = 'Success';
            Message.message = 'Custom vendor invoice '  + result.SupplierInvoice + 'posted';
            header.to_CustomDutyLog.push(Message);
            header.to_CustomDutyItem = item;
            
            try {
              await UPDATE(CustomDutyHdr)
                .set(header)
                .where({ ID });
            } catch (err) {
              req.error(500, `Error updating record with ID ${ID}: ${err.message}`);
              return false;
            }
          })
            .catch(async (err) => { 
              InvoiceCusCompleted = true;
              if (InvoiceDomCompleted == true && InvoiceOverCompleted == true && InvoiceCusCompleted == true) {
                header.OverallStatus = 'Completed';
              }
              header.CustomVendInvStat = 'Error';
              header.CustomVendInvMsg = err.message.split(': ')[1];
              item.forEach(element => {
                //element.Remarks = err.message.split(': ')[1];
                //element.status = 'Error';
              });
              let Message = {};
              Message.type = 'Error';
              Message.message = 'Custom Vendor posting :' + header.CustomVendInvMsg;
              header.to_CustomDutyLog.push(Message);
              header.to_CustomDutyItem = item;
              try {  
                await UPDATE(CustomDutyHdr)
                  .set(header)
                  .where({ ID });
              } catch (err) {
                req.error(500, `Error updating record with ID ${ID}: ${err.message}`);
                return false;
              }
            });
        }
      }
      if (trxProcessed) {
        return true;
      } else {
        req.error(500, `No data to process invoice posting`);
        return false;
      }      
    }
  });


  srv.on('SaveCustomDuty', async (req) => {
    const { CustomDutyData } = req.data; // Extract the payload    
    const { CustomDutyHdr } = srv.entities;
    try {
      // Insert data into MyEntity table
      const result = await cds.transaction(req).run([
        INSERT.into(CustomDutyHdr).entries(CustomDutyData)
      ]);
      // Return the result or a success message
      return CustomDutyData;
    } catch (error) {
      req.error(500, `Insertion failed: ${error.message}`);
    }
  });

  srv.on('UpdateCustomDuty', async (req) => {
    const { ID, CustomDutyData } = req.data; // Extract the payload    
    const { CustomDutyHdr } = srv.entities;

    // Optional: Add validation or business logic here
    const hdr = await SELECT.one.from(CustomDutyHdr).where({ ID });
    if (!hdr) {
      req.error(404, `Record with ID ${ID} not found`);
      return false;
    }

    try {
      await UPDATE(CustomDutyHdr)
        .set(CustomDutyData)
        .where({ ID });
      return CustomDutyData;  // Indicate successful update
    } catch (err) {
      req.error(500, `Error updating record with ID ${ID}: ${err.message}`);
      return false;
    }
  });

  srv.on('DeleteCustomDuty', async (req) => {
    const { ID } = req.data; // Extract the payload    
    const { CustomDutyHdr } = srv.entities;

    // Optional: Add business logic here
    const hdr = await SELECT.one.from(CustomDutyHdr).where({ ID });
    if (!hdr) {
      req.error(404, `Record with ID ${ID} not found`);
      return false;
    }

    try {
      await DELETE.from(CustomDutyHdr).where({ ID });
      return true;  // Indicating successful deletion
    } catch (err) {
      req.error(500, `Error deleting record with ID ${ID}: ${err.message}`);
      return false;
    }
  });

  //Custom Duty Calculation
  srv.on('calculateDuty', async (req) => {
    // Extract the Supplier Invoice payload from the request data      
    const CustomDutyData = req.data.fileData;
    //Distinct Invoice Numbers
    var selInvoice = [], finalCalcInvoice = [], InvoiceValue = 0;
    CustomDutyData.map(element => {
      var Invoice = element.InvoiceNumber;
      if (selInvoice.indexOf(Invoice) < 0) {
        selInvoice.push(Invoice);   //distinct Invoice Numbers
      }
    });

    //calculate total invoice value with exchange rate for every invoice
    for (var i = 0; i < selInvoice.length; i++) {
      InvoiceValue = 0;
      for (var j = 0; j < CustomDutyData.length; j++) {
        if (selInvoice[i] === CustomDutyData[j].InvoiceNumber) {
          InvoiceValue = InvoiceValue + (CustomDutyData[j].InvoiceValueFC * CustomDutyData[j].FreightExrate);
        }
      }
      //push distinct Invoices with Calculated Exc Rate Invoice Value
      finalCalcInvoice.push({
        "InvoiceNumber": selInvoice[i],
        "Summed_InvoiceValue": InvoiceValue
      });
    }

    //Final Payload 
    for (var a = 0; a < finalCalcInvoice.length; a++) {
      var InvoiceNumber = finalCalcInvoice[a].InvoiceNumber,
        Summed_InvoiceValue = finalCalcInvoice[a].Summed_InvoiceValue;
      for (var b = 0; b < CustomDutyData.length; b++) {
        if (InvoiceNumber === CustomDutyData[b].InvoiceNumber) {
          CustomDutyData[b].OverFreightperitem1 = ((CustomDutyData[b].InvoiceValueFC * CustomDutyData[b].FreightExrate) / Summed_InvoiceValue) * CustomDutyData[b].OverseasFrtAmtCALC1;
          CustomDutyData[b].DomesticFreightperitem1 = ((CustomDutyData[b].InvoiceValueFC * CustomDutyData[b].FreightExrate) / Summed_InvoiceValue) * CustomDutyData[b].DomesticFrtAmtCALC1;
          CustomDutyData[b].Inschargesperitem1 = ((CustomDutyData[b].InvoiceValueFC * CustomDutyData[b].FreightExrate) / Summed_InvoiceValue) * CustomDutyData[b].InsuranceAmTCALC1;
          CustomDutyData[b].Miscchargesperitem1 = ((CustomDutyData[b].InvoiceValueFC * CustomDutyData[b].FreightExrate) / Summed_InvoiceValue) * CustomDutyData[b].MiscAmountCALC1;
          CustomDutyData[b].OverFreightperitem2 = ((CustomDutyData[b].InvoiceValueFC * CustomDutyData[b].FreightExrate) / Summed_InvoiceValue) * CustomDutyData[b].OverseasFrtAmtCALC2;
          CustomDutyData[b].DomesticFreightperitem2 = ((CustomDutyData[b].InvoiceValueFC * CustomDutyData[b].FreightExrate) / Summed_InvoiceValue) * CustomDutyData[b].DomesticFrtAmtCALC2;
          CustomDutyData[b].Inschargesperitem2 = ((CustomDutyData[b].InvoiceValueFC * CustomDutyData[b].FreightExrate) / Summed_InvoiceValue) * CustomDutyData[b].InsuranceAmTCALC2;
          CustomDutyData[b].Miscchargesperitem2 = ((CustomDutyData[b].InvoiceValueFC * CustomDutyData[b].FreightExrate) / Summed_InvoiceValue) * CustomDutyData[b].MiscAmountCALC2;
        }
      }
    }
    return CustomDutyData;

  });

  srv.before('CREATE', 'CustomDutyMaster', async (req) => {


  });
}