/**
*
* @date: 30-11-2019
* @author: Amiya Das
* @description: controller logic for getting paid access to community users
* @param <Input parameter 1>
* @param <Input parameter 2>
*/
public with sharing class NDIAFullAccessRequestController {
   /* public NDIAFullAccessRequestController() {

    } */
    @AuraEnabled
    public static User getFullUserData()
    {
        
    User userName = [select Id, Name, NDIAFullAccessRequest__c, NDIARequestCheck__c,Origin__c from User 
                      where Id =: UserInfo.getUserId() LIMIT 1];
        return userName;
    }
    @AuraEnabled
    public static User createPaidAcessRecord(){

    User userName = [select Id, Name, NDIAFullAccessRequest__c, NDIARequestCheck__c,Origin__c from User 
                      where Id =: UserInfo.getUserId() LIMIT 1];
    system.debug('logged in user name : ' +userName);

    if((userName.NDIAFullAccessRequest__c == 'Requested')) 
    { 
      userName.NDIARequestCheck__c = true; 
      }
   else {
        userName.NDIARequestCheck__c = false;
        userName.NDIAFullAccessRequest__c = 'Requested';
        userName.Origin__c = 'Demo Tab';
         } 
        system.debug('username@@'+userName);
      update userName;
      return userName;
      }

}