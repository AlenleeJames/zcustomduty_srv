using {CustomDutyAppSrv as service} from './CustomDutyApp-service';

annotate service.ConditionTypesMapping with @odata.draft.enabled;

/*---------->>[ service.ConditionTypesMapping - Generic Actions ]<<----------*/

// Create Action
annotate service.ConditionTypesMapping with @(
    Capabilities.Insertable: true
);

// update / edit Action
annotate service.ConditionTypesMapping with @(
    Capabilities.Updatable: true
);

//Delete Action
annotate service.ConditionTypesMapping with @(
    Capabilities.Deletable: true
);
