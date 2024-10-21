const cds = require('@sap/cds');

module.exports = async (srv) => 
{        
    // Using CDS API      
    const STIHL_B2B_K4Q100_BASIC = await cds.connect.to("STIHL_B2B_K4Q100_BASIC"); 
      srv.on('READ', 'POVendorVH', req => STIHL_B2B_K4Q100_BASIC.run(req.query)); 
      srv.on('READ', 'PlantVH', req => STIHL_B2B_K4Q100_BASIC.run(req.query)); 
      srv.on('READ', 'ZA_MM_CustomDutyInvDetails', req => STIHL_B2B_K4Q100_BASIC.run(req.query)); 


    this.on('calculateCHA_ExcelData', async req => {
      let { book:id, quantity } = req.data
      let book = await SELECT.from (Books, id, b => b.stock)
  
      // Validate input data
      if (!book) return req.error (404, `Book #${id} doesn't exist`)
      if (quantity < 1) return req.error (400, `quantity has to be 1 or more`)
      if (quantity > book.stock) return req.error (409, `${quantity} exceeds stock for book #${id}`)
  
      // Reduce stock in database and return updated stock value
      await UPDATE (Books, id) .with ({ stock: book.stock -= quantity })
      return book
    })
}