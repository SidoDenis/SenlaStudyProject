({
	fetchTaskStatusPicklist : function(component){
        var action = component.get("c.getPicklistvalues");
        action.setParams({
            'objectName': component.get("v.ObjectName"),
            'field_apiname': component.get("v.FieldName")
        });
        action.setCallback(this, function(a) {
            var state = a.getState();
            if (state === "SUCCESS"){
                component.set("v.StatusPicklist", a.getReturnValue());
            }
        });
        $A.enqueueAction(action);
    },
    updateTasks : function(component, status){
        var action = component.get("c.updateContacts");
        action.setParams({
            'status': status
        });
        action.setCallback(this, function(a) {
            var state = a.getState();
            if (state === "SUCCESS"){
                console.log("SUCCESS");
            }
        });
        $A.enqueueAction(action);
    }, 
})