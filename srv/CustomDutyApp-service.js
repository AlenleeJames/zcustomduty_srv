const cds = require('@sap/cds');

module.exports = async (srv) => 
{        
    // Using CDS API      
    const CustomDutyMaster = await cds.connect.to("CustomDutyInvoiceSrv"); 
      srv.on('READ', 'POVendorVH', req => CustomDutyMaster.run(req.query)); 
      srv.on('READ', 'PlantVH', req => CustomDutyMaster.run(req.query)); 
      srv.on('READ', 'ZA_MM_CustomDutyInvDetails', req => CustomDutyMaster.run(req.query)); 

    // Using CDS API      
    const API_SUPPLIERINVOICE_PROCESS_SRV = await cds.connect.to("API_SUPPLIERINVOICE_PROCESS_SRV"); 
      srv.on('READ', 'SupplierInvoice', req => API_SUPPLIERINVOICE_PROCESS_SRV.run(req.query)); 

    const InvoiceSrv = await cds.connect.to("API_SUPPLIERINVOICE_PROCESS_SRV"); 
    const { SupplierInvoice } = srv.entities;
    //Service Call to POST Supplier Invoice
    srv.on('PostSupplierInvoice', async(req) => {
      // Extract the Supplier Invoice payload from the request data
      const CustomDutyData = req.data.InvoiceData;
      // Map the POST request on remote service
      const InvoicePostResponse = await InvoiceSrv.run(INSERT.into(SupplierInvoice, [CustomDutyData]));      
      // Return the response
      return InvoicePostResponse;
    });

    //Custom Duty Calculation
    srv.on('calculateDuty', async(req)=>{
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
            InvoiceValue = InvoiceValue + (CustomDutyData[j].InvoiceValueFC * CustomDutyData[j].ExcRateforInvoice);
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
            CustomDutyData[b].OverFreightperitem = ((CustomDutyData[b].InvoiceValueFC * CustomDutyData[b].ExcRateforInvoice) / Summed_InvoiceValue ) * CustomDutyData[b].OverseasFreightAmount;
            CustomDutyData[b].DomesticFreightperitem = ((CustomDutyData[b].InvoiceValueFC * CustomDutyData[b].ExcRateforInvoice) / Summed_InvoiceValue ) * CustomDutyData[b].DomesticFreightAmount;
            CustomDutyData[b].Inschargesperitem = ((CustomDutyData[b].InvoiceValueFC * CustomDutyData[b].ExcRateforInvoice) / Summed_InvoiceValue ) * CustomDutyData[b].InsuranceAmount;
            CustomDutyData[b].Miscchargesperitem = ((CustomDutyData[b].InvoiceValueFC * CustomDutyData[b].ExcRateforInvoice) / Summed_InvoiceValue ) * CustomDutyData[b].MiscCharges;
          }
        }
      }
       return CustomDutyData;   

    });

    srv.before ('CREATE', 'CustomDutyMaster', async (req) => { 
        
        
    });    
}