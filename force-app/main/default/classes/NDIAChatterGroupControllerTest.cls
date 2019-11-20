/**
*
* @date: 18-11-2019
* @author: Amiya Das
* @description: test clas for NDIAChatterGroupController
* @param <Input parameter 1>
* @param <Input parameter 2>
* @return: latestUPdates
* @return: impLinks
*/
@isTest
public with sharing class NDIAChatterGroupControllerTest {
   /* public NDIAChatterGroupControllerTest() {

    } */

    public static testmethod void testGetTrendingGroups(){

        test.startTest();
        NDIAChatterGroupController.getTrendingGroups();
        test.stopTest();
    }

    public static testmethod void testGetMyGroups(){

        test.startTest();
        NDIAChatterGroupController.getMyGroups();
        test.stopTest();
    }
}