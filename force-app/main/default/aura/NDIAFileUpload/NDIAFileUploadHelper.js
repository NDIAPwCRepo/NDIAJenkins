({  
    getuploadedFiles:function(component){
        var action = component.get("c.getFiles");
        var description=component.get('v.description');
       // var uploadedFiles = event.getParam("files");  
       // var documentId = uploadedFiles[0].documentId;  
        
        debugger; 
        action.setParams({  
            "recordId":component.get("v.recordId"),
            "documentId":component.get("v.documentId"),
            "description":description
        });      
        action.setCallback(this,function(response){  
            var state = response.getState();  
            if(state=='SUCCESS'){  
                var result = response.getReturnValue();           
                component.set("v.files",result);  
            }  
        });  
        $A.enqueueAction(action);  
    },
    
    delUploadedfiles : function(component,documentId) {  
        var action = component.get("c.deleteFiles");           
        action.setParams({
            "sdocumentId":documentId            
        });  
        action.setCallback(this,function(response){  
            var state = response.getState();  
            if(state=='SUCCESS'){  
                this.getuploadedFiles(component);
                component.set("v.Spinner", false); 
            }  
        });  
        $A.enqueueAction(action);  
    },  
 })