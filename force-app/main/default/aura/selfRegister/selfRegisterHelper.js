({
    qsToEventMap: {
        'startURL'  : 'e.c:setStartUrl'
    },
    
    qsToEventMap2: {
        'expid'  : 'e.c:setExpId'
    },
    
    handleSelfRegister: function (component, event, helpler) {
        var accountId = component.get("v.accountId");
        var regConfirmUrl = component.get("v.regConfirmUrl");
        var firstname = component.find("firstname").get("v.value");
        var lastname = component.find("lastname").get("v.value");
        var email = component.find("email").get("v.value");
        var includePassword = component.get("v.includePasswordField");
        var ABnNumber = component.find("ABnNumber").get("v.value");
        var Organization = component.find("Organization").get("v.value");
        //var PaidReq = component.find("PaidRequest").get("v.value");
        var PaidReq="TRUE";
        var ContactNumber=component.find("ContactNumber").get("v.value");
        // alert(PaidReq);
        if(ABnNumber==="" || Organization==="" || lastname==="" )
        {
            component.set("v.errorMessage","Kindly fill all the fields");
            component.set("v.showError",true);
        }
        else{
            var action = component.get("c.selfRegister");
            var extraFields = JSON.stringify(component.get("v.extraFields"));   // somehow apex controllers refuse to deal with list of maps
            var startUrl = component.get("v.startUrl");
            
            startUrl = decodeURIComponent(startUrl);
            
            action.setParams({firstname:firstname,lastname:lastname,email:email, ABnNumber:ABnNumber, Organization:Organization,
                              regConfirmUrl:regConfirmUrl, extraFields:extraFields, startUrl:startUrl,PaidReq:PaidReq,ContactNumber:ContactNumber});
            action.setCallback(this, function(a){
                var rtnValue = a.getReturnValue();
                if (rtnValue !== null) {
                    component.set("v.errorMessage",rtnValue);
                    component.set("v.showError",true);
                }
            });
            $A.enqueueAction(action);
        }
    },
    
    getExtraFields : function (component, event, helpler) {
        var action = component.get("c.getExtraFields");
        action.setParam("extraFieldsFieldSet", component.get("v.extraFieldsFieldSet"));
        action.setCallback(this, function(a){
            var rtnValue = a.getReturnValue();
            if (rtnValue !== null) {
                component.set('v.extraFields',rtnValue);
            }
        });
        $A.enqueueAction(action);
    },
    
    setBrandingCookie: function (component, event, helpler) {        
        var expId = component.get("v.expid");
        if (expId) {
            var action = component.get("c.setExperienceId");
            action.setParams({expId:expId});
            action.setCallback(this, function(a){ });
            $A.enqueueAction(action);
        }
    }    
})