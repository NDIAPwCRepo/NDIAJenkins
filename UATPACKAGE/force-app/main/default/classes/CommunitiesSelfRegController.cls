/**
* An apex page controller that supports self registration of users in communities that allow self registration
*/
public class CommunitiesSelfRegController {
    
    public String firstName {get; set;}
    public String lastName {get; set;}
    public String email {get; set;}
    public String abnNumber {get; set;}
    public String Organization {get; set;}
    public String  userName{get; set;}
    public String password {get; set {password = value == null ? value : value.trim(); } }
    public String confirmPassword {get; set { confirmPassword = value == null ? value : value.trim(); } }
    public String communityNickname {get; set { communityNickname = value == null ? value : value.trim(); } }
    
    public CommunitiesSelfRegController() { 
        abnNumber='';
        userName='';
        Organization='';
        String expid = ApexPages.currentPage().getParameters().get('expid');            
        if (expId != null) {
            Site.setExperienceId(expId); 
        }    
    }
    
    private boolean isValidPassword() {
        return password == confirmPassword;
    }
    
    public PageReference registerUser() {
        // Code to Check Account Duplicacy with ABN Number   
        String accountId = ''; 
        if(!String.isBlank(abnNumber))
        {
            List<Account> lstAccount=[Select id,name,NDIAABNNumber__c from Account where NDIAABNNumber__c=:abnNumber];
            system.debug('@varun@'+lstAccount);
            
            if(!lstAccount.isEmpty() && lstAccount.size()==1)
            {
                system.debug('@varun@imherereerere'+lstAccount);
                accountId=lstAccount.get(0).Id;
            }
            
            if(!lstAccount.isEmpty() && lstAccount.size()>1)
            {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Duplicate Account with Same ABN Number Found'));
                
            }
            
            if(lstAccount.isEmpty())
            {
                system.debug('@varun@herere'+lstAccount);
                
                Account a= new Account();
                a.Name=Organization;
                a.NDIAABNNumber__c=abnNumber;
                a.OwnerId='005P0000001kQp7';
                a.NDIAFirstName__c= firstName;
                a.NDIALastName__c = lastName;
                insert a;
                
                //     accountId=a.Id;
                
            }
            
            
        }
        // Code to Check Account Duplicacy with ABN Number   
        
        
        
        // it's okay if password is null - we'll send the user a random password in that case
        if (!isValidPassword()) {
            ApexPages.Message msg = new ApexPages.Message(ApexPages.Severity.ERROR, Label.site.passwords_dont_match);
            ApexPages.addMessage(msg);
            return null;
        }    
        
        String profileId = '00eP0000000QW6n'; // To be filled in by customer.
        String roleEnum = null; // To be filled in by customer.
        // To be filled in by customer.
        
        String userName = email;
        
        User u = new User();
        u.Username = userName;
        u.Email = email;
        u.FirstName = firstName;
        u.LastName = lastName;
        u.CommunityNickname = communityNickname;
        u.ProfileId = profileId;
        
        String userId;
        
        try {
            userId = Site.createExternalUser(u, accountId, password);
        } catch(Site.ExternalUserCreateException ex) {
            List<String> errors = ex.getDisplayMessages();
            for (String error : errors)  {
                ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, error));
            }
            
            // This message is used for debugging. Do not display this in the UI to the end user.
            // It has the information around why the user creation failed.
            System.debug('varun@@@1234'+ex.getMessage());
        }
        
        if (userId != null) { 
            if (password != null && password.length() > 1) {
                return Site.login(userName, password, ApexPages.currentPage().getParameters().get('startURL'));
            }
            else {
                PageReference page = System.Page.CommunitiesSelfRegConfirm;
                page.setRedirect(true);
                return page;
            }
        }
        return null;
    }
    
}