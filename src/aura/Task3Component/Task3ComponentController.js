({
    createRequest: function (component, event, helper) {
        let companyValid = component.get("v.CompanyValid");
        let contactValid = component.get("v.ContactValid");
        let otherValid = component.get("v.OtherValid");
        if (companyValid && contactValid && otherValid) {
            helper.launchCreateRequest(component);
            helper.clearFields(component);
            helper.fireToast(component);
        }
    },
    handleCompanyInfoEvent: function (component, event, helper) {
        helper.setCompanyInfo(component, event);
    },
    handleContactInfoEvent: function (component, event, helper) {
        helper.setContactInfo(component, event);
    },
    handleOtherInfoEvent: function (component, event, helper) {
        helper.setOtherInfo(component, event);
    }
});