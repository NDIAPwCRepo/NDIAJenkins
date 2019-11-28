({
    doInit:function(component,event,helper){  
        helper.getuploadedFiles(component);
    },      
    
    previewFile :function(component,event,helper){  
        var rec_id = event.currentTarget.id;  
        $A.get('e.lightning:openFiles').fire({ 
            recordIds: [rec_id]
        });  
    },  
    
    UploadFinished : function(component, event, helper) {  
        var uploadedFiles = event.getParam("files");  
        var documentId = uploadedFiles[0].documentId; 
        component.set('v.documentId',documentId);
        //var fileName = uploadedFiles[0].name; 
        
        helper.getuploadedFiles(component,documentId); 
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title": "Success!",
            "type" :"success",
            "message": "The record has been updated successfully."
        });
        toastEvent.fire();
        
        $A.get("e.force:closeQuickAction").fire();
         $A.get('e.force:refreshView').fire();
        
    }, 
    
    delFiles:function(component,event,helper){
        component.set("v.Spinner", true); 
        var documentId = event.currentTarget.id;        
        helper.delUploadedfiles(component,documentId);  
    }
})