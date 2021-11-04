({
    doInit: function (component, event, helper) {
        helper.fetchCargoTypePicklist(component);
        helper.fetchCitiesPicklist(component);
    },
    handleChange: function (component, event, helper) {
        let valid = helper.checkValidity(component);
        helper.fireEvent(component, valid);
    },
    clearOtherFields: function (component, event, helper) {
        helper.clearAllOtherFields(component);
    }
});