/**
*
* @date: 18-11-2019
* @author: Amiya Das
* @description: test class for NDIAChatterGrpTriggerHandler
* @param <Input parameter 1>
* @param <Input parameter 2>
*/
@isTest
public with sharing class NDIAChatterGrpTriggerHandlerTest {
   /* public NDIAChatterGrpTriggerHandlerTest() {

    } */

    public static testmethod void testCheckMultiplePvtChtGrp(){

      /*  User u = new User(Name='Amiya', Profile.Name='Quotation');
        inser u;
        system.assert(u.Id != null); */

        UserRole portalRole = new UserRole(DeveloperName = 'MyCustomRole', Name = 'My Role', PortalType='None' );
        insert portalRole;

        
        Profile p = [SELECT Id FROM Profile WHERE Name='System Administrator'];
        // creating portal account owner
        User portalAccountOwner = new User(Alias = 'standt', Email='standarduser@testorg.com', 
                            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
                            LocaleSidKey='en_US', ProfileId = p.Id, UserRoleId = portalRole.Id,
                            TimeZoneSidKey='America/Los_Angeles', 
                            Username = 'portalOwner' + System.currentTimeMillis() + '@test.com');

        insert portalAccountOwner;
        system.assert(portalAccountOwner.Id != null);
        
        // creating portal Account & Contact in user context
        system.runAs(portalAccountOwner){
        
            // creating account for portal user
            Account portalAccount = new Account(Name='test portal account', OwnerId=portalAccountOwner.Id );
            insert portalAccount;
            system.assert(portalAccount.Id != null);

            // creating contact for portal user
            Contact portalContact = new Contact(FirstName='portal', LastName='Con1', AccountId=portalAccount.Id);
            insert portalContact;
            system.assert(portalContact.Id != null);

            // creating community user 
        //  Profile portalProfile = [SELECT Id FROM Profile WHERE Name='Quotation'];
            Profile communityUserProfile = [SELECT Id FROM Profile WHERE Name = 'Quotation'];
            User communityUser = new User( Username = 'community.user.' + System.currentTimeMillis() + '@test.com',
                            ContactId = portalContact.Id, ProfileId = communityUserProfile.Id,
                            Alias = 'test123', Email = 'test12345@test.com', EmailEncodingKey = 'UTF-8',
                            LastName = 'McTest', CommunityNickname = 'test12345', TimeZoneSidKey = 'America/Los_Angeles',
                            LocaleSidKey = 'en_US', LanguageLocaleKey = 'en_US');
            insert communityUser;
            system.assert(communityUser.Id != null);

        // inserting list of chatter groups with Access type as 'Private'
            list<CollaborationGroup> chatterGrpList = new list<CollaborationGroup>();

            CollaborationGroup chatterGroup = new CollaborationGroup(Name='test chatter group', CollaborationType='Private', OwnerId=communityUser.Id);
            chatterGrpList.add(chatterGroup);
            CollaborationGroup chatterGroup1 = new CollaborationGroup(Name='test chatter group1', CollaborationType='Private', OwnerId=communityUser.Id);
            chatterGrpList.add(chatterGroup1);
            insert chatterGrpList;
            // system.assert(chatterGrpList);
            //  insert chatterGroup;
            //  system.assert(chatterGroup.Id != null);

            test.startTest();
            NDIAChatterGrpTriggerHandler objTriggerHandler = new NDIAChatterGrpTriggerHandler();
            objTriggerHandler.checkMultiplePvtChtGrp(chatterGrpList);
            test.stopTest();
    }
}
}