/* checksum : 24881e7956131d84891c548b54a88812 */
@cds.external : true
@m.IsDefaultEntityContainer : 'true'
@sap.message.scope.supported : 'true'
@sap.supported.formats : 'atom json xlsx'
service CustomDutyInvoiceSrv {};

@cds.external : true
@cds.persistence.skip : true
@sap.creatable : 'false'
@sap.updatable : 'false'
@sap.deletable : 'false'
@sap.searchable : 'true'
@sap.content.version : '1'
@sap.label : 'Plant'
entity CustomDutyInvoiceSrv.PlantVH {
  @sap.display.format : 'UpperCase'
  @sap.text : 'PlantName'
  @sap.label : 'Plant'
  key Plant : String(4) not null;
  @sap.label : 'Plant Name'
  PlantName : String(30);
};

@cds.external : true
@cds.persistence.skip : true
@sap.creatable : 'false'
@sap.updatable : 'false'
@sap.deletable : 'false'
@sap.searchable : 'true'
@sap.content.version : '1'
@sap.label : 'Supplier'
entity CustomDutyInvoiceSrv.POVendorVH {
  @sap.display.format : 'UpperCase'
  @sap.text : 'BPSupplierName'
  @sap.label : 'Supplier'
  @sap.quickinfo : 'Account Number of Supplier'
  key Supplier : String(10) not null;
  @sap.label : 'Supplier Name1'
  @sap.quickinfo : 'Supplier Name'
  SupplierName : String(35);
  @sap.label : 'Business Partner Name1'
  BusinessPartnerName1 : String(40);
  @sap.label : 'Business Partner Supplier Name'
  @sap.quickinfo : 'Supplier Name'
  BPSupplierName : String(81);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Authorization'
  @sap.quickinfo : 'Authorization Group'
  AuthorizationGroup : String(4);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Account Group'
  @sap.quickinfo : 'Supplier Account Group'
  SupplierAccountGroup : String(4);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Purpose Completed'
  @sap.quickinfo : 'Business Purpose Completed Flag'
  IsBusinessPurposeCompleted : String(1);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Business Partner'
  @sap.quickinfo : 'Business Partner Number'
  BusinessPartner : String(10);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Business Partner Type'
  BusinessPartnerType : String(4);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Data Ctrlr. Set'
  @sap.quickinfo : 'BP: Data Controller Set Flag'
  DataControllerSet : String(1);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Data Controller'
  @sap.quickinfo : 'BP: Data Controller (Internal Use Only)'
  DataController1 : String(30);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Data Controller'
  @sap.quickinfo : 'BP: Data Controller (Internal Use Only)'
  DataController2 : String(30);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Data Controller'
  @sap.quickinfo : 'BP: Data Controller (Internal Use Only)'
  DataController3 : String(30);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Data Controller'
  @sap.quickinfo : 'BP: Data Controller (Internal Use Only)'
  DataController4 : String(30);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Data Controller'
  @sap.quickinfo : 'BP: Data Controller (Internal Use Only)'
  DataController5 : String(30);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Data Controller'
  @sap.quickinfo : 'BP: Data Controller (Internal Use Only)'
  DataController6 : String(30);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Data Controller'
  @sap.quickinfo : 'BP: Data Controller (Internal Use Only)'
  DataController7 : String(30);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Data Controller'
  @sap.quickinfo : 'BP: Data Controller (Internal Use Only)'
  DataController8 : String(30);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Data Controller'
  @sap.quickinfo : 'BP: Data Controller (Internal Use Only)'
  DataController9 : String(30);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Data Controller'
  @sap.quickinfo : 'BP: Data Controller (Internal Use Only)'
  DataController10 : String(30);
};

@cds.external : true
@cds.persistence.skip : true
@sap.creatable : 'false'
@sap.updatable : 'false'
@sap.deletable : 'false'
@sap.content.version : '1'
@sap.label : 'API View - Customs Invoice Details'
entity CustomDutyInvoiceSrv.ZA_MM_CustomDutyInvDetails {
  @sap.display.format : 'UpperCase'
  @sap.label : 'Delivery'
  key IBDNumber : String(10) not null;
  @sap.display.format : 'NonNegative'
  @sap.label : 'Item'
  @sap.quickinfo : 'Delivery Item'
  key IBDItemNumber : String(6) not null;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Plant'
  Plant : String(4);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Product'
  @sap.quickinfo : 'Product Number'
  Material : String(18);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Tax number'
  @sap.quickinfo : 'Business Partner Tax Number'
  BPTaxNumber : String(20);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Country/Region Key'
  Country : String(3);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Purchase Order'
  @sap.quickinfo : 'Purchase Order Number'
  PurchaseorderNumber : String(10);
  @sap.display.format : 'NonNegative'
  @sap.label : 'Purchase Order Item'
  @sap.quickinfo : 'Item Number of Purchase Order'
  POItemNumber : String(5);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Supplier'
  POVendor : String(10);
  @sap.label : 'External Delivery ID'
  @sap.quickinfo : 'External Identification of Delivery Note'
  InvoiceNumber : String(35);
  @sap.unit : 'PurchaseOrderQuantityUnit'
  @sap.label : 'Order Quantity'
  @sap.quickinfo : 'Purchase Order Quantity'
  POQuantity : Decimal(13, 3);
  @sap.unit : 'PurchaseOrderQuantityUnit'
  @sap.label : 'Quantity'
  GRQuantity : Decimal(13, 3);
  @sap.unit : 'PurchaseOrderQuantityUnit'
  OpenQuantity : Decimal(13, 3);
  @sap.label : 'Order Unit'
  @sap.quickinfo : 'Purchase Order Unit of Measure'
  @sap.semantics : 'unit-of-measure'
  PurchaseOrderQuantityUnit : String(3);
  @sap.display.format : 'UpperCase'
  @sap.label : 'Control Code'
  @sap.quickinfo : 'Control code for consumption taxes in foreign trade'
  HSNCode : String(16);
  BCDVendor : String(10);
  SWSVendor : String(10);
  BCDRate : Decimal(24, 9);
  SWSRate : Decimal(24, 9);
  OverseasFreightVendor : String(10);
  DomesticFreightVendor : String(10);
  InsuranceVendor : String(10);
  Miscvendor : String(10);
};

@cds.external : true
@cds.persistence.skip : true
@sap.creatable : 'false'
@sap.updatable : 'false'
@sap.deletable : 'false'
@sap.content.version : '1'
@sap.label : 'Value Help for Tax Code'
entity CustomDutyInvoiceSrv.TaxCodeVH {
  @sap.display.format : 'UpperCase'
  @sap.label : 'Tax Code'
  @sap.quickinfo : 'Tax on Sales/Purchases Code'
  key TaxCode : String(2) not null;
  @sap.display.format : 'UpperCase'
  @sap.label : 'Procedure'
  @sap.quickinfo : 'Procedure (Pricing, Output Control, Acct. Det., Costing,...)'
  key TaxCalculationProcedure : String(6) not null;
  @sap.label : 'Tax Code Name'
  TaxCodeName : String(50);
};

