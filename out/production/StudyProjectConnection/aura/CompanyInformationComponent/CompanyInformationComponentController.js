({
    doInit: function(component, event, helper) {
        helper.fetchAccountTypePicklist(component);
    },
    handleChange: function (component, event, helper){
        let cmpEvent = component.getEvent("companyInformationEvent");
        cmpEvent.setParams({
            "CompanyName" : component.find("companyName").get("v.value"),
            "CompanyEmail" : component.find("companyEmail").get("v.value"),
            "CompanyPhone" : component.find("companyPhone").get("v.value"),
            "AccountTypeOption" : component.find("accountType").get("v.value")
        });
        cmpEvent.fire();
    }
});