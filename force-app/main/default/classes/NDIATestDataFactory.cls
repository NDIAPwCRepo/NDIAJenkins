/**
*
* @date: 20-11-2019
* @author: Amiya Das
* @description: Common Test Data Class containing all test data for every sObject
* @param <Input parameter 1>
* @param <Input parameter 2>
*/

public class NDIATestDataFactory {
    
    // create Customer data
    public static Account createCustomer(){
        
        Account objAccount = new Account();
        objAccount.Name='Test Customer';
        objAccount.NDIANDISParticipant__c = true;
        objAccount.NDIANDISNumber__c='12345';
        objAccount.NDIASuburb__c='NSW';
        objAccount.BillingStreet = 'test Street';
        objAccount.BillingCity = 'Perth';
        objAccount.BillingState = 'Victoria';
        objAccount.BillingPostalCode = '4455';
        objAccount.BillingCountry = 'Australia';
        return objAccount;
    }
    //Create Contact Data
    public static List<contact>  createContacts(){
        List<Contact> lstContact= new list<Contact>();
        Contact objContact = new Contact();
        objContact.FirstName = 'Test';
            objContact.Lastname = 'McTesty';
            objContact.Email = 'test@test.com';
            lstContact.add(objContact);
        return lstContact;
    }
    
    
    // create quotation data
    public static Quotation__c createQuotation(string accountId){
        
        system.debug('accountId'+accountId);
        Quotation__c objQuotation = new Quotation__c();
        objQuotation.NDIAAccount__c = accountId;
        objQuotation.NDIAApprovalDate__c = System.today();
        objQuotation.NDIAQuoteType__c = 'SIL';
        objQuotation.NDIAWeeklyApprovedAmount__c = 1.00;
        objQuotation.NDIAWeeklyOfferedAmount__c = 1.00;
        objQuotation.NDIAWeeklyQuotedAmount__c = 2.00; 
        objQuotation.NDIAWeeklyServiceBookingValue__c = 3.00;
        objQuotation.NDIAQuoteStage__c='Not yet commenced';
        
        //  objQuotation.NDIA_Primary_Owner__c = 
        return objQuotation;
    } 
    
    // create quotation data for approval
    public static Quotation__c createQuoteForApproval(string accountId){
        
        Quotation__c objQuotationApproval = new Quotation__c();
        objQuotationApproval.NDIAAccount__c = accountId;
        objQuotationApproval.NDIAApprovalDate__c = System.today();
        objQuotationApproval.NDIAQuoteType__c = 'SIL';
        objQuotationApproval.NDIAWeeklyApprovedAmount__c = 1.00;
        objQuotationApproval.NDIAWeeklyOfferedAmount__c = 1.00;
        objQuotationApproval.NDIAWeeklyQuotedAmount__c = 2.00; 
        objQuotationApproval.NDIAWeeklyServiceBookingValue__c = 3.00;
        objQuotationApproval.NDIAQuoteStage__c='Rejected';
        //  objQuotationApproval.NDIANDIS_Number__c = ndisNum;
        return objQuotationApproval;
    }
    
    
    
    public static Quotation__c createQuotationWithNDIAOwner(string userId, string accountId){
        
        Quotation__c objQuotationWithNDIAOwner = new Quotation__c();
        objQuotationWithNDIAOwner.NDIAAccount__c = accountId;
        objQuotationWithNDIAOwner.NDIAApprovalDate__c = System.today();
        objQuotationWithNDIAOwner.NDIAQuoteType__c = 'SIL';
        objQuotationWithNDIAOwner.NDIAWeeklyApprovedAmount__c = 1.00;
        objQuotationWithNDIAOwner.NDIAWeeklyOfferedAmount__c = 1.00;
        objQuotationWithNDIAOwner.NDIAWeeklyQuotedAmount__c = 2.00; 
        objQuotationWithNDIAOwner.NDIAWeeklyServiceBookingValue__c = 3.00;
        objQuotationWithNDIAOwner.NDIA_Primary_Owner__c = userId;
        return objQuotationWithNDIAOwner;
        
    }
    
    // create quotation with primary owner as null and stage as 'Approval In Progress'
    public static Quotation__c CrQuoteWithoutPriOwner(){
        
        Quotation__c objQuotationApproval1 = new Quotation__c();
        //   objQuotationApproval.NDIAAccount__c = accountId;
        objQuotationApproval1.NDIAApprovalDate__c = System.today();
        objQuotationApproval1.NDIAQuoteType__c = 'SIL';
        objQuotationApproval1.NDIAWeeklyApprovedAmount__c = 1.00;
        objQuotationApproval1.NDIAWeeklyOfferedAmount__c = 1.00;
        objQuotationApproval1.NDIAWeeklyQuotedAmount__c = 2.00; 
        objQuotationApproval1.NDIAWeeklyServiceBookingValue__c = 3.00;
        objQuotationApproval1.NDIAQuoteStage__c='Approval In Progress';
        //   objQuotationApproval1.NDIA_Primary_Owner__c = UserInfo.getUserId();
        //  objQuotationApproval.NDIANDIS_Number__c = ndisNum;
        return objQuotationApproval1;
    }
    
    // title, urlname, Type, NDIAUrl
    // creating knowledge article with latest updates
    public static Knowledge__kav createKnowArtcleWithLatestUpdates(){
        
        Knowledge__kav objKnowArtcleLatesUpd = new Knowledge__kav();
        objKnowArtcleLatesUpd.Title = 'Test NDIA Pricing';
        objKnowArtcleLatesUpd.NDIAUrl__c = 'www.google.com';
        objKnowArtcleLatesUpd.NDIAType__c = 'Latest Updates';
        objKnowArtcleLatesUpd.IsVisibleInCsp = true;
        objKnowArtcleLatesUpd.UrlName = 'test';
        return objKnowArtcleLatesUpd;
    }
    
    public static Knowledge__kav createKnowArtcleWithImpLinks(){
        
        Knowledge__kav objKnowArtcleImpLinks = new Knowledge__kav();
        objKnowArtcleImpLinks.Title = 'Test NDIA Imp Links';
        objKnowArtcleImpLinks.NDIAUrl__c = 'www.google.com';
        objKnowArtcleImpLinks.NDIAType__c = 'Important Links';
        objKnowArtcleImpLinks.IsVisibleInCsp = true;
        objKnowArtcleImpLinks.UrlName = 'test';
        return objKnowArtcleImpLinks;
        
    }
    
    public static CollaborationGroup createTrendingGroups(){
        
        CollaborationGroup objCollaborationGroup1 = new CollaborationGroup();
        objCollaborationGroup1.Name = 'Test Trending Chatter Groups';
        objCollaborationGroup1.CollaborationType = 'Public';
        return objCollaborationGroup1;
    }
    
    public static CollaborationGroup createMyGroups(){
        
        CollaborationGroup objCollaborationGroup2 = new CollaborationGroup();
        objCollaborationGroup2.Name = 'Test My Chatter Groups';
        objCollaborationGroup2.CollaborationType = 'Public';
        return objCollaborationGroup2;
    }
    
    // create Quotation user
    public static User createQuotationUser(){
        
        Profile p = [SELECT Id FROM Profile WHERE Name = 'Quotation']; 
        User objUserQuotation = new User();
        objUserQuotation.email='testquotation@gmail.com'; 
        objUserQuotation.profileId = p.id;                
        objUserQuotation.UserName='testquotaion@fakeemail.com'; 
        objUserQuotation.alias='tuser1';
        objUserQuotation.CommunityNickName='tuser1'; 
        objUserQuotation.TimeZoneSidKey='America/New_York'; 
        objUserQuotation.LocaleSidKey='en_US'; 
        objUserQuotation.EmailEncodingKey='ISO-8859-1'; 
        objUserQuotation.LanguageLocaleKey='en_US';
        objUserQuotation.FirstName = 'Test';
        objUserQuotation.LastName = 'Dummy user' ;
        objUserQuotation.Phone='8989898989';
        objUserQuotation.MobilePhone='8887779990';
        objUserQuotation.IsActive = true; 
        objUserQuotation.NDIA_PaidRequest__c = true;
        objUserQuotation.City = 'Delhi';
        return objUserQuotation;
    }
    
    // create NDIA user
    public static List<User> createNDIAUser(){
        
        Profile p = [SELECT Id FROM Profile WHERE Name = 'NDIAUser']; 
        List<User> ndiaUsers= new List<user>();
        User objUserNDIA = new User();
        objUserNDIA.email='testndiauser@gmail.com'; 
        objUserNDIA.profileId = p.id;                
        objUserNDIA.UserName='testndia@fakeemail.com'; 
        objUserNDIA.alias='ndiaUsr';
        objUserNDIA.CommunityNickName='ndiausr'; 
        objUserNDIA.TimeZoneSidKey='America/New_York'; 
        objUserNDIA.LocaleSidKey='en_US'; 
        objUserNDIA.EmailEncodingKey='ISO-8859-1'; 
        objUserNDIA.LanguageLocaleKey='en_US';
        objUserNDIA.FirstName = 'Test';
        objUserNDIA.LastName = 'Dummy user' ;
        objUserNDIA.Phone='8989898989';
        objUserNDIA.MobilePhone='8887779990';
        objUserNDIA.IsActive = true; 
        objUserNDIA.NDIA_PaidRequest__c = true;
        objUserNDIA.City = 'Delhi';
        ndiaUsers.add(objUserNDIA);
        return ndiaUsers;
    }
    
    // create ContentDocument test data
    public static list<ContentDocument> createContentDocument(){
        
        // create document
        ContentVersion cv = new ContentVersion();
        cv.Title = 'Test Document';
        cv.PathOnClient = 'TestDoc.pdf';
        cv.VersionData = Blob.valueOf('Test Content');
        cv.IsMajorVersion = true;
        insert cv;
        
        //get Content Version
        list<ContentVersion> cvList = [Select Id, Title, ContentDocumentId FROM ContentVersion 
                                       WHERE Id = :cv.Id];
        
        List<ContentDocument> cdList = [SELECT Id, Title, LatestPublishedVersionId FROM ContentDocument];
        return cdList;
        
    }
    //Insert Content Document Link
    public static List<ContentDocumentLink> insertContentDocumentLink()
    {
        List<ContentDocumentLink> lstContentDocLink= new List<contentDocumentLink>();
        ContentDocumentLink contentlink=new ContentDocumentLink();
        contentlink.ShareType= 'V';
        contentlink.Visibility = 'AllUsers'; 
        lstContentDocLink.add(contentlink);
        return lstContentDocLink;
        
    }
    
    // Insert custom setting for trigger switch
    // Mukul Mishra
    public static NDIATriggerSwitch__c createTriggerSwitch()
    {
        NDIATriggerSwitch__c objTriggerSwitch =new NDIATriggerSwitch__c();
        objTriggerSwitch.isTriggerOn__c=true;
        objTriggerSwitch.objectName__c='Quote';
        objTriggerSwitch.Name='Quote';
        Insert objTriggerSwitch;
        return objTriggerSwitch;
        
    }
    // insert public group
     public static Group createGroup()
    {
        Group grp = new Group();
        grp.name = 'NDIA_USER';
        grp.Type = 'Regular'; 
        return grp;
        
    }
    
    
    
}