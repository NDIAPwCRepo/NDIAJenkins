({
   getDownloadData : function(component, page){
        var parentid;
        var action = component.get("c.getViews");
        action.setParams({
             parentid: component.get("v.recordId"),
             pageNumber: page,
        });
        console.log(parentid);
        action.setCallback(this,function(response){
            var state = response.getState();
            if(state == "SUCCESS"){
                debugger;
                var downloadWrapper = response.getReturnValue();
                debugger;
                //console.log('length: '+downloadWrapper.downloadList.length);
                if(downloadWrapper.downloadList!=null && downloadWrapper.downloadList.length > 0){
                    if(downloadWrapper.success){
                   //console.log('BLOCK 1');
              for (var i = 0; i < downloadWrapper.downloadList.length; i++) {
	                var downloadWrappers = downloadWrapper.downloadList[i];
                    downloadWrappers.DownloadedBy = downloadWrappers.CreatedBy.Name;
              }
                    component.set("v.downloadData",downloadWrapper.downloadList);
                    component.set("v.page", downloadWrapper.page);
     			    component.set("v.total", downloadWrapper.total);
             		component.set("v.pages", Math.ceil(downloadWrapper.total/5));
                } 

                }else{
                    component.set("v.NoRecordsFound" , true);
                }
                    
            }
          
        });
        $A.enqueueAction(action);
    },
  })