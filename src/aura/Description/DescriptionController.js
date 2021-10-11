({
	saveDescription : function(component, event, helper) {
        let description = component.get("v.description");
        component.set("v.descriptionLine", description);
	},
    
    showHideDescription : function(component, event, helper) {
        let flag = component.get("v.isDescriptionShown");
        console.log(flag);
        if (!flag){component.set("v.isDescriptionShown", true);} 
        else {component.set("v.isDescriptionShown", false);}
	}
})