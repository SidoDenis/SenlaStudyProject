/**
 * Created by Sido_ on 17.10.2021.
 */

({
    fetchAccountTypePicklist : function(component){
        let action = component.get("c.getPicklistValues");
        action.setParams({
            'objectName': component.get("v.AccountObjectName"),
            'field_apiName': component.get("v.TypeFieldName")
        });
        action.setCallback(this, function(a) {
            let state = a.getState();
            if (state === "SUCCESS"){
                component.set("v.AccountTypePicklist", a.getReturnValue());
            }
        });
        $A.enqueueAction(action);
    },
    fetchCargoTypePicklist : function(component){
        let action = component.get("c.getPicklistValues");
        action.setParams({
            'objectName': component.get("v.GlobalPicklistObjectName"),
            'field_apiName': component.get("v.CargoTypeFieldName")
        });
        action.setCallback(this, function(a) {
            let state = a.getState();
            if (state === "SUCCESS"){
                component.set("v.CargoTypePicklist", a.getReturnValue());
            }
        });
        $A.enqueueAction(action);
    },
    fetchCitiesPicklist : function(component){
        let action = component.get("c.getPicklistValues");
        action.setParams({
            'objectName': component.get("v.GlobalPicklistObjectName"),
            'field_apiName': component.get("v.CitiesFieldName")
        });
        action.setCallback(this, function(a) {
            let state = a.getState();
            if (state === "SUCCESS"){
                component.set("v.CitiesPicklist", a.getReturnValue());
            }
        });
        $A.enqueueAction(action);
    },
    checkValidity : function (component){
        let allValid = true;

        let accountNameValidity = component.find("companyName").get("v.validity").valid;
        let accountEmailValidity = component.find("companyEmail").get("v.validity").valid;
        let accountPhoneValidity = component.find("companyPhone").get("v.validity").valid;
        let accountTypeValidity = component.find("accountType").get("v.validity").valid;

        let contactFirstNameValidity = component.find("contactFirstName").get("v.validity").valid;
        let contactLastNameValidity = component.find("contactLastName").get("v.validity").valid;
        let contactEmailValidity = component.find("contactEmail").get("v.validity").valid;
        let contactPhoneValidity = component.find("contactMobilePhone").get("v.validity").valid;

        let shippingNameValidity = component.find("shippingName").get("v.validity").valid;
        let cargoWeightValidity = component.find("cargoWeight").get("v.validity").valid;
        let cargoTypeValidity = component.find("cargoType").get("v.validity").valid;
        let fromCityValidity = component.find("fromCityPicklist").get("v.validity").valid;
        let toCityValidity = component.find("toCityPicklist").get("v.validity").valid;
        let dateValidity = component.find("dateShipping").get("v.validity").valid;

        if(!accountNameValidity || !accountEmailValidity || !accountPhoneValidity || !accountTypeValidity
            || !contactFirstNameValidity || !contactLastNameValidity || !contactEmailValidity || !contactPhoneValidity
            || !shippingNameValidity || !cargoWeightValidity || !cargoTypeValidity || !fromCityValidity
            || !toCityValidity || !dateValidity){
            allValid = false;
        }

        console.log(allValid);

        let pattern = new RegExp("^\\+375[0-9]{2}[0-9]{7}$|^\\+7[0-9]{3}[0-9]{7}$|^\\+48[0-9]{2}[0-9]{7}$");
        let accountPhone = component.find("companyPhone");
        let accountPhoneValue = accountPhone.get("v.value");
        if(!pattern.test(accountPhoneValue)){
            //accountPhone[0].setCustomValidity("Invalid phone number");
            //accountPhone[0].reportValidity();
            allValid = false;
        }

        console.log(allValid);

        let fromCity = component.find("fromCityPicklist");
        let fromCityValue = fromCity.get("v.value");
        let toCity = component.find("toCityPicklist");
        let toCityValue = toCity.get("v.value");

        if(fromCityValue === toCityValue){
            //fromCity[0].setCustomValidity("Fields must be equal");
            //toCity[0].setCustomValidity("Fields must be equal");
            //fromCity[0].reportValidity();
            //toCity[0].reportValidity();
            allValid = false;
        }
        console.log(allValid);

        return allValid;
    },
    clearFields: function (component){
        let accountName = component.find("companyName");
        let accountEmail = component.find("companyEmail");
        let accountPhone = component.find("companyPhone");
        let accountType = component.find("accountType");

        let contactFirstName = component.find("contactFirstName");
        let contactLastName = component.find("contactLastName");
        let contactEmail = component.find("contactEmail");
        let contactPhone = component.find("contactMobilePhone");

        let shippingName = component.find("shippingName");
        let cargoWeight = component.find("cargoWeight");
        let cargoType = component.find("cargoType");
        let fromCity = component.find("fromCityPicklist");
        let toCity = component.find("toCityPicklist");
        let date = component.find("dateShipping");


        accountName.set("v.value",null);
        accountEmail.set("v.value",null);
        accountPhone.set("v.value",null);
        accountType.set("v.value",null);
        contactFirstName.set("v.value",null);
        contactLastName.set("v.value",null);
        contactEmail.set("v.value",null);
        contactPhone.set("v.value",null);
        shippingName.set("v.value",null);
        cargoWeight.set("v.value",null);
        cargoType.set("v.value",null);
        fromCity.set("v.value",null);
        toCity.set("v.value",null);
        date.set("v.value",null);
    },
    launchCreateRequest: function (component) {
        let accountType = component.find("accountType").get("v.value");
        let cargoType = component.find("cargoType").get("v.value");
        let fromCity = component.find("fromCityPicklist").get("v.value");
        let toCity = component.find("toCityPicklist").get("v.value");
        let action = component.get("c.launchSequence");
        action.setParams({
            'companyName': component.get("v.CompanyName"),
            'companyEmail': component.get("v.CompanyEmail"),
            'companyPhone': component.get("v.CompanyPhone"),
            'accountType': accountType,

            'contactFirstName': component.get("v.ContactFirstName"),
            'contactLastName': component.get("v.ContactLastName"),
            'contactEmail': component.get("v.ContactEmail"),
            'contactMobilePhone': component.get("v.ContactMobilePhone"),

            'shippingName': component.get("v.ShippingName"),
            'cargoWeight': component.get("v.CargoWeight"),
            'cargoType': cargoType,
            'fromCity': fromCity,
            'toCity': toCity,
            'dateValue': component.get("v.DateValue"),
        });
        $A.enqueueAction(action);
    }
});