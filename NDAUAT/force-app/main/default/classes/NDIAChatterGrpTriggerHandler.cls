/**
*
* @date: 15-11-2019
* @author: Amiya Das
* @description: To restrict Paid SP User to create only one Private Chatter Groups
* @param <Input parameter 1>
* @param <Input parameter 2>
*/

public with sharing class NDIAChatterGrpTriggerHandler {
 
    public void checkMultiplePvtChtGrp(list<CollaborationGroup> grpList){
    // getting logged in user profile name
        Id profileId = UserInfo.getProfileId();
        Profile p = [SELECT Name FROM Profile WHERE Id =: profileId LIMIT 1];

    // checking if logged in user profile is Quotation 
   if('Quotation'.equals(p.Name)){
       Id userId = UserInfo.getUserId();
        List<CollaborationGroup> chrGrpList = [SELECT Id, Name, CollaborationType FROM CollaborationGroup 
                                            WHERE OwnerId = :userId AND CollaborationType = 'Private' ];
        system.debug('chrGrpList : ' +chrGrpList);

        // check for duplicate/multiple private groups for Logged in user 'Quotation' user profile
        for(CollaborationGroup cg : grpList){
            for(integer i=0; i<chrGrpList.size(); i++){
                if(cg.CollaborationType == chrGrpList[i].CollaborationType){
               cg.addError('Paid SP user cant create more than one Private Group');
                }
       }
   }

   }
}
}