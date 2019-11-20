({
    
    CancelUpdate : function(component, event, helper) {
        $A.get("e.force:closeQuickAction").fire();
    },
    handleSaveRecord : function(component, event, helper) 
    {
        debugger;
        
        var action = component.get("c.fetchUserToUpdateRecord");
        action.setParams({  recordId :component.get("v.recordId")});
        //
        action.setCallback(this, function(response) {
            debugger;
            var state = response.getState();
            if (state === "SUCCESS" && response.getReturnValue()===null) 
            {
                debugger;
                var resultsToast = $A.get("e.force:showToast");
                resultsToast.setParams({
                    "title": "Congratulation", 
                    "message": "YOU ARE THE REVIEWER",
                    "type":"success"
                });
                resultsToast.fire();
                $A.get("e.force:closeQuickAction").fire();
                $A.get('e.force:refreshView').fire();
                
            }
            if(state === "SUCCESS" && response.getReturnValue()!==null)
            {
                  var resultsToast = $A.get("e.force:showToast");
                resultsToast.setParams({
                    "title": "Cancelled", 
                    "message": response.getReturnValue(),
                    "type":"error"
                });
                resultsToast.fire();
                $A.get("e.force:closeQuickAction").fire();
                $A.get('e.force:refreshView').fire();
            }
        });
        $A.enqueueAction(action);
        
        //    
    }
})