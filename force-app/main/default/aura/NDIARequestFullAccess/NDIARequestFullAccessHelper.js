({
    
    getUserData: function(component, event, helper) {
        
        var action = component.get("c.getFullUserData");
        action.setCallback(this, function(response){
            var state = response.getState();
            var userValue = response.getReturnValue();
            if(userValue["NDIAFullAccessRequest__c"]=='Requested')
          {
              component.set('v.disabled',true);
          }
          else
          {
              component.set('v.disabled',false);                
          }
        });
        $A.enqueueAction(action);
    },
    
    fullAccessRequest : function(component, event, helper) {
        var action = component.get("c.createPaidAcessRecord");
        action.setCallback(this, function(response){
            var state = response.getState();
            var userValue = response.getReturnValue();
            console.log('uservalue :', userValue);
            //var fullAccessReq = "NDIARequestCheck__c"; 
            //   var fullAccessOnReg = "FullAccessReqOnRegister__c";
            /*console.log(userValue);
            console.log(JSON.stringify(userValue)); 
            console.log(field);  */
         // var userVal = userValue[fullAccessReq]; 
          //   var userVal1 = userValue[fullAccessOnReg];
         // console.log('userVal***', userVal);
          if(userValue["NDIAFullAccessRequest__c"]=='Requested')
          {
              component.set('v.disabled',true);
          }
          else
          {
              component.set('v.disabled',false);                
          }
          debugger;
          if(state === "SUCCESS"){
              console.log(state);
              if((userVal === true)){
                  var checkRequested = $A.get("e.force:showToast");
                  checkRequested.setParams({
                      "message": "User Has already requested For Full Access. Please contact Admin",
                      "type":"error"
                  });
                  checkRequested.fire();
              } 
              else {
                  // show toast message
                  var toastMessage = $A.get("e.force:showToast");
                  toastMessage.setParams({
                      "message": "Admin Has Been Notified for Full Access request",
                      "type":"success"
                  });
                  toastMessage.fire();
                  $A.get("e.force:closeQuickAction").fire();
                  $A.get('e.force:refreshView').fire();
              }
          }
      });
      $A.enqueueAction(action);
      
  }
})
//