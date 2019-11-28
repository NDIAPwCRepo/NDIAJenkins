/*This trigger is written to cover quotation trigger
----------------------------------Mukul Mishra--------------------------
----------------------------------04/11/2019----------------------------
------------------------------User story -0006 ------------------------- */
@isTest
public class NDIAQuoteTriggerTest {
    @isTest
    public static void checkSharing()
    {
        NDIATriggerSwitch__c objTriggerSwitch=NDIATestDataFactory.createTriggerSwitch();
        Account objCustomer= NDIATestDataFactory.createCustomer();
        insert objCustomer;
        Quotation__c objQuotation=NDIATestDataFactory.createQuotation(objCustomer.Id);
        insert objQuotation;
        system.debug('objQuotation'+objQuotation);
        
        
        test.startTest();
        list<ContentDocument> lstContentDoc= NDIATestDataFactory.createContentDocument();
        List<ContentDocumentLink> lstContentDocLink= NDIATestDataFactory.insertContentDocumentLink();
        for(ContentDocumentLink objContentDocumentLink: lstContentDocLink )
        {
            objContentDocumentLink.LinkedEntityId=objQuotation.id;
            objContentDocumentLink.ContentDocumentId=lstContentDoc[0].Id;
        }
        insert lstContentDocLink;
        objQuotation.NDIAWeeklyServiceBookingValue__c=3.10;
        objQuotation.NDIAQuoteStage__c='Final';
        update objQuotation;
        objQuotation.NDIAQuoteStage__c='Submitted';
        
        update objQuotation;
        test.stopTest();
        
    }
    
}