namespace customduty.serviceAPI;

using {
    Currency,
    cuid,
    managed,
    sap
} from '@sap/cds/common';


entity CustomDutyHdr : managed, cuid {
    key ID                  : UUID;
        BENoKey             : String(10);
        Plant               : String(10);
        POVendor            : String(10);
        OverallStatus       : String(20);
        CustomVendInv       : String(10);
        CustomVendor        : String(10);
        CustomVendInvStat   : String(20);
        CustomVendInvMsg    : String;
        OverSeasVendInv     : String(10);
        OverSeasInvHdr      : String(10);
        OverSeasVendor      : String(10);
        OverSeasVendInvStat : String(20);
        OverSeasVendInvMsg  : String;
        DomesticVendInv     : String(10);
        DomesticInvHdr      : String(10);
        DomesticVendor      : String(10);
        DomesticVendInvStat : String(20);
        DomesticVendInvMsg  : String;
        to_CustomDutyItem   : Composition of many CustomDutyItem
                                  on to_CustomDutyItem.BENoKey = $self;
        to_CustomDutyLog    : Composition of many CustomDutyLog
                                  on to_CustomDutyLog.BENoKey = $self;
        to_ValidationLog    : Composition of many ValidationLog
                                  on to_ValidationLog.BENoKey = $self;
}

entity CustomDutyItem : managed, cuid {
    key ID                      : UUID;
        CountryOfOrigin         : String(100);
        PortofOrigin            : String(100);
        BENo                    : String(10);
        BEDate                  : Date;
        IBDNumber               : String(10);
        HAWB_HBLDate            : Date;
        TotalBCD                : Decimal(13, 3);
        TotalSWS                : Decimal(13, 3);
        TotalIGST               : Decimal(13, 3);
        TotalAmount             : Decimal(13, 3);
        InvoiceNumber           : String(10);
        Invoicedate             : Date;
        InvoiceValueFC          : Decimal(13, 3);
        InvoiceCurrency         : Currency;
        InvoiceValueINR         : Decimal(13, 3);
        ExcRateforInvoice       : Decimal(9, 5);
        FreightPercentage       : Decimal(5, 2);
        FreightCurrency         : Currency;
        FreightAmount           : Decimal(13, 3);
        FreightExrate           : Decimal(9, 5);
        OverseasFrtAmtCALC1     : Decimal(13, 3);
        OverseasFrtAmtCALC2     : Decimal(13, 3);
        OverseasFrtAmtTAX1      : String(2);
        OverseasFrtAmtTAX2      : String(2);
        DomesticFrtAmtCALC1     : Decimal(13, 3);
        DomesticFrtAmtCALC2     : Decimal(13, 3);
        DomesticFrtAmtTAX1      : String(2);
        DomesticFrtAmtTAX2      : String(2);
        MiscAmountCALC1         : Decimal(13, 3);
        MiscAmountCALC2         : Decimal(13, 3);
        MiscAmountTAX1          : String(2);
        MiscAmountTAX2          : String(2);
        InsuranceAmTCALC        : Decimal(13, 3);
        InsuranceAmTCALC1       : Decimal(13, 3);
        InsuranceAmTCALC2       : Decimal(13, 3);
        InsuranceAmTTAX1        : String(2);
        InsuranceAmTTAX2        : String(2);
        CustomDutyTAX1          : String(2);
        CustomDutyTAX2          : String(2);
        MiscAmountCHA           : Decimal(13, 3);
        InsuranceAmtCHA         : Decimal(13, 3);
        TermsofInvoice          : String(3);
        RITC                    : String(8);
        ItemSrNo                : Int16;
        InsurancePercentage     : Decimal(5, 2);
        InsuranceCurrency       : Currency;
        InsuranceExrate         : Decimal(5, 2);
        Material                : String(40);
        ProductDescription      : String;
        PurchaseOrder           : String(10);
        PurchaseorderItem       : String(5);
        HSNCodefromCHA          : String(10);
        HSNCodeSystem           : String(10);
        UnitPrice               : Decimal(13, 3);
        Quantity                : Decimal(13, 3);
        OpenPOQty               : Decimal(13, 3);
        Unit                    : String(3);
        BCDAmount               : Decimal(13, 3);
        RateofBCDPercent        : Decimal(5, 2);
        SocWelSurDutyAmt        : Decimal(13, 3);
        SocWelSurDutyPer        : Decimal(5, 2);
        IGST                    : Decimal(13, 3);
        IGSTRateDutyPer         : Decimal(5, 2);
        IGSTNo                  : String(20);
        AssessableValue         : Decimal(13, 3);
        OverFreightperitem1     : Decimal(13, 3);
        OverFreightperitem2     : Decimal(13, 3);
        DomesticFreightperitem1 : Decimal(13, 3);
        DomesticFreightperitem2 : Decimal(13, 3);
        Inschargesperitem1      : Decimal(13, 3);
        Inschargesperitem2      : Decimal(13, 3);
        Miscchargesperitem1     : Decimal(13, 3);
        Miscchargesperitem2     : Decimal(13, 3);
        CustomInvoiceVendor     : String(10);
        CustomInvoice           : String(10);
        OverFreightVendor       : String(10);
        OverFreighInvoice       : String(10);
        DomFreightVendor        : String(10);
        DomFreightInvoice       : String(10);
        InsuranceVendor         : String(10);
        InsInvoNum              : String(10);
        MiscChargesVen          : String(10);
        MiscChargeInvoice       : String(10);
        Remarks                 : LargeString;
        status                  : String(10);
        BENoKey                 : Association to CustomDutyHdr;
}

entity CustomDutyLog : managed, cuid {
    key ID      : UUID;
        type    : String;
        message : String;
        BENoKey : Association to CustomDutyHdr;
}

entity ValidationLog : managed, cuid {
    key ID      : UUID;
        type    : String;
        message : String;
        BENoKey : Association to CustomDutyHdr;
}

entity CustomDutyFieldMapping : managed, cuid {
    key ID           : UUID;
        Source       : String;
        InputFields  : String;
        OutputFields : String;
        Visibility   : Boolean;
        Type         : String;
        Scale        : Int16;
}

//Entities of Configuration tables
entity CHAFileFieldsOrderList : managed, cuid {
    key ID                      : UUID;
        CHAFileFieldName        : String;
        CHAFileFieldColumnValue : String;

}

entity CommonParamTableMaster : managed,cuid {
    key ID      : UUID;
        Element : String;
}

entity CommonParamTableActuals : managed,cuid {
    key ID             : UUID;
        Element        : String;
        CompanyCode    : String;
        ConditionType  : String;
        ConditionTable : String;
        Value1         : String;
        Value2         : String;
}


entity CustomDutyParam : managed,cuid {
    key ID             : UUID;
        ParamID        : String;
        ParamName      : String;
        Sequence       : Int16;
        Description    : String;
        Value1         : String;
        Value2         : String;
        Value3         : String;
        Value4         : String;
        Value5         : String;
}

//Entity for Upload HSN table
entity UploadHSN : managed, cuid {
    key ID              : UUID;
        SupplierCountry : String(2);
        HSNCode         : String(10);
        TaxRate         : Decimal(5,0);
        TaxCode         : String(10);
}