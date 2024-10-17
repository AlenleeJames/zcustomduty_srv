/* checksum : 28ea4787f41a2a4f9300c84787d1d544 */
@cds.external : true
@CodeList.UnitsOfMeasure : {
  Url: '../../../../default/iwbep/common/0001/$metadata',
  CollectionPath: 'UnitsOfMeasure'
}
@Aggregation.ApplySupported : {
  Transformations: [ 'aggregate', 'groupby', 'filter' ],
  Rollup: #None
}
@Common.ApplyMultiUnitBehaviorForSortingAndFiltering : true
@Capabilities.FilterFunctions : [
  'eq',
  'ne',
  'gt',
  'ge',
  'lt',
  'le',
  'and',
  'or',
  'contains',
  'startswith',
  'endswith',
  'any',
  'all'
]
@Capabilities.SupportedFormats : [ 'application/json', 'application/pdf' ]
@PDF.Features : {
  DocumentDescriptionReference: '../../../../default/iwbep/common/0001/$metadata',
  DocumentDescriptionCollection: 'MyDocumentDescriptions',
  ArchiveFormat: true,
  Border: true,
  CoverPage: true,
  FitToPage: true,
  FontName: true,
  FontSize: true,
  Margin: true,
  Padding: true,
  Signature: true,
  HeaderFooter: true,
  ResultSizeDefault: 20000,
  ResultSizeMaximum: 20000,
  IANATimezoneFormat: true,
  Treeview: true
}
@Capabilities.KeyAsSegmentSupported : true
@Capabilities.AsynchronousRequestsSupported : true
service STIHL_B2B_K4Q100_BASIC {};

@cds.external : true
@cds.persistence.skip : true
@Common.Label : 'Plant'
@Capabilities.SearchRestrictions.Searchable : true
@Capabilities.SearchRestrictions.UnsupportedExpressions : #phrase
@Capabilities.InsertRestrictions.Insertable : false
@Capabilities.DeleteRestrictions.Deletable : false
@Capabilities.UpdateRestrictions.Updatable : false
@Capabilities.UpdateRestrictions.QueryOptions.SelectSupported : true
entity STIHL_B2B_K4Q100_BASIC.PlantVH {
  @Common.Text : PlantName
  @Common.IsUpperCase : true
  @Common.Label : 'Plant'
  @Common.Heading : 'Plnt'
  key Plant : String(4) not null;
  @Common.Label : 'Plant Name'
  PlantName : String(30) not null;
};

@cds.external : true
@cds.persistence.skip : true
@Common.Label : 'Supplier'
@Capabilities.SearchRestrictions.Searchable : true
@Capabilities.SearchRestrictions.UnsupportedExpressions : #phrase
@Capabilities.InsertRestrictions.Insertable : false
@Capabilities.DeleteRestrictions.Deletable : false
@Capabilities.UpdateRestrictions.Updatable : false
@Capabilities.UpdateRestrictions.QueryOptions.SelectSupported : true
entity STIHL_B2B_K4Q100_BASIC.POVendorVH {
  @Common.Text : BPSupplierName
  @Common.IsUpperCase : true
  @Common.Label : 'Supplier'
  @Common.QuickInfo : 'Account Number of Supplier'
  key Supplier : String(10) not null;
  @Common.Label : 'Supplier Name1'
  @Common.QuickInfo : 'Supplier Name'
  @Common.Heading : 'Name'
  SupplierName : String(35) not null;
  @Common.Label : 'Business Partner Name1'
  @Common.QuickInfo : 'Business Partner Name1'
  @Common.Heading : 'Name'
  BusinessPartnerName1 : String(40) not null;
  @Common.Label : 'Business Partner Supplier Name'
  @Common.Heading : 'Supplier Name'
  @Common.QuickInfo : 'Supplier Name'
  BPSupplierName : String(81) not null;
  @Common.IsUpperCase : true
  @UI.HiddenFilter : true
  @Common.Label : 'Authorization'
  @Common.Heading : 'AuGr'
  @Common.QuickInfo : 'Authorization Group'
  AuthorizationGroup : String(4) not null;
  @Common.IsUpperCase : true
  @UI.HiddenFilter : true
  @Common.Label : 'Account Group'
  @Common.Heading : 'Group'
  @Common.QuickInfo : 'Supplier Account Group'
  SupplierAccountGroup : String(4) not null;
  @Common.IsUpperCase : true
  @UI.HiddenFilter : true
  @Common.Label : 'Purpose Completed'
  @Common.Heading : 'Business Purpose Completed Flag'
  @Common.QuickInfo : 'Business Purpose Completed Flag'
  IsBusinessPurposeCompleted : String(1) not null;
  @Common.Label : 'Business Partner'
  @Common.IsUpperCase : true
  @Common.Heading : 'Business Partner'
  @Common.QuickInfo : 'Business Partner Number'
  BusinessPartner : String(10) not null;
  @Common.Label : 'Business Partner Type'
  @Common.IsUpperCase : true
  @Common.Heading : 'Type'
  @Common.QuickInfo : 'Business Partner Type'
  BusinessPartnerType : String(4) not null;
  @Common.IsUpperCase : true
  @UI.HiddenFilter : true
  @Common.Label : 'Data Ctrlr. Set'
  @Common.Heading : 'Data Controller Set Flag'
  @Common.QuickInfo : 'BP: Data Controller Set Flag'
  DataControllerSet : String(1) not null;
  @Common.IsUpperCase : true
  @UI.HiddenFilter : true
  @Common.Label : 'Data Controller'
  @Common.QuickInfo : 'BP: Data Controller (Internal Use Only)'
  DataController1 : String(30) not null;
  @Common.IsUpperCase : true
  @UI.HiddenFilter : true
  @Common.Label : 'Data Controller'
  @Common.QuickInfo : 'BP: Data Controller (Internal Use Only)'
  DataController2 : String(30) not null;
  @Common.IsUpperCase : true
  @UI.HiddenFilter : true
  @Common.Label : 'Data Controller'
  @Common.QuickInfo : 'BP: Data Controller (Internal Use Only)'
  DataController3 : String(30) not null;
  @Common.IsUpperCase : true
  @UI.HiddenFilter : true
  @Common.Label : 'Data Controller'
  @Common.QuickInfo : 'BP: Data Controller (Internal Use Only)'
  DataController4 : String(30) not null;
  @Common.IsUpperCase : true
  @UI.HiddenFilter : true
  @Common.Label : 'Data Controller'
  @Common.QuickInfo : 'BP: Data Controller (Internal Use Only)'
  DataController5 : String(30) not null;
  @Common.IsUpperCase : true
  @UI.HiddenFilter : true
  @Common.Label : 'Data Controller'
  @Common.QuickInfo : 'BP: Data Controller (Internal Use Only)'
  DataController6 : String(30) not null;
  @Common.IsUpperCase : true
  @UI.HiddenFilter : true
  @Common.Label : 'Data Controller'
  @Common.QuickInfo : 'BP: Data Controller (Internal Use Only)'
  DataController7 : String(30) not null;
  @Common.IsUpperCase : true
  @UI.HiddenFilter : true
  @Common.Label : 'Data Controller'
  @Common.QuickInfo : 'BP: Data Controller (Internal Use Only)'
  DataController8 : String(30) not null;
  @Common.IsUpperCase : true
  @UI.HiddenFilter : true
  @Common.Label : 'Data Controller'
  @Common.QuickInfo : 'BP: Data Controller (Internal Use Only)'
  DataController9 : String(30) not null;
  @Common.IsUpperCase : true
  @UI.HiddenFilter : true
  @Common.Label : 'Data Controller'
  @Common.QuickInfo : 'BP: Data Controller (Internal Use Only)'
  DataController10 : String(30) not null;
};

@cds.external : true
@cds.persistence.skip : true
@Common.Label : 'API View - Customs Invoice Details'
@Capabilities.SearchRestrictions.Searchable : false
@Capabilities.InsertRestrictions.Insertable : false
@Capabilities.DeleteRestrictions.Deletable : false
@Capabilities.UpdateRestrictions.Updatable : false
@Capabilities.UpdateRestrictions.QueryOptions.SelectSupported : true
@Capabilities.FilterRestrictions.FilterExpressionRestrictions : [
  {
    Property: POQuantity,
    AllowedExpressions: 'MultiValue'
  },
  {
    Property: GRQuantity,
    AllowedExpressions: 'MultiValue'
  }
]
entity STIHL_B2B_K4Q100_BASIC.ZA_MM_CustomDutyInvDetails {
  @Common.IsUpperCase : true
  @Common.Label : 'Delivery'
  key IBDNumber : String(10) not null;
  @Common.IsDigitSequence : true
  @Common.Label : 'Item'
  @Common.QuickInfo : 'Delivery Item'
  key IBDItemNumber : String(6) not null;
  @Common.IsUpperCase : true
  @Common.Label : 'Plant'
  @Common.Heading : 'Plnt'
  Plant : String(4) not null;
  @Common.IsUpperCase : true
  @Common.Label : 'Product'
  @Common.QuickInfo : 'Product Number'
  Material : String(18) not null;
  @Common.IsUpperCase : true
  @Common.Label : 'Purchase Order'
  @Common.Heading : 'Purchase Order Number'
  @Common.QuickInfo : 'Purchase Order Number'
  PurchaseorderNumber : String(10) not null;
  @Common.IsDigitSequence : true
  @Common.Label : 'Purchase Order Item'
  @Common.Heading : 'Item Number of Purchase Order'
  @Common.QuickInfo : 'Item Number of Purchase Order'
  POItemNumber : String(5) not null;
  @Common.IsUpperCase : true
  @Common.Label : 'Supplier'
  POVendor : String(10) not null;
  @Common.IsUpperCase : true
  @Common.Label : 'Reference'
  @Common.QuickInfo : 'Reference Document Number'
  InvoiceNumber : String(25) not null;
  @Measures.Unit : PurchaseOrderQuantityUnit
  @Common.Label : 'Order Quantity'
  @Common.Heading : 'PO Quantity'
  @Common.QuickInfo : 'Purchase Order Quantity'
  POQuantity : Decimal(13, 3) not null;
  @Measures.Unit : PurchaseOrderQuantityUnit
  @Common.Label : 'Quantity'
  GRQuantity : Decimal(13, 3) not null;
  @Common.IsUnit : true
  @Common.Label : 'Order Unit'
  @Common.Heading : 'OUn'
  @Common.QuickInfo : 'Purchase Order Unit of Measure'
  PurchaseOrderQuantityUnit : String(3) not null;
  @Common.IsUpperCase : true
  @Common.Label : 'Control Code'
  @Common.QuickInfo : 'Control code for consumption taxes in foreign trade'
  HSNCode : String(16) not null;
  BCDVendor : String(10) not null;
  SWSVendor : String(10) not null;
  BCDRate : Decimal(24, 9) not null;
  SWSRate : Decimal(24, 9) not null;
  OverseasFreightVendor : String(10) not null;
  DomesticFreightVendor : String(10) not null;
  InsuranceVendor : String(10) not null;
  Miscvendor : String(10) not null;
};

