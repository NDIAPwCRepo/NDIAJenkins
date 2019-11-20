({
    // get important links Tiles
    getImportantLinks : function(component, event, helper) {
        var action = component.get("c.getImportantLinks");
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === "SUCCESS"){
                var links = response.getReturnValue();
                component.set("v.importantLinks", links);
            }
            
            else if(state === "ERROR"){
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " + 
                                 errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
            }
        });
        $A.enqueueAction(action);
    }
})