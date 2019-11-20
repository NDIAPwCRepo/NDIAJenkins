trigger NDIAChatterGrpTrigger on CollaborationGroup (before insert) {

   
    NDIAChatterGrpTriggerHandler objNDIAChatterGrpTriggerHandler = new NDIAChatterGrpTriggerHandler();
    if(trigger.isBefore & trigger.isInsert){
        objNDIAChatterGrpTriggerHandler.checkMultiplePvtChtGrp(trigger.new);
    }
}