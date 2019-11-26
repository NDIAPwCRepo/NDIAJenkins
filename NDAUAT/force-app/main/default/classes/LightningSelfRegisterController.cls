global without sharing class  LightningSelfRegisterController {
    
    public LightningSelfRegisterController() {
        
    }
    
    @TestVisible 
    private static boolean isValidPassword(String password, String confirmPassword) {
        return password == confirmPassword;
    }
    
    @TestVisible 
    private static boolean siteAsContainerEnabled(String communityUrl) {
        Auth.AuthConfiguration authConfig = new Auth.AuthConfiguration(communityUrl,'');
        return authConfig.isCommunityUsingSiteAsContainer();
    }
    
    @TestVisible 
    private static void validatePassword(User u, String password, String confirmPassword) {
        if(!Test.isRunningTest()) {
            Site.validatePassword(u, password, confirmPassword);
        }
        return;
    }
    
    @AuraEnabled
    public static String selfRegister(String firstname ,String lastname, String email, String ABnNumber, String Organization,String regConfirmUrl, String extraFields, String startUrl,Boolean PaidReq,String ContactNumber) {
        Savepoint sp = null;
        try {
            sp = Database.setSavepoint();
            
            if (lastname == null || String.isEmpty(lastname)) {
                return Label.Site.lastname_is_required;
            }
            
            
            if (email == null || String.isEmpty(email)) {
                return Label.Site.email_is_required;
            }
            //Get SP free user Profile
            List<Profile> lstProfile=[Select Id, Name from Profile where name=: System.Label.SpUserFreeProfileName];
            System.debug('@@varun@@@@@@@'+lstProfile);
            //Get SP free user Profile            
            User u = new User();
            u.Username = email;
            u.put('Email',email);
            if(!lstProfile.isEmpty() && lstProfile.size()==1)
                u.ProfileId=lstProfile.get(0).id;
            u.FirstName = firstname;
            u.LastName = lastname;
            if(!String.isBlank(ContactNumber))
                u.Phone=ContactNumber;
            //   u.NDIA_PaidRequest__c=PaidReq;
            u.CommunityNickname=firstname+' '+lastname;
            String networkId = Network.getNetworkId();
             System.debug('@@varun@@@@@@@'+u);
            // If using site to host the community the user should not hit s1 after logging in from mobile.
            if(networkId != null && siteAsContainerEnabled(Network.getLoginUrl(networkId))) {
                   u.put('UserPreferencesHideS1BrowserUI',true);
            }
            
            //  String nickname = ((firstname != null && firstname.length() > 0) ? firstname.substring(0,1) : '' ) + lastname.substring(0,1);
            //  nickname += String.valueOf(Crypto.getRandomInteger()).substring(1,7);
            //      u.put('CommunityNickname', );
            
            if (extraFields != null) {
                List<Object> extraFieldsList = (List<Object>) JSON.deserializeUntyped(extraFields);        
                for (Object thisFieldObject : extraFieldsList) {
                    Map<String,Object> thisField = (Map<String,Object>) thisFieldObject;
                    Schema.SObjectField sof = Schema.SObjectType.User.fields.getMap().get((String) thisField.get('fieldPath'));
                    u.put(sof, thisField.get('value'));
                }
            }
            
            String accountId='';         
            //Account Details
            system.debug('@@varun@@@@@@@'+ABnNumber);
            if(!String.isBlank(ABnNumber))
            {
                 
                List<Account> lstAccount=[Select id,name,NDIAABNNumber__c from Account where NDIAABNNumber__c=:ABnNumber];
                 system.debug('@@varun@@@@@@@'+lstAccount);
                
                if(!lstAccount.isEmpty() && lstAccount.size()==1)
                {
                    accountId=lstAccount.get(0).Id;
                }
                
                if(lstAccount.isEmpty())
                {
                    system.debug('@varun@herere'+lstAccount);
                    Account a= new Account();
                    a.Name=Organization;
                    a.RecordTypeId=Schema.Sobjecttype.Account.getRecordTypeInfosByName().get(System.Label.SpAccountRecordTypeName).getRecordTypeId(); 
                    a.NDIAABNNumber__c=ABnNumber;
                    a.OwnerId=System.Label.SpUserAccountOwnerId;
                    //   a.NDIAFirstName__c= firstName;
                    //   a.NDIALastName__c = lastName;
                    insert a;
                    system.debug('@@varun@@@@@@@'+a.OwnerId);
                    accountId=a.Id;
                    
                }
                
            }
            
            //Account Details
            // lastName is a required field on user, but if it isn't specified, we'll default it to the username
            String userId='';
            
            userId = Site.createExternalUser(u,accountId,'');
            
            // create a fake userId for test.
            if (Test.isRunningTest()) {
                userId = 'fakeUserId';           
            }
            if (userId != null) { 
                
                
                ApexPages.PageReference confirmRef = new PageReference(regConfirmUrl);
                if(!Test.isRunningTest()) {
                    aura.redirect(confirmRef);
                }
                
                
            }
            return null;
        }
        catch (Exception ex) {
            Database.rollback(sp);
            return ex.getMessage();            
        }
    }
    
    @AuraEnabled
    public static List<Map<String,Object>> getExtraFields(String extraFieldsFieldSet) { 
        List<Map<String,Object>> extraFields = new List<Map<String,Object>>();
        Schema.FieldSet fieldSet = Schema.SObjectType.User.fieldSets.getMap().get(extraFieldsFieldSet);
        if(!Test.isRunningTest()) {
            if (fieldSet != null) {
                for (Schema.FieldSetMember f : fieldSet.getFields()) {
                    Map<String, Object> fieldDetail = new Map<String, Object>();
                    fieldDetail.put('dbRequired', f.getDBRequired());
                    fieldDetail.put('fieldPath', f.getFieldPath());
                    fieldDetail.put('label', f.getLabel());
                    fieldDetail.put('required', f.getRequired());
                    fieldDetail.put('type', f.getType());
                    fieldDetail.put('value', '');   // client will populate
                    extraFields.add(fieldDetail);
                }}}
        return extraFields;
    }
    
    @AuraEnabled
    global static String setExperienceId(String expId) {
        // Return null if there is no error, else it will return the error message 
        try {
            if (expId != null) {
                Site.setExperienceId(expId);   
            }
            return null; 
        } catch (Exception ex) {
            return ex.getMessage();            
        }        
    }  
}