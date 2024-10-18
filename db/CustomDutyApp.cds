namespace customduty.serviceAPI;

using {
    Currency,
    cuid,
    managed,
    sap
} from '@sap/cds/common';

entity CustomDutyMaster : managed, cuid {
    CountryOfOrigin        : String(100);
    BENo                   : String(10);
    BEDate                 : Date;
    HAWB_HBLDate           : Date;
    TotalBCD               : Decimal(13, 3);
    TotalSWS               : Decimal(13, 3);
    TotalIGST              : Decimal(13, 3);
    TotalAmount            : Decimal(13, 3);
    InvoiceNumber          : String(10);
    Invoicedate            : Date;
    InvoiceValueFC         : Decimal(13, 3);
    InvoiceCurrency        : Currency;
    ExcRateforInvoice      : Decimal(9, 5);
    OverseasFreightAmount  : Decimal(13, 3);
    FreightPercentage      : Decimal(5, 0);
    FreightCurrency        : Currency;
    FreightExrate          : Decimal(9, 5);
    DomesticFreightAmount  : Decimal(13, 3);
    InsuranceAmount        : Decimal(13, 3);
    InsurancePercentage    : Decimal(5, 0);
    InsuranceCurrency      : Currency;
    InsuranceExrate        : Decimal(5, 0);
    MiscCharges            : Decimal(13, 3);
    Material               : String(40);
    ProductDescription     : String(40);
    PurchaseOrder          : String(10);
    PurchaseorderItem      : Decimal(5, 0);
    HSNCodefromCHA         : String(10);
    HSNCodeSystem          : String(10);
    UnitPrice              : Decimal(13, 3);
    Quantity               : Decimal(13, 3);
    OpenPOQty              : Decimal(13, 3);
    Unit                   : String(3);
    BCDAmount              : Decimal(13, 3);
    RateofBCDPercent       : Decimal(5, 0);
    SocWelSurDutyAmt       : Decimal(13, 3);
    SocWelSurDutyPer       : Decimal(5, 0);
    IGST                   : Decimal(13, 3);
    IGSTRateDutyPer        : Decimal(5, 0);
    AssessableValue        : Decimal(13, 3);
    OverFreightperitem     : Decimal(13, 3);
    DomesticFreightperitem : Decimal(13, 3);
    Inschargesperitem      : Decimal(13, 3);
    Miscchargesperitem     : Decimal(13, 3);
    CustomInvoiceVendor    : String(10);
    CustomInvoice          : String(10);
    OverFreightVendor      : String(10);
    OverFreighInvoice      : String(10);
    DomFreightVendor       : String(10);
    DomFreightInvoice      : String(10);
    InsuranceVendor        : String(10);
    InsInvoNum             : String(10);
    MiscChargesVen         : String(10);
    MiscChargeInvoice      : String(10);
    Remarks                : LargeString;
    status                 : String(10);
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