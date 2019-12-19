({
    handleFullAccess : function(component, event, helper) {
        helper.fullAccessRequest(component, event, helper);
        component.set("v.isModalOpen", false);
        component.find("PaidUserRequest").set("v.checked", false);

    },
    doInit: function(component, event, helper) {
         helper.getUserData(component, event, helper);
    },

    openModelPopUp : function(component, event, helper) {
        // Set isModalOpen attribute to true
        debugger;
        component.set("v.isModalOpen", true);
     },
     
     closeModel: function(component, event, helper) {
        // Set isModalOpen attribute to false  
        component.set("v.isModalOpen", false);
        component.find("PaidUserRequest").set("v.checked", false);
     },
   
})