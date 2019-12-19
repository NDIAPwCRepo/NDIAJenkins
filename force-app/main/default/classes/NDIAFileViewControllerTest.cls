//Test Class for covering all methods of File View Controller
//Mukul Mishra
//26 Nov 2019
@isTest
public class NDIAFileViewControllerTest {
    
    @isTest
    public static void  getFiles()
    {
        Account objCustomer= NDIATestDataFactory.createCustomer();
        insert objCustomer;
        Quotation__c objQuotation=NDIATestDataFactory.createQuotation(objCustomer.Id);
        insert objQuotation;
        list<ContentDocument> lstContentDoc= NDIATestDataFactory.createContentDocument();
        List<ContentDocumentLink> lstContentDocLink= NDIATestDataFactory.insertContentDocumentLink();
        for(ContentDocumentLink objContentDocumentLink: lstContentDocLink )
        {
            objContentDocumentLink.LinkedEntityId=objQuotation.id;
            objContentDocumentLink.ContentDocumentId=lstContentDoc[0].Id;
        }
        insert lstContentDocLink;
        test.startTest();
        NDIAFileViewController.getContentDocs(objQuotation.Id);
        list<ContentDocumentLink> contentDocuments=[SELECT ContentDocumentId,ContentDocument.Title,ContentDocument.FileType,ContentDocument.Description,ContentDocument.CreatedDate,LinkedEntityId
                                                        FROM ContentDocumentLink where LinkedEntityId=:objQuotation.Id LIMIT 3];
        system.assertNotEquals(contentDocuments.size(), 0);
        test.stopTest();
        
    }
    @isTest
    public static void  getViews()
    {
        Account objCustomer= NDIATestDataFactory.createCustomer();
        Quotation__c objQuotation=NDIATestDataFactory.createQuotation(objCustomer.Id);
        insert objQuotation;
        list<ContentDocument> lstContentDoc= NDIATestDataFactory.createContentDocument();
        List<ContentDocumentLink> lstContentDocLink= NDIATestDataFactory.insertContentDocumentLink();
        for(ContentDocumentLink objContentDocumentLink: lstContentDocLink )
        {
            objContentDocumentLink.LinkedEntityId=objQuotation.id;
            objContentDocumentLink.ContentDocumentId=lstContentDoc[0].Id;
        }
        insert lstContentDocLink;
        test.startTest();
        NDIAFileViewController.getDownloads(objQuotation.Id,5);
        NDIAFileViewController.getViews(objQuotation.Id,5);
        list<ContentDocumentLink> contentDocuments=[SELECT ContentDocumentId,ContentDocument.Title,ContentDocument.FileType,ContentDocument.Description,ContentDocument.CreatedDate,LinkedEntityId
                                                        FROM ContentDocumentLink where LinkedEntityId=:objQuotation.Id LIMIT 3];
        system.assertNotEquals(contentDocuments.size(), 0);
        test.stopTest();
        
    }
}