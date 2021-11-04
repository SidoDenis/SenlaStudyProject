({
    handleChange: function (component, event, helper) {
        let valid = helper.checkValidity(component);
        helper.fireEvent(component, valid);
    },
    clearContactFields: function (component, event, helper) {
        helper.clearAllContactFields(component);
    }
});