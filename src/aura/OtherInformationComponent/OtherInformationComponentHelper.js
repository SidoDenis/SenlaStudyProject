({
    fetchCargoTypePicklist: function (component) {
        let action = component.get("c.getPicklistValues");
        action.setParams({
            'objectName': component.get("v.GlobalPicklistObjectName"),
            'field_apiName': component.get("v.CargoTypeFieldName")
        });
        action.setCallback(this, function (a) {
            let state = a.getState();
            if (state === "SUCCESS") {
                component.set("v.CargoTypePicklist", a.getReturnValue());
            }
        });
        $A.enqueueAction(action);
    },
    fetchCitiesPicklist: function (component) {
        let action = component.get("c.getPicklistValues");
        action.setParams({
            'objectName': component.get("v.GlobalPicklistObjectName"),
            'field_apiName': component.get("v.CitiesFieldName")
        });
        action.setCallback(this, function (a) {
            let state = a.getState();
            if (state === "SUCCESS") {
                component.set("v.CitiesPicklist", a.getReturnValue());
            }
        });
        $A.enqueueAction(action);
    },
    fireEvent: function (component, valid) {
        let cmpEvent = component.getEvent("otherInformationEvent");
        cmpEvent.setParams({
            "ShippingName": component.find("shippingName").get("v.value"),
            "CargoWeight": component.find("cargoWeight").get("v.value"),
            "CargoTypeOption": component.find("cargoType").get("v.value"),
            "FromCityOption": component.find("fromCityPicklist").get("v.value"),
            "ToCityOption": component.find("toCityPicklist").get("v.value"),
            "DateValue": component.find("dateShipping").get("v.value"),
            "FormValid": valid
        });
        cmpEvent.fire();
    },
    checkValidity: function (component) {
        let allValid = true;

        let shippingNameValidity = component.find("shippingName").get("v.validity").valid;
        let cargoWeightValidity = component.find("cargoWeight").get("v.validity").valid;
        let cargoTypeValidity = component.find("cargoType").get("v.validity").valid;
        let fromCityValidity = component.find("fromCityPicklist").get("v.validity").valid;
        let toCityValidity = component.find("toCityPicklist").get("v.validity").valid;
        let dateValidity = component.find("dateShipping").get("v.validity").valid;

        if (!shippingNameValidity || !cargoWeightValidity || !cargoTypeValidity
            || !fromCityValidity || !toCityValidity || !dateValidity) {
            allValid = false;
        }

        let fromCity = component.find("fromCityPicklist");
        let fromCityValue = fromCity.get("v.value");
        let toCity = component.find("toCityPicklist");
        let toCityValue = toCity.get("v.value");

        if (fromCityValue === toCityValue) {
            //fromCity.showHelpMessageIfInvalid("Fields must not be equal");
            //toCity.showHelpMessageIfInvalid("Fields must not be equal");
            allValid = false;
        }

        return allValid;
    },
    clearAllOtherFields: function (component) {
        let shippingName = component.find("shippingName");
        let cargoWeight = component.find("cargoWeight");
        let cargoType = component.find("cargoType");
        let fromCity = component.find("fromCityPicklist");
        let toCity = component.find("toCityPicklist");
        let date = component.find("dateShipping");

        shippingName.set("v.value", null);
        cargoWeight.set("v.value", null);
        cargoType.set("v.value", null);
        fromCity.set("v.value", null);
        toCity.set("v.value", null);
        date.set("v.value", null);
    }
});