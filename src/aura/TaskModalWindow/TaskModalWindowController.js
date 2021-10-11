({
	doInit: function(component, event, helper) {
        helper.fetchTaskStatusPicklist(component);
    },
    closeModal: function (cmp, event, helper) {
        var cmpEvent = cmp.getEvent("modalEvent");
        cmpEvent.setParams({"isShown" : "false" });
        cmpEvent.fire();
    },
    handleSave: function (cmp, event, helper) {
        var status = cmp.find("taskStatus").get("v.value");
        helper.updateTasks(cmp, status);
        
        var cmpEvent = cmp.getEvent("modalEvent");
        cmpEvent.setParams({"isShown" : "false" });
        cmpEvent.fire();
        
        cmpEvent = cmp.getEvent("toastEvent");
        console.log(cmpEvent.getParams("isChanged"));
        cmpEvent.setParams({"isChanged" : "true" });
        cmpEvent.fire();
    }
})