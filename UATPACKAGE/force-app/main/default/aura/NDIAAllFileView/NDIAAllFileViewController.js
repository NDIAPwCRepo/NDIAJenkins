({
    doInit : function(component, event, helper) {
        component.set('v.columns', [
            {label: 'File Name', fieldName: 'Title', type: 'text'}
            
        ]);
        helper.getFiledata(component, event, helper);
        
    },
    navigateToRecord : function(component, event, helper) {
        debugger;
        var navEvent = $A.get("e.force:navigateToSObject");
        var idx = event.target.id;
        $A.get('e.lightning:openFiles').fire({
            recordIds: [idx]
        });
    }
    ,
    openRelatedList: function(component, _event){
        var relatedListEvent = $A.get("e.force:navigateToRelatedList");
        relatedListEvent.setParams({
            "relatedListId": "AttachedContentDocuments",
            "parentRecordId": component.get("v.recordId")
        });
        relatedListEvent.fire();
    },
    redirectToSobject: function (component, event, helper) {
        var navEvt = $A.get("e.force:navigateToSObject");
        var idx = event.target.id;
        navEvt.setParams({
            "recordId": idx,
            "slideDevName": "Detail"
        });
        navEvt.fire();
    }
    
})