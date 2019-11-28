/**
*
* @date: 20-11-2019
* @author: Amiya Das
* @description: test class for AssignNdiaPrimaryOwnerCtrl
* @param <Input parameter 1>
* @param <Input parameter 2>
*/
@isTest
public class NDIAAssignNdiaPrimaryOwnerCtrlTest {
    
    public static testmethod void fetchUserToUpdateRecordTest(){
        
        // invoking NDIATestDataFactory for inserting account
        /*   Account objAccount = NDIATestDataFactory.createCustomer();
insert objAccount;
system.assert(objAccount.Id != null);

// invoking NDIATestDataFactory for inserting User
User objUser = NDIATestDataFactory.createNDIAUser();
insert objUser;
system.assert(objUser.Id != null);

// invoking NDIATestDataFactory for inserting Quotation with Customer and NDIA Primary Owner
Quotation__c objQuotation = NDIATestDataFactory.createQuotationWithNDIAOwner(objAccount.Id, objUser.Id);
insert objQuotation;
system.assert(objQuotation.Id != null);   */
        
        UserRole portalRole = [Select Id From UserRole Where PortalType = 'None' Limit 1];
        
        
        
        Profile profile1 = [Select Id from Profile where name = 'System Administrator'];
        User portalAccountOwner1 = new User(
            UserRoleId = portalRole.Id,
            ProfileId = profile1.Id,
            Username = System.now().millisecond() + 'test2@test.com',
            Alias = 'batman',
            Email='bruce.wayne@wayneenterprises.com',
            EmailEncodingKey='UTF-8',
            Firstname='Bruce',
            Lastname='Wayne',
            LanguageLocaleKey='en_US',
            LocaleSidKey='en_US',
            TimeZoneSidKey='America/Chicago'
        );
        insert portalAccountOwner1;
        
        system.runAs(portalAccountOwner1){
            
            Account portalAccount1 = new Account();
            portalAccount1.Name = 'TestAccount';
            portalAccount1.OwnerId = portalAccountOwner1.Id;
            portalAccount1.BillingStreet = 'TestAccount';
            portalAccount1.BillingCity = 'testAccount';
            portalAccount1.BillingState = 'New South Wales';
            portalAccount1.BillingPostalCode = '2000';
            portalAccount1.BillingCountry = 'Australia';
            
            
            insert portalAccount1;
            
            Contact con1 = new Contact();
            con1.FirstName = 'Test';
            con1.Lastname = 'McTesty';
            con1.AccountId = portalAccount1.Id;
            con1.Email = System.now().millisecond() + 'test@test.com';
            insert con1;
            
            
            
            
            
            // create user
            Profile portalProfile = [SELECT Id FROM Profile where name = 'NDIAUser'];
            User user1 = new User(
                Username = System.now().millisecond() + 'test12345@test.com',
                ContactId = con1.Id,
                ProfileId = portalProfile.Id,
                Alias = 'test123',
                Email = 'test12345@test.com',
                EmailEncodingKey = 'UTF-8',
                LastName = 'McTesty',
                CommunityNickname = 'test12345',
                TimeZoneSidKey = 'America/Los_Angeles',
                LocaleSidKey = 'en_US',
                LanguageLocaleKey = 'en_US'
            );
            insert user1; 
            
            
            /*  Quotation__c objQuotation = NDIATestDataFactory.createQuotationWithNDIAOwner(portalAccount1.Id, user1.Id);
insert objQuotation;
system.assert(objQuotation.Id != null); */
            
            Quotation__c objQuotationWithNDIAOwner = new Quotation__c();
            objQuotationWithNDIAOwner.NDIAAccount__c = portalAccount1.Id;
            objQuotationWithNDIAOwner.NDIAApprovalDate__c = System.today();
            objQuotationWithNDIAOwner.NDIAQuoteType__c = 'SIL';
            objQuotationWithNDIAOwner.NDIAWeeklyApprovedAmount__c = 1.00;
            objQuotationWithNDIAOwner.NDIAWeeklyOfferedAmount__c = 1.00;
            objQuotationWithNDIAOwner.NDIAWeeklyQuotedAmount__c = 2.00; 
            objQuotationWithNDIAOwner.NDIAWeeklyServiceBookingValue__c = 3.00;
            objQuotationWithNDIAOwner.NDIA_Primary_Owner__c = user1.Id;
            insert objQuotationWithNDIAOwner;
            
            
            
            test.startTest();
            AssignNdiaPrimaryOwnerCtrl.fetchUserToUpdateRecord(objQuotationWithNDIAOwner.Id);
            test.stopTest();
            
            /*  if(objQuotationWithNDIAOwner.Id == null){
insert objQuotationWithNDIAOwner;

} */
        }
    }
    
    public static testmethod void primaryOwnerNotAssgnTest(){
        
        /*   Quotation__c objQuotationApproval1 = new Quotation__c();
//   objQuotationApproval.NDIAAccount__c = accountId;
objQuotationApproval1.NDIAApprovalDate__c = System.today();
objQuotationApproval1.NDIAQuoteType__c = 'SIL';
objQuotationApproval1.NDIAWeeklyApprovedAmount__c = 1.00;
objQuotationApproval1.NDIAWeeklyOfferedAmount__c = 1.00;
objQuotationApproval1.NDIAWeeklyQuotedAmount__c = 2.00; 
objQuotationApproval1.NDIAWeeklyServiceBookingValue__c = 3.00;
objQuotationApproval1.NDIAQuoteStage__c='Approval In Progress'; */
        //   objQuotationApproval1.NDIA_Primary_Owner__c = UserInfo.getUserId();
        //  objQuotationApproval.NDIANDIS_Number__c = ndisNum;
        //  insert objQuotationApproval1;
        //  system.assert(objQuotationApproval1.Id = null); 
        
        Quotation__C objQuoteWOPriOnwer = NDIATestDataFactory.CrQuoteWithoutPriOwner();
        insert objQuoteWOPriOnwer;
        system.assert(objQuoteWOPriOnwer.Id != null);
        
        test.startTest();
        AssignNdiaPrimaryOwnerCtrl.fetchUserToUpdateRecord(objQuoteWOPriOnwer.Id);
        test.stopTest(); 
        
    }
    
}