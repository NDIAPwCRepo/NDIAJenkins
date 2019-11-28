public without sharing class NDIAFileViewController {
    
    public without sharing class DownloadWrapper{
        @AuraEnabled public Integer pageSize {get;set;}
        @AuraEnabled public Integer page {get;set;}
        @AuraEnabled public Integer total {get;set;}
        @AuraEnabled public String message;
        @AuraEnabled public List<ContentVersionHistory> downloadList;
        @AuraEnabled public Boolean success;
    }
    
    @AuraEnabled
    public static DownloadWrapper getDownloads(id parentid,Decimal pageNumber) {
        //  system.debug(parentid);
        Integer pageSize = 5;
        Integer offset = ((Integer)pageNumber - 1) * pageSize;
        DownloadWrapper downloadWrapper = new DownloadWrapper();
        downloadWrapper.downloadList = [SELECT  id,ContentVersionId, Field, CreatedBy.Name,CreatedDate From ContentVersionHistory Where ContentVersion.ContentDocumentId=:parentid and Field = 'ContentVersionDownloaded'];
        downloadWrapper.pageSize = pageSize;
        downloadWrapper.page = (Integer) pageNumber;
        downloadWrapper.total = [SELECT  count() From ContentVersionHistory Where ContentVersion.ContentDocumentId=:parentid and Field = 'ContentVersionDownloaded'];
        downloadWrapper.message = 'Download records are retrieved ';
        downloadWrapper.success = true;
        
        system.debug('list: '+downloadWrapper);
        return downloadWrapper;
    }
    
    @AuraEnabled
    public static DownloadWrapper getViews(id parentid,Decimal pageNumber) {
        //  system.debug(parentid);
        Integer pageSize = 5;
        Integer offset = ((Integer)pageNumber - 1) * pageSize;
        DownloadWrapper downloadWrapper = new DownloadWrapper();
        try{
            
            system.debug('downloadList@@'+downloadWrapper.downloadList);
            downloadWrapper.pageSize = pageSize;
            downloadWrapper.page = (Integer) pageNumber;
            downloadWrapper.total = [SELECT  count() From ContentVersionHistory Where ContentVersion.ContentDocumentId=:parentid and Field = 'contentVersionUpdated'];
            downloadWrapper.message = 'View records are retrieved ';
            downloadWrapper.success = true;
        }
        catch(Exception e){
            downloadWrapper.message = e.getMessage();
            downloadWrapper.success = false;
        }
        system.debug('list: '+downloadWrapper);
        return downloadWrapper;
    }
    
    //This method is used to fetch the total content documents under one quote object
    //Mukul Mishra
    //14/11/2019
    @AuraEnabled
    public static List<ContentDocumentLink>  getContentDocs(String parentId) {
        system.debug('parentId@'+parentId);
        if(String.isNotBlank(parentId))
        {
            system.debug('parentId@'+parentId);
            list<ContentDocumentLink> contentDocuments=[SELECT ContentDocumentId,ContentDocument.Title,ContentDocument.FileType,ContentDocument.Description,ContentDocument.CreatedDate,LinkedEntityId
                                                        FROM ContentDocumentLink where LinkedEntityId=:parentId LIMIT 3];
            
            system.debug('contentDocuments@@'+contentDocuments);
            return contentDocuments;
            
        }
        
        return null; 
    }
    
}