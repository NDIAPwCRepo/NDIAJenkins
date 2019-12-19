/**
*
* @date: 30-11-2019
* @author: Amiya Das
* @description: test class for 'NDIAFullAccessRequestController'
* @param <Input parameter 1>
* @param <Input parameter 2>
*/
@isTest
public with sharing class NDIAFullAccessRequestContrTest {
    
    public static testmethod void testCreatePaidAcessRecord(){

       
       User u = [Select id, name, email, NDIAFullAccessRequest__c, NDIARequestCheck__c from User 
                  where id=: UserInfo.getUserId()];
       //system.runAs(u){
         u.NDIAFullAccessRequest__c = 'Requested';
         update u;
      //  } 

      test.startTest();
      NDIAFullAccessRequestController.createPaidAcessRecord();
      test.stopTest();
}
public static testmethod void testCreatePaidAcessRecord1(){

    User u = [Select id, name, email, NDIAFullAccessRequest__c, NDIARequestCheck__c from User 
                  where id=: UserInfo.getUserId()];
       //system.runAs(u){
         u.NDIAFullAccessRequest__c = 'Activated';
         update u;
      //  } 

      test.startTest();
      NDIAFullAccessRequestController.createPaidAcessRecord();
      test.stopTest();
}
}