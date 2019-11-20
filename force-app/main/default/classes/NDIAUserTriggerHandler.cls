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
        User u = [ Select id from User where Id = :userId[0] ];
        List<Group> ndiaGroup=[SELECT Id, DeveloperName, (SELECT Id, UserOrGroupId FROM GroupMembers)FROM Group where DeveloperName=:ndiaPublicGroupName];
        List<GroupMember> GMlist = new List<GroupMember>();
        GroupMember GM = new GroupMember();
        GM.GroupId = ndiaGroup[0].Id;
        GM.UserOrGroupId = u.Id;
        GMList.add(GM);   
        if(!GMList.isEmpty()) {
            System.debug('Group Member List is ' + GMList);
            insert GMList;
        }
        
    }
}