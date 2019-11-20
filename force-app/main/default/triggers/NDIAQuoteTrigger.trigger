/*This trigger is written to handle all the scenarios on quotation object
----------------------------------Mukul Mishra--------------------------
----------------------------------04/11/2019----------------------------
------------------------------User story -0006 ------------------------- */

trigger NDIAQuoteTrigger on Quotation__c (after update,before update) {
    NDIATriggerSwitch__c switchVar = NDIATriggerSwitch__c.getInstance('Quote');
    if(switchVar != NULL && 'False'.equalsIgnorecase(String.valueOf(switchVar.isTriggerOn__c)))   { 
        return;
    }
    NDIAQuoteTriggerHandler objNDIAQuoteTriggerHandler= new NDIAQuoteTriggerHandler();
    
    //Method added by MUKUL
    if(trigger.isBefore && trigger.isUpdate)
    {
        objNDIAQuoteTriggerHandler.quoteFileCheck(trigger.new);
    }
    //Method added by Varun
    if(trigger.isAfter && trigger.isUpdate)
    {
        objNDIAQuoteTriggerHandler.shareQuoteandCustomer(trigger.new);
    }
    
    
}