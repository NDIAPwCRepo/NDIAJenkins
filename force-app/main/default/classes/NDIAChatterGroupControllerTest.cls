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
public class NDIAChatterGroupControllerTest {
   


    public static testmethod void testGetTrendingGroups(){

        // invoking NDIATestDataFactory
        CollaborationGroup trendingGrps = NDIATestDataFactory.createTrendingGroups();
        insert trendingGrps;
        system.assert(trendingGrps.Id != null);
       // return trendingGrps;

        test.startTest();
        NDIAChatterGroupController.getTrendingGroups();
        test.stopTest();
    }

    public static testmethod void testGetMyGroups(){

        // invoking NDIATestDataFactory
        CollaborationGroup trendingGrps1 = NDIATestDataFactory.createMyGroups();
        insert trendingGrps1;
        system.assert(trendingGrps1.Id != null);

        test.startTest();
        NDIAChatterGroupController.getMyGroups();
        test.stopTest();
    }
}