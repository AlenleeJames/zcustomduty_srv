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
