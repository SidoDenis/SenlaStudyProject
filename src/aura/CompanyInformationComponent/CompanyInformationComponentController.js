({
    doInit: function (component, event, helper) {
        helper.fetchAccountTypePicklist(component);
    },
    handleChange: function (component, event, helper) {
        let valid = helper.checkValidity(component);
        helper.fireEvent(component, valid);
    },
    clearCompanyFields: function (component, event, helper) {
        helper.clearAllCompanyFields(component);
    }
});