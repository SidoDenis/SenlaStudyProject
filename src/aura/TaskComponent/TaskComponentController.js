({
	init: function (cmp, event, helper) {
        cmp.set('v.mycolumns', [
            { label: 'Subject', fieldName: 'Subject', type: 'Picklist'},
            { label: 'Status', fieldName: 'Status', type: 'Picklist'},
            { label: 'Due date', fieldName: 'ActivityDate', type: 'Date'},
            { label: 'Comments', fieldName: 'Description', type: 'Long Text Area'}
        ]);
        helper.getData(cmp);
    },
    openModal: function (cmp, event, helper) {
        var cmpEvent = cmp.getEvent("modalEvent");
        cmpEvent.setParams({
            "isShown" : "true" });
        cmpEvent.fire();
    },
    handleComponentEvent : function(cmp, event) {
        var flag = event.getParam("isShown");
        cmp.set("v.isModalShown", flag);
    },
    handleToastEvent : function(component, event, helper) {
        var toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title": "Success!",
            "message": "The record has been updated successfully."
        });
        toastEvent.fire();
    }
})