({
   getFiledata : function(component, event, helper){
        var parentId;
        var action = component.get("c.getContentDocs");
        action.setParams({
             parentId: component.get("v.recordId"),
         
        });
        action.setCallback(this,function(response){
            var state = response.getState();
            if(state == "SUCCESS"){
                debugger;
                var data = response.getReturnValue();
                debugger;
                 component.set("v.data", response.getReturnValue());
                
                    
            }
          
        });
        $A.enqueueAction(action);
    },
  })