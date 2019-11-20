/*-*******************************************************************-
---------------This triggerHandler is written to handle all-------------
-----------------the scenarios on quotation object----------------------
----------------------------------Mukul Mishra--------------------------
----------------------------------04/11/2019----------------------------
------------------------------User story -0006 -------------------------
--**********************************************************************/
public class NDIAQuoteTriggerHandler {
    
    public string quotationApproveStage=System.Label.QuotationApproveStage;
    public  string ndiaPublicGroupName=System.Label.NDIAPublicGroupName;
    
    //This method is written to allow to share submitted quote object 
    //and their parent customer records
    public void shareQuoteandCustomer(List<Quotation__c> triggerNew)
    {
        List<Quotation__Share> quoteShares = new List<Quotation__Share>();
        List<AccountShare> customerShares = new List<AccountShare>();
        Set<Id> quoteIds = new Set<Id>();
        List<Group> NDIAUSER=[SELECT Id, DeveloperName, (SELECT Id, UserOrGroupId FROM GroupMembers)FROM Group where DeveloperName=:ndiaPublicGroupName];
        
        for( Quotation__c objQuote :triggerNew)
        {
            //  if(objQuote.Record_Transfer_Request__c == True||(Trigger.oldMap.get(objQuote.NDIAQuoteStage__c)!=Trigger.newMap.get(objQuote.NDIAQuoteStage__c)))
            // {
            if( String.isNotBlank(objQuote.NDIAQuoteStage__c) && objQuote.NDIAQuoteStage__c== quotationApproveStage  && objQuote.NDIANDISParticipant__c)
            {
                quoteIds.add(objQuote.Id);
                //Inserting quote record
                Quotation__Share objQuotShare= new Quotation__Share();
                objQuotShare.ParentId= objQuote.Id;
                objQuotShare.AccessLevel = 'edit';
                objQuotShare.UserOrGroupId = NDIAUSER[0].Id;
                quoteShares.add(objQuotShare);
                system.debug('objQuotShare'+objQuotShare);
                //Inserting customer record
                AccountShare objCustomerShare= new AccountShare();
                objCustomerShare.AccountId= objQuote.NDIAAccount__c;
                objCustomerShare.AccountAccessLevel = 'edit';
                objCustomerShare.OpportunityAccessLevel = 'edit';
                objCustomerShare.UserOrGroupId = NDIAUSER[0].Id;
                customerShares.add(objCustomerShare);
                system.debug('objCustomerShare'+objCustomerShare);
                
                
            }
            If(!quoteIds.isEmpty())
            {
                list<ContentDocumentLink> lstFiles=  [SELECT LinkedEntityId,ContentDocumentId
                                                      FROM ContentDocumentLink where LinkedEntityId In:quoteIds
                                                     ]; 
            }
            Database.SaveResult[] quoteShareInsertResult = Database.insert(quoteShares,false);
            Database.SaveResult[] accountShareInsertResult = Database.insert(customerShares,false);
            system.debug('accountShareInsertResult@'+accountShareInsertResult);
            system.debug('quoteShareInsertResult@'+quoteShareInsertResult);
            //}
        }
    }
    
    // added by Varun on 14-11-2019
    public void quoteFileCheck(list<Quotation__c> qList){
        Map<Id,Integer> quoteIdToFileCount =new Map<Id,Integer>();
        Set<Id> quoteIds = new Set<Id>();
        for(Quotation__c q : qList)
        {
            if(q.NDIAQuoteStage__c == 'Final')
            {
                quoteIds.add(q.Id);
            }
        }
        IF(!quoteIds.isEmpty())
        {
            list<AggregateResult> lstFiles=  [SELECT LinkedEntityId quoteId,COUNT(ContentDocumentId) fileCount
                                              FROM ContentDocumentLink where LinkedEntityId in:quoteIds
                                              GROUP BY LinkedEntityId]; 
            if(!lstFiles.isEmpty())
            {
                for(AggregateResult aggResult:lstFiles)
                { 
                    quoteIdToFileCount.put((Id)aggResult.get('quoteId'),(Integer)aggResult.get('fileCount'));
                }
                system.debug('quoteIdToFileCount@@'+quoteIdToFileCount);
                
            }
            for(Quotation__c objQuote : qList)
            {
                IF(!quoteIdToFileCount.ContainsKey(objQuote.Id))
                {
                    objQuote.addError('Kindly add atleast one file'); 
                }
            } 
        }
        
    }
}