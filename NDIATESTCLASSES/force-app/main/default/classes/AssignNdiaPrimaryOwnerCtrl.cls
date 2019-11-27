public without sharing class AssignNdiaPrimaryOwnerCtrl {
    @AuraEnabled 
    public static String fetchUserToUpdateRecord(String recordId){
        // query current user information  
        List<Quotation__c> lstQuotes=[SELECT id,NDIAQuoteStage__c,NDIA_Primary_Owner__c FROM Quotation__c where id=:recordId]; 
        
        IF(!lstQuotes.isEmpty() && lstQuotes.get(0).NDIA_Primary_Owner__c!=null )
        {
            return 'Primary Owner already assigned for the Quote';
        }
        else
        {
            Quotation__c objQuo = new Quotation__c(id=recordId);   
            lstQuotes.get(0).NDIA_Primary_Owner__c=userInfo.getUserId();
            lstQuotes.get(0).NDIAQuoteStage__c='Approval In Progress';
            update lstQuotes; 
        }
        return null;
    }
}