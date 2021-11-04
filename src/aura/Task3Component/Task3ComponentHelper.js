({
    clearFields: function (component) {
        let companyComponent = component.find('companyInformationComponent');
        let contactComponent = component.find('contactInformationComponent');
        let otherComponent = component.find('otherInformationComponent');

        companyComponent.ClearCompanyFields();
        contactComponent.ClearContactFields();
        otherComponent.ClearOtherFields();
    },
    launchCreateRequest: function (component) {
        let action = component.get("c.launchSequence");
        action.setParams({
            'companyName': component.get("v.CompanyName"),
            'companyEmail': component.get("v.CompanyEmail"),
            'companyPhone': component.get("v.CompanyPhone"),
            'accountType': component.get("v.AccountTypeOption"),

            'contactFirstName': component.get("v.ContactFirstName"),
            'contactLastName': component.get("v.ContactLastName"),
            'contactEmail': component.get("v.ContactEmail"),
            'contactMobilePhone': component.get("v.ContactMobilePhone"),

            'shippingName': component.get("v.ShippingName"),
            'cargoWeight': component.get("v.CargoWeight"),
            'cargoType': component.get("v.CargoTypeOption"),
            'fromCity': component.get("v.FromCityOption"),
            'toCity': component.get("v.ToCityOption"),
            'dateValue': component.get("v.DateValue"),
        });
        $A.enqueueAction(action);
    },
    fireToast: function () {
        let toastEvent = $A.get("e.force:showToast");
        toastEvent.setParams({
            "title": "Thank You!",
            "message": "Request was successfully sent"
        });
        toastEvent.fire();
    },
    setCompanyInfo: function (component, event) {
        component.set("v.CompanyName", event.getParam("CompanyName"));
        component.set("v.CompanyEmail", event.getParam("CompanyEmail"));
        component.set("v.CompanyPhone", event.getParam("CompanyPhone"));
        component.set("v.AccountTypeOption", event.getParam("AccountTypeOption"));
        component.set("v.CompanyValid", event.getParam("FormValid"));
    },
    setContactInfo: function (component, event) {
        component.set("v.ContactFirstName", event.getParam("ContactFirstName"));
        component.set("v.ContactLastName", event.getParam("ContactLastName"));
        component.set("v.ContactEmail", event.getParam("ContactEmail"));
        component.set("v.ContactMobilePhone", event.getParam("ContactMobilePhone"));
        component.set("v.ContactValid", event.getParam("FormValid"));
    },
    setOtherInfo: function (component, event) {
        component.set("v.ShippingName", event.getParam("ShippingName"));
        component.set("v.CargoWeight", event.getParam("CargoWeight"));
        component.set("v.CargoTypeOption", event.getParam("CargoTypeOption"));
        component.set("v.FromCityOption", event.getParam("FromCityOption"));
        component.set("v.ToCityOption", event.getParam("ToCityOption"));
        component.set("v.DateValue", event.getParam("DateValue"));
        component.set("v.OtherValid", event.getParam("FormValid"));
    },
});