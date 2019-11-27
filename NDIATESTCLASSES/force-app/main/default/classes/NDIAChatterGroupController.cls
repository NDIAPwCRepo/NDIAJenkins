/**
*
* @date: 13-11-2019
* @author: Amiya Das
* @description: to display My Groups and Trending Chatter Groups
* @param <Input parameter 1>
* @param <Input parameter 2>
* @return: latestUPdates
* @return: impLinks
*/

public with sharing class NDIAChatterGroupController {
    
   //  public NDIAChatterGroupController() {}

    // fetch trending chatter groups
    @AuraEnabled
    public static list<CollaborationGroup> getTrendingGroups(){

        list<CollaborationGroup> trendingGroups = [select Id, Name, MemberCount, CollaborationType, CanHaveGuests, 
                                                    Owner.Name from CollaborationGroup where MemberCount >= 3 
                                                    AND CollaborationType = 'Public' order by MemberCount 
                                                    DESC LIMIT 5];
        system.debug('groups : ' +trendingGroups);
        return trendingGroups;
        
    }

    // fetching my groups
    @AuraEnabled
    public static list<CollaborationGroup> getMyGroups(){

        // user list with 'Customer Community Licnese'
        list<User> commUserList = [select id, Name, IsPortalEnabled FROM User WHERE 
                                    Profile.UserLicense.Name = 'Customer Community Plus Login'];

        // groups in which logged in community user/guest user/org user is a member of
       /* list<CollaborationGroup> myGroups = [select Id, Name, MemberCount, CollaborationType, CanHaveGuests, 
                                                Owner.Name, OwnerId, (select Id, CollaborationGroup.Name, 
                                                MemberId, Member.Name from GroupMembers where 
                                                ( (MemberId =: commUserList[0].id)) )
                                                from CollaborationGroup ];  */

        list<CollaborationGroup> myGroups = [select Id, Name from CollaborationGroup where Id in (select 
                                            CollaborationGroupId from CollaborationGroupMember where 
                                            MemberId =: UserInfo.getUserId())];

     /*  list<CollaborationGroupMember> collGroupMemberList = [SELECT Id,CollaborationGroupId, CollaborationGroup.Name
                                                            from CollaborationGroupMember where
                                                            MemberId =: commUserList[0].id]; */
        system.debug('my groups : ' +myGroups);
        
        return myGroups;
    }
}