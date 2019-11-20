// test class for controller -- NDIACommLatestUpdatesController
@isTest
public with sharing class NDIACommLatestUpdatesControllerTest {
    
    public static testmethod void testgetLatestUpdates(){

        test.startTest();
        NDIACommLatestUpdatesController.getLatestUpdates();
        test.stopTest();
    }

    public static testmethod void testgetImportantLinks(){

        test.startTest();
        NDIACommLatestUpdatesController.getImportantLinks();
        test.stoptest();
    }
}