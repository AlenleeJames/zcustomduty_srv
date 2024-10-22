using API_SUPPLIERINVOICE_PROCESS_SRV as SupplierInvPost from './external/API_SUPPLIERINVOICE_PROCESS_SRV';

using CustomDutyInvoiceSrv as S4Services from './external/CustomDutyInvoiceSrv';
using { customduty.serviceAPI as data} from '../db/CustomDutyApp';

using {
    Currency
} from '@sap/cds/common';

using { DutyMaster } from '../db/CustomDutyCommon';


service CustomDutyAppSrv {
    @readonly
    entity POVendorVH as projection on S4Services.POVendorVH
    {        key Supplier, SupplierName, BusinessPartnerName1, BPSupplierName, AuthorizationGroup, SupplierAccountGroup, IsBusinessPurposeCompleted, BusinessPartner, BusinessPartnerType, DataControllerSet, DataController1, DataController2, DataController3, DataController4, DataController5, DataController6, DataController7, DataController8, DataController9, DataController10     }    
;
    @readonly
    entity PlantVH as projection on S4Services.PlantVH
    {        key Plant, PlantName     }    
;
    @readonly
    entity ZA_MM_CustomDutyInvDetails as projection on S4Services.ZA_MM_CustomDutyInvDetails
    {        key IBDNumber, key IBDItemNumber, Plant, Material, PurchaseorderNumber, POItemNumber, POVendor, InvoiceNumber, POQuantity, GRQuantity, PurchaseOrderQuantityUnit, HSNCode, BCDVendor, SWSVendor, BCDRate, SWSRate, OverseasFreightVendor, DomesticFreightVendor, InsuranceVendor, Miscvendor     }    
;

  
    entity SupplierInvoice as projection on SupplierInvPost.A_SupplierInvoice;
   
   //Deep strucure to post Invoice
    type SuplrInvcItemPurOrdRef {
    SupplierInvoiceItem           : String(5);   // "1"
    PurchaseOrder                 : String(10);  // "4500000070"
    PurchaseOrderItem             : String(5);   // "10"
    Plant                         : String(10);  // "IN10"
    TaxCode                       : String(2);   // "K1"
    DocumentCurrency              : String(3);    // "INR"
    SupplierInvoiceItemAmount     : Decimal(15,2); // "2000.00"
    PurchaseOrderQuantityUnit     : String(3);   // "PC"
    QuantityInPurchaseOrderUnit   : Decimal(13,3); // "10"
    PurchaseOrderPriceUnit        : String(3);   // "PC"
    QtyInPurchaseOrderPriceUnit   : Decimal(13,3); // "10"
    SuplrInvcDeliveryCostCndnType : String(4);   // "ZFR1"
    FreightSupplier               : String(10);  // "1000011"
    TaxDeterminationDate          : Date;    // "2024-10-21T01:01:01"
}
//Deep strucure to post Invoice
type CustomInvoiceHdr {    
    FiscalYear                    : String(4);   // "2024"
    CompanyCode                   : String(10);  // "IN10"
    DocumentDate                  : Date;    // "2024-10-21T01:01:01"
    PostingDate                   : Date;    // "2024-10-21T01:01:01"
    SupplierInvoiceIDByInvcgParty : String(10);  // "FREIGHT"
    InvoicingParty                : String(10);  // "1000011"
    DocumentCurrency              : String(3);    // "INR"
    InvoiceGrossAmount            : Decimal(15,2); // "2000.00"
    BusinessPlace                 : String(5);   // "MH01"
    TaxDeterminationDate          : Date;
    TaxReportingDate              : Date;
    TaxFulfillmentDate            : Date;
    to_SuplrInvcItemPurOrdRef     : many SuplrInvcItemPurOrdRef;
}  


//Action to Post Invoice
    action PostSupplierInvoice(InvoiceData: CustomInvoiceHdr) returns CustomInvoiceHdr;

//Action to Calculate Custom Duty Based on File Input
    action calculateDuty(fileData: DutyMaster) returns DutyMaster;

    //Entities for CustomDuty Master Data
    //entity CustomDutyMaster as select from data.CustomDutyMaster;
    entity CustomDutyMaster       as projection on data.CustomDutyMaster;
    
    //Entities of Configuration tables    
    entity CHAFileFieldsOrderList as projection on data.CHAFileFieldsOrderList;


}

