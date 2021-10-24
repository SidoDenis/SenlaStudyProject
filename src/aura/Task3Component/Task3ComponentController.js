/**
 * Created by Sido_ on 17.10.2021.
 */

({
    doInit: function(component, event, helper) {
        helper.fetchAccountTypePicklist(component);
        helper.fetchCargoTypePicklist(component);
        helper.fetchCitiesPicklist(component);
    },
    createRequest: function (component, event, helper){
        let allValid = helper.checkValidity(component);
        if(allValid){
            helper.launchCreateRequest(component);
            helper.clearFields(component);
        }
    },
});