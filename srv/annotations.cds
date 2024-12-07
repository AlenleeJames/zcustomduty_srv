using {CustomDutyAppSrv as service} from './CustomDutyApp-service';

annotate service.CHAFileFieldsOrderList with @odata.draft.enabled;

/*---------->>[ service.CHAFileFieldsOrderList - Generic Actions ]<<----------*/

// Create Action
annotate service.CHAFileFieldsOrderList with @(
    Capabilities.Insertable: true
);

// update / edit Action
annotate service.CHAFileFieldsOrderList with @(
    Capabilities.Updatable: true
);

//Delete Action
annotate service.CHAFileFieldsOrderList with @(
    Capabilities.Deletable: true
);


//annotate service.CustomDutyFieldMapping with @odata.draft.enabled;

/*---------->>[ service.CHAFileFieldsOrderList - Generic Actions ]<<----------*/

// Create Action
annotate service.CustomDutyFieldMapping with @(
    Capabilities.Insertable: true
);

// update / edit Action
annotate service.CustomDutyFieldMapping with @(
    Capabilities.Updatable: true
);

//Delete Action
annotate service.CustomDutyFieldMapping with @(
    Capabilities.Deletable: true
);

annotate service.CustomDutyFieldMapping with @(
    UI: {

      SelectionFields: [ Source],
        LineItem: [
            {Value: Source,
            Label:'Source'},
            {Value: InputFields,
            Label:'Input Fields'},
            {Value: OutputFields,
            Label:'Output Fields'},
            {Value: Visibility,
            Label:'Visibility'},
             {Value: Type,
            Label:'Type'},
             {Value: Scale,
            Label:'Scale'}
            
        ],
        //To add header info
   Identification: [
            {Value: Source,
            Label:'Source'},
            {Value: InputFields,
            Label:'Input Fields'},
            {Value: OutputFields,
            Label:'Output Fields'},
            {Value: Visibility,
            Label:'Visibility'},
             {Value: Type,
            Label:'Type'},
             {Value: Scale,
            Label:'Scale'}
        ]
});


annotate service.CustomDutyParam with @odata.draft.enabled; 
/*---------->>[ service.CHAFileFieldsOrderList - Generic Actions ]<<----------*/

// Create Action
annotate service.CustomDutyParam with @(
    Capabilities.Insertable: true
);

// update / edit Action
annotate service.CustomDutyParam with @(
    Capabilities.Updatable: true
);

//Delete Action
annotate service.CustomDutyParam with @(
    Capabilities.Deletable: true
);

annotate service.CustomDutyParam with @(
    UI: {

      SelectionFields: [ParamID],
        LineItem: [
            {Value: ParamID,
            Label:'Parameter ID'},
            {Value: ParamName,
            Label:'Parameter Name'},
            {Value: Sequence,
            Label:'Sequence'},
            {Value: Description,
            Label:'Description'},
             {Value: Value1,
            Label:'Value 1'},
            {Value: Value2,
            Label:'Value 2'},
            {Value: Value3,
            Label:'Value 3'},
            {Value: Value4,
            Label:'Value 4'},
            {Value: Value5,
            Label:'Value 5'}            
        ],
        //To add header info
        Identification: [
            {Value: ParamID,
            Label:'Parameter ID'},
            {Value: ParamName,
            Label:'Parameter Name'},
            {Value: Sequence,
            Label:'Sequence'},
            {Value: Description,
            Label:'Description'},
             {Value: Value1,
            Label:'Value 1'},
            {Value: Value2,
            Label:'Value 2'},
            {Value: Value3,
            Label:'Value 3'},
            {Value: Value4,
            Label:'Value 4'},
            {Value: Value5,
            Label:'Value 5'} 
        ]
});