namespace customduty.serviceAPI;

using {
    Currency,
    cuid,
    managed,
    sap
} from '@sap/cds/common';

entity CustomDutyMaster : managed, cuid {
    CountryOfOrigin        : String(111);
    BENo                   : String(111);
    BEDate                 : String(111);
    HAWB_HBLDate           : String(111);
    TotalBCD               : String(111);
    TotalSWS               : String(111);
    TotalIGST              : String(111);
    TotalAmount            : String(111);
    InvoiceNumber          : String(111);
    Invoicedate            : String(111);
    InvoiceValueFC         : String(111);
    InvoiceCurrency        : String(111);
    ExcRateforInvoice      : String(111);
    OverseasFreightAmount  : String(111);
    FreightPercentage      : String(111);
    FreightCurrency        : String(111);
    FreightExrate          : String(111);
    DomesticFreightAmount  : String(111);
    InsuranceAmount        : String(111);
    InsurancePercentage    : String(111);
    InsuranceCurrency      : String(111);
    InsuranceExrate        : String(111);
    MiscCharges            : String(111);
    Material               : String(111);
    ProductDescription     : String(111);
    PurchaseOrder          : String(111);
    PurchaseorderItem      : String(111);
    HSNCodefromCHA         : String(111);
    HSNCodeSystem          : String(111);
    UnitPrice              : String(111);
    Quantity               : String(111);
    OpenPOQty              : String(111);
    Unit                   : String(111);
    BCDAmount              : String(111);
    RateofBCDPercent       : String(111);
    SocWelSurDutyAmt       : String(111);
    SocWelSurDutyPer       : String(111);
    IGST                   : String(111);
    IGSTRateDutyPer        : String(111);
    AssessableValue        : String(111);
    OverFreightperitem     : String(111);
    DomesticFreightperitem : String(111);
    Inschargesperitem      : String(111);
    Miscchargesperitem     : String(111);
    CustomInvoiceVendor    : String(111);
    CustomInvoice          : String(111);
    OverFreightVendor      : String(111);
    OverFreighInvoice      : String(111);
    DomFreightVendor       : String(111);
    DomFreightInvoice      : String(111);
    InsuranceVendor        : String(111);
    InsInvoNum             : String(111);
    MiscChargesVen         : String(111);
    MiscChargeInvoice      : String(111);
    Remarks                : String(111);
}

entity ConditionTypesMapping : cuid {
    Identifier     : Integer;
    Description    : String;
    ConditionTable : String;
    ConditionType  : String;
}

entity DefaultTaxCodes : cuid {
    TaxCode : String;
}

entity DefaultVendors : cuid {
    VendorType : String;
    VendorCode : String
}

entity PlantCodes : cuid {

}

entity MaterialCodes : cuid {
    ContentName : String;
    ContentFrom : String;
    ContentTo   : String;
}

entity CurrencyCodes : cuid {

}

entity ExchangeRates : cuid {

}

entity CHAFileFieldsOrderList : cuid {
    FieldName             : String;
    CHAFileColumnPosition : String;

}

entity Messages : cuid {
    ValidationCode : String;
    WarningOrError : String;

}