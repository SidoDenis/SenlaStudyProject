({
    handleChange: function (component, event){
        let cmpEvent = component.getEvent("contactInformationEvent");
        cmpEvent.setParams({
            "ContactFirstName" : component.find("contactFirstName").get("v.value"),
            "ContactLastName" : component.find("contactLastName").get("v.value"),
            "ContactEmail" : component.find("contactEmail").get("v.value"),
            "ContactMobilePhone" : component.find("contactMobilePhone").get("v.value")
        });
        cmpEvent.fire();
    }
});