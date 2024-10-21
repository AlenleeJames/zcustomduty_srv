using STIHL_B2B_K4Q100_BASIC as S4Services from './external/STIHL_B2B_K4Q100_BASIC.cds';
using { customduty.serviceAPI as data} from '../db/CustomDutyApp';

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

    //Entities for CustomDuty Master Data
    //entity CustomDutyMaster as select from data.CustomDutyMaster;
    entity CustomDutyMaster       as projection on data.CustomDutyMaster;
    
    //Entities of Configuration tables    
    entity ConditionTypesMapping  as projection on data.ConditionTypesMapping;
    entity DefaultTaxCodes        as projection on data.DefaultTaxCodes;
    entity DefaultVendors         as projection on data.DefaultVendors;
    entity PlantCodes             as projection on data.PlantCodes;
    entity MaterialCodes          as projection on data.MaterialCodes;
    entity CurrencyCodes          as projection on data.CurrencyCodes;
    entity ExchangeRates          as projection on data.ExchangeRates;
    entity CHAFileFieldsOrderList as projection on data.CHAFileFieldsOrderList;
    entity Messages               as projection on data.Messages;  

    //Calculate Logic
    @requires: 'authenticated-user'
    action calculateCHA_ExcelData ();

}
