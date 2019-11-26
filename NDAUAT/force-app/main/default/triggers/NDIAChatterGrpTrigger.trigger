trigger NDIAChatterGrpTrigger on CollaborationGroup (before insert) {
	NDIATriggerSwitch__c switchCGVar = NDIATriggerSwitch__c.getInstance('ChatterGroup');
    if(switchCGVar != NULL && 'False'.equalsIgnorecase(String.valueOf(switchCGVar.isTriggerOn__c)))   { 
        return;
    }
   
    NDIAChatterGrpTriggerHandler objNDIAChatterGrpTriggerHandler = new NDIAChatterGrpTriggerHandler();
    if(trigger.isBefore & trigger.isInsert){
        objNDIAChatterGrpTriggerHandler.checkMultiplePvtChtGrp(trigger.new);
    }
}