({
    fetchAccountTypePicklist : function(component){
        let action = component.get("c.getPicklistValues");
        action.setParams({
            'objectName': component.get("v.AccountObjectName"),
            'field_apiName': component.get("v.TypeFieldName")
        });
        action.setCallback(this, function(a) {
            let state = a.getState();
            if (state === "SUCCESS"){
                component.set("v.AccountTypePicklist", a.getReturnValue());
            }
        });
        $A.enqueueAction(action);
    },
});