public class NDIAFileUploadController {
    
    @AuraEnabled  
    public static List<ContentDocument> getFiles(string recordId,string documentId,string description){ 
        // TO avoid following exception 
        // System.QueryException: Implementation restriction: ContentDocumentLink requires
        // a filter by a single Id on ContentDocumentId or LinkedEntityId using the equals operator or 
        // multiple Id's using the IN operator.
        // We have to add sigle record id into set or list to make SOQL query call
        Set<Id> recordIds=new Set<Id>{recordId};
            Set<Id> documentIds = new Set<Id>(); 
        List<ContentDocumentLink> cdl=[SELECT id,LinkedEntityId,ContentDocumentId FROM ContentDocumentLink WHERE LinkedEntityId IN:recordIds];  
        for(ContentDocumentLink cdLink:cdl){  
            documentIds.add(cdLink.ContentDocumentId);
            
        }
        
        List<ContentDocument> contentDocuments=[select id,description from contentdocument where ID =:documentId];
        if(contentDocuments!=null && !contentDocuments.isEmpty())
        {
            for(contentDocument cd: contentDocuments)
            {
                cd.description=description;
                system.debug('cd'+cd);
            }
         
           update contentDocuments;
        }
        return [SELECT Id,Title,FileType FROM ContentDocument WHERE id IN: documentIds];  
    } 
    
    @AuraEnabled  
    public static void deleteFiles(string sdocumentId){ 
        delete [SELECT Id,Title,FileType from ContentDocument WHERE id=:sdocumentId];       
    }  
}