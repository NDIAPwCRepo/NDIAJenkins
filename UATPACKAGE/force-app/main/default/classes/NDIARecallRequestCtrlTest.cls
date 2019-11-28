/**
*
* @date: 20-11-2019
* @author: Amiya Das
* @description: test class for 'RecallRequestCtrl '
* @param <Input parameter 1>
* @param <Input parameter 2>
*/
@isTest
public class NDIARecallRequestCtrlTest {
    
    public static testmethod void reCallApprovalRequestTest(){

        Account objAcc = NDIATestDataFactory.createCustomer();
        insert objAcc;
        system.assert(objAcc.Id != null);

        Quotation__c objQuotation = NDIATestDataFactory.createQuoteForApproval(objAcc.Id);
        insert objQuotation;
        system.assert(objQuotation.Id != null);

        Approval.ProcessSubmitRequest submitRequest = new Approval.ProcessSubmitRequest();
        submitRequest.setSkipEntryCriteria(true);
        submitRequest.setComments('request submitted');
        submitRequest.setObjectId(objQuotation.Id);

        //Submit the approval request
        Approval.ProcessResult processResult = Approval.process(submitRequest);

        system.assert(processResult.isSuccess());
        List<Id> newWorkItemIds = processResult.getNewWorkitemIds();
          //  system.debug('newWorkItemIds ::'+newWorkItemIds );

        Approval.ProcessWorkitemRequest workItemRequest =  new Approval.ProcessWorkitemRequest();
        workItemRequest.setAction('Approve');
        workItemRequest.setComments('Approving request.');
        workItemRequest.setWorkitemId(newWorkItemIds.get(0));
        system.debug('workItemRequest--'+workItemRequest);

        Approval.ProcessResult processResult1 =  Approval.process(workItemRequest);

        System.assert(processResult1.isSuccess(), 'Result Status:'+processResult1.isSuccess());

        System.assertEquals(
        'Approved', processResult1.getInstanceStatus(), 
        'Instance Status'+processResult1.getInstanceStatus());

        list<ProcessInstance> proc = new list<ProcessInstance>();
       /* proc.LastActorId = userinfo.getuserid();
        proc.TargetObjectId = objQuotation.Id;
        proc.Status = 'Pending';
        proc.ProcessDefinitionId = '04aP000000003kvIAA';
        insert proc;

        ProcessInstanceWorkitem pworkItem = new ProcessInstanceWorkitem();
        pworkItem.ActorId = userinfo.getuserId();
        pworkItem.OriginalActorId = userinfo.getuserId();
        pworkItem.ProcessInstanceId = proc.Id;
        insert pworkItem; */

        test.startTest();
        if([select count() from ProcessInstance where targetobjectid=:objQuotation.id] < 1)
        {       
            Approval.ProcessSubmitRequest req = new Approval.ProcessSubmitRequest();
            req.setComments('Approve.');
            req.setNextApproverIds(new Id[] {UserInfo.getUserId()});
            req.setObjectId(objQuotation.Id);

            //Submit the approval request
            Approval.ProcessResult result = Approval.process(req);

        }

       /*  ProcessInstance processInstances = [SELECT TargetObjectId,Status FROM ProcessInstance 
                                              WHERE TargetObjectId = :objQuotation.Id LIMIT 1];
          insert processInstances;

        List<ProcessInstanceWorkitem> workItems = [SELECT Id,ProcessInstance.TargetObjectId,ProcessInstanceId 
                                                    FROM ProcessInstanceWorkitem WHERE ProcessInstance.TargetObjectId = :objQuotation.Id];
        insert workItems; */

        proc = [select Id, Status from ProcessInstance where TargetObjectId = :objQuotation.Id];
        System.assertEquals(proc.size(),1);

        

        RecallRequestCtrl.reCallApprovalRequest(objQuotation.Id);
        test.stopTest();
    }
}