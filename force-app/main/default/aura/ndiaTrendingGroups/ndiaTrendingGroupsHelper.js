({
    // fetch trending groups
    getTrendingGrps : function(component, event, helper) {
        var action = component.get("c.getTrendingGroups");
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === "SUCCESS"){
                var tGrps = response.getReturnValue();
                console.log(tGrps);
                component.set("v.trendingGroups", tGrps);
            }

            else if(state === "ERROR"){
                var errors = response.getError();
                if(errors){
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " + 
                                 errors[0].message);
                    }
                    else{
                        console.log("Unknown error");
                    }
                }
            }
        });
        $A.enqueueAction(action);
    },

    // fetch my groups
    getMyGrps : function(component, event, helper) {
        var action = component.get("c.getMyGroups");
        action.setCallback(this, function(response){
            var state = response.getState();
            if(state === "SUCCESS"){
                var mGrps = response.getReturnValue();
                console.log(mGrps);
                component.set("v.myGroups", mGrps);
            }

            else if(state === "ERROR"){
                var errors = response.getError();
                if(errors){
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " + 
                                 errors[0].message);
                    }
                    else{
                        console.log("Unknown error");
                    }
                }
            }
        });
        $A.enqueueAction(action);
    }
})