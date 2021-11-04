({
    fireEvent: function (component, valid) {
        let cmpEvent = component.getEvent("contactInformationEvent");
        cmpEvent.setParams({
            "ContactFirstName": component.find("contactFirstName").get("v.value"),
            "ContactLastName": component.find("contactLastName").get("v.value"),
            "ContactEmail": component.find("contactEmail").get("v.value"),
            "ContactMobilePhone": component.find("contactMobilePhone").get("v.value"),
            "FormValid": valid
        });
        cmpEvent.fire();
    },
    checkValidity: function (component) {
        let allValid = true;

        let contactFirstNameValidity = component.find("contactFirstName").get("v.validity").valid;
        let contactLastNameValidity = component.find("contactLastName").get("v.validity").valid;
        let contactEmailValidity = component.find("contactEmail").get("v.validity").valid;
        let contactPhoneValidity = component.find("contactMobilePhone").get("v.validity").valid;

        if (!contactFirstNameValidity || !contactLastNameValidity || !contactEmailValidity || !contactPhoneValidity) {
            allValid = false;
        }

        return allValid;
    },
    clearAllContactFields: function (component) {
        let contactFirstName = component.find("contactFirstName");
        let contactLastName = component.find("contactLastName");
        let contactEmail = component.find("contactEmail");
        let contactPhone = component.find("contactMobilePhone");

        contactFirstName.set("v.value", null);
        contactLastName.set("v.value", null);
        contactEmail.set("v.value", null);
        contactPhone.set("v.value", null);
    }
});