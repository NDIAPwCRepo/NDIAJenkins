// test class for controller -- NDIACommLatestUpdatesController
@isTest
public class NDIACommLatestUpdatesControllerTest {
    
    public static testmethod void testgetLatestUpdates(){

        // calling NDIATestDataFactory
        Knowledge__kav objKnowledgeArticle1 = NDIATestDataFactory.createKnowArtcleWithLatestUpdates();
        insert objKnowledgeArticle1;
        system.assert(objKnowledgeArticle1.Id != null);
        

        test.startTest();
        NDIACommLatestUpdatesController.getLatestUpdates();
        test.stopTest();
    }

    public static testmethod void testgetImportantLinks(){

        // calling NDIATestDataFactory
        Knowledge__kav objKnowledgeArticle2 = NDIATestDataFactory.createKnowArtcleWithImpLinks();
        insert objKnowledgeArticle2;
        system.assert(objKnowledgeArticle2.Id != null);

        test.startTest();
        NDIACommLatestUpdatesController.getImportantLinks();
        test.stoptest();
    }
}