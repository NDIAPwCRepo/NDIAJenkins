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
            var weights = [10, 1, 3, 5, 7, 9, 11, 13, 15, 17, 19];
            ABnNumber = ABnNumber.replace(/\D/g, ''); // strip non numeric chars
            if(ABnNumber.length != 11){
                component.set("v.errorMessage","ABN must be of 11 digits");
                component.set("v.showError",true);
            }
            else{
                var abnFirstDigit = parseInt(ABnNumber.charAt(0)) - 1; //subtract 1 from first digit
                ABnNumber = abnFirstDigit + ABnNumber.substring(1); // replace first digit with the substracted value
                var total = 0;
                for(var i = 0; i < 11; i++)
                  total += weights[i] * ABnNumber.charAt(i);
                if(total = 0 || total % 89 != 0) {
                   component.set("v.errorMessage","Wrong ABN");
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
			}
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