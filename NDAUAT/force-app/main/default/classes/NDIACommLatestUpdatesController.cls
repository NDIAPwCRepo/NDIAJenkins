// to display Latest Updates and Imp links in NDIA Community Portal
/**
*
* @date: 07-11-2019
* @author: Amiya Das
* @description: to display Latest Updates and Imp links in NDIA Community Portal
* @param <Input parameter 1>
* @param <Input parameter 2>
* @return: latestUPdates
* @return: impLinks
*/
public with sharing class NDIACommLatestUpdatesController {
    
    /* public NDIACommLatestUpdatesController() {
    } */

    // fetching latest updates
    @AuraEnabled
    public static List<Knowledge__kav> getLatestUpdates(){
        
        list<Knowledge__kav> latestUPdates = [select Id, UrlName, Title, PublishStatus, NDIAUrl__c from  
                                                Knowledge__kav where NDIAType__c = 'Latest Updates'];
        return latestUPdates;
    }

    // fetching important links
    @AuraEnabled
    public static List<Knowledge__kav> getImportantLinks(){
        
        list<Knowledge__kav> impLinks = [select Id, UrlName, Title, PublishStatus, NDIAUrl__c from  
                                            Knowledge__kav where NDIAType__c = 'Important Links'];
        return impLinks;
    }
}