({
    onInit : function(component,event,helper){
      var page = component.get("v.page") || 1;
      helper.getDownloadData(component, page);
      component.set("v.downloadColumns",[
            {
                label : 'Downloaded By',
                fieldName : 'DownloadedBy',
                type : 'text',
                
            },
            {
                label : 'Download Date',
                fieldName : 'CreatedDate',
                type : 'date',
                typeAttributes:{
                    year: "numeric",
                    month: "long",
                    day: "2-digit",
                    hour: "2-digit",
                    minute: "2-digit"
                }
            },
        ]);
            
      
   },
          
   navigate: function(component, event, helper) {
      var page = component.get("v.page") || 1;
      var direction = event.getSource().get("v.label");
      var recordToDisply = 5;
      page = direction === "Previous" ? (page - 1) : (page + 1);
      helper.getDownloadData(component, page);
 
   },
 
   
})