/**
*
* @date: 18-11-2019
* @author: Amiya Das
* @description: test class for NDIAChatterGrpTriggerHandler
* @param <Input parameter 1>
* @param <Input parameter 2>
*/
@isTest(SeeAllData=true)
public class NDIAChatterGrpTriggerHandlerTest {
   /* public NDIAChatterGrpTriggerHandlerTest() {

    } */

    public static testmethod void testCheckMultiplePvtChtGrp(){

      /*  User u = new User(Name='Amiya', Profile.Name='Quotation');
        inser u;
        system.assert(u.Id != null); */

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
        
        
        // creating portal Account & Contact in user context
       system.runAs(portalAccountOwner1){
        
            // creating account for portal user
            Account portalAccount1 = new Account();
            portalAccount1.Name = 'TestAccount';
            portalAccount1.OwnerId = portalAccountOwner1.Id;
            portalAccount1.BillingStreet = 'test Street';
            portalAccount1.BillingCity = 'Perth';
            portalAccount1.BillingState = 'Victoria';
            portalAccount1.BillingPostalCode = '4455';
            portalAccount1.BillingCountry = 'Australia';
            insert portalAccount1;

            // creating contact for portal user
            Contact con1 = new Contact();
            con1.FirstName = 'Test';
            con1.Lastname = 'McTesty';
            con1.AccountId = portalAccount1.Id;
            con1.Email = System.now().millisecond() + 'test@test.com';
            insert con1;

            // create Quotation user
            Profile portalProfile = [SELECT Id FROM Profile where name = 'Quotation'];
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

           // NDIAChatterGrpTriggerHandler.chatterGroupCreationCheck();

       //   system.runAs(user1){


        // inserting list of chatter groups with Access/Collaboartion type as 'Private'
            list<CollaborationGroup> chatterGrpList = new list<CollaborationGroup>();

            CollaborationGroup chatterGroup = new CollaborationGroup(Name='test chatter group', CollaborationType='Private');
            chatterGrpList.add(chatterGroup);
            CollaborationGroup chatterGroup1 = new CollaborationGroup(Name='test chatter group1', CollaborationType='Private');
            chatterGrpList.add(chatterGroup1);
            insert chatterGrpList;

          //CollaborationGroupMember groupMember = new CollaborationGroupMember(CollaborationGroupId = chatterGroup.Id, MemberId = UserInfo.getUserId());
          //insert groupMember;
            
            // system.assert(chatterGrpList);
            //  insert chatterGroup;
            //  system.assert(chatterGroup.Id != null);



            test.startTest();
            NDIAChatterGrpTriggerHandler objTriggerHandler = new NDIAChatterGrpTriggerHandler();
            objTriggerHandler.checkMultiplePvtChtGrp(chatterGrpList);
            test.stopTest();
 //  } 
            }
}

 public static testmethod void testCheck(){

  NDIAChatterGrpTriggerHandler.chatterGroupCreationCheck();
} 
}