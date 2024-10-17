const cds = require('@sap/cds');

module.exports = async (srv) => 
{        
    // Using CDS API      
    const STIHL_B2B_K4Q100_BASIC = await cds.connect.to("STIHL_B2B_K4Q100_BASIC"); 
      srv.on('READ', 'POVendorVH', req => STIHL_B2B_K4Q100_BASIC.run(req.query)); 
      srv.on('READ', 'PlantVH', req => STIHL_B2B_K4Q100_BASIC.run(req.query)); 
      srv.on('READ', 'ZA_MM_CustomDutyInvDetails', req => STIHL_B2B_K4Q100_BASIC.run(req.query)); 
}