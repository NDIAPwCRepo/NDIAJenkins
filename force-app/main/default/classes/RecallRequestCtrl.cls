public without sharing class RecallRequestCtrl {
    
    @AuraEnabled 
    public static String reCallApprovalRequest(String recordId)
    {
        List<Quotation__c> lstQuotes=[SELECT id,NDIAQuoteStage__c FROM Quotation__c where id=:recordId 
                                      AND NDIAQuoteStage__c!='Approval In Progress'];
                                          
        IF(!lstQuotes.isEmpty())
        {
        ProcessInstanceWorkitem[] workItems = [ SELECT Id
                                               FROM ProcessInstanceWorkitem 
                                               WHERE ProcessInstance.TargetObjectId =:recordId];
      
        if(!workItems.isEmpty())
        {
            Approval.ProcessWorkitemRequest pwr = new Approval.ProcessWorkitemRequest();  
            pwr.setAction('Removed');
            pwr.setWorkItemId(workItems[0].id);
            Approval.ProcessResult result = Approval.process(pwr);
            return null;
        }
        }
       
        return 'You can not recall the as it is In Progress';
        
        
        
    }
}