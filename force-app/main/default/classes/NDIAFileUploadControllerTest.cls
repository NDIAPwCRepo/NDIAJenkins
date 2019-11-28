//Test Class for covering all methods of file Upload
//Mukul Mishra
//26 Nov 2019
@isTest
public class NDIAFileUploadControllerTest {
    
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
        NDIAFileUploadController.getFiles(lstContentDocLink[0].Id, lstContentDoc[0].Id, 'test class data');
        NDIAFileUploadController.deleteFiles(lstContentDoc[0].Id);
        test.stopTest();
        
        
        
    }
    
}