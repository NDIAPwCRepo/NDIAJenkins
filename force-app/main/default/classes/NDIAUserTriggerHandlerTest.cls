//Test Class for covering all methods of file Upload
//Mukul Mishra
//26 Nov 2019
@isTest
public class NDIAUserTriggerHandlerTest {
    @isTest
    public static void  addMembertoNDIAGroup()
    {
        Account objCustomer= NDIATestDataFactory.createCustomer();
        List<user> NDIAUserList= NDIATestDataFactory.createNDIAUser();
        List<Contact> lstContact = NDIATestDataFactory.createContacts();
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
            Profile portalProfile = [SELECT Id,name FROM Profile where name = 'NDIAUser'];
            system.debug('portalProfile@'+portalProfile);
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
            Group grp = NDIATestDataFactory.createGroup();
            test.startTest();
            insert user1;
            system.debug('user.profile.name'+user1.profile.name);
            test.stopTest();
        }
    }
}