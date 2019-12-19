public class NDIAUserTriggerHandler
{
    public  void addMembertoNDIAGroup(List<User> ndiaUser)
    {
        List<Id> userId = new List<Id>();
        for(User U : ndiaUser) {
            if(U.isActive) {
                userId.add(U.Id);
            }
        }
        
        updateGroupMemberList(userId);
        
    }
    @future
    
    private static void updateGroupMemberList(List<Id> userId)
        
    {
        string ndiaPublicGroupName=System.Label.NDIAPublicGroupName;
        string ndiaProfileName=System.Label.ndiaProfileName;
        if(Schema.SObjectType.Quotation__c.isCreateable() && Schema.SObjectType.Quotation__c.Fields.NDIAQuoteStage__c.isCreateable()
           &&Schema.SObjectType.Quotation__c.Fields.NDIANDISParticipant__c.isCreateable()&&
           Schema.SObjectType.Account.isAccessible()){
               User u = [ Select id,user.profile.name from User where Id = :userId[0]];
               system.debug('u'+STring.valueOf(user.profile.name)==ndiaProfileName);
               if(u.profile.name!=null && STring.valueOf(u.profile.name)==ndiaProfileName){
                   List<Group> ndiaGroup=[SELECT Id, DeveloperName, (SELECT Id, UserOrGroupId FROM GroupMembers)FROM Group where DeveloperName=:ndiaPublicGroupName WITH SECURITY_ENFORCED];
                   List<GroupMember> GMlist = new List<GroupMember>();

                   if(Schema.SObjectType.GroupMember.isCreateable())
                   {
                       if(Schema.SObjectType.GroupMember.Fields.GroupId.isCreateable() && Schema.SObjectType.GroupMember.Fields.UserOrGroupId.isCreateable())
                       {
                   GroupMember GM = new GroupMember();
                   GM.GroupId = ndiaGroup[0].Id;
                   GM.UserOrGroupId = u.Id;
                   GMList.add(GM); 
                   }  
                   }
                   if(!GMList.isEmpty()) {
                       System.debug('Group Member List is ' + GMList);
                       insert GMList;
                   }
}
               
               
           }
    }
}