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
