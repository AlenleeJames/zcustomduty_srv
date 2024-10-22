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
       console.log('Reached');
       const CustomDutyData = req.data.fileData;
       CustomDutyData[0].CountryOfOrigin = 'INDIA';
       CustomDutyData[1].CountryOfOrigin = 'FRANCE';
       return CustomDutyData;

    })

    srv.before ('CREATE', 'CustomDutyMaster', async (req) => {
        
        
    });    
}