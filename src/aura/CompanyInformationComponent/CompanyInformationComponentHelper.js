({
    fetchAccountTypePicklist: function (component) {
        let action = component.get("c.getPicklistValues");
        action.setParams({
            'objectName': component.get("v.AccountObjectName"),
            'field_apiName': component.get("v.TypeFieldName")
        });
        action.setCallback(this, function (a) {
            let state = a.getState();
            if (state === "SUCCESS") {
                component.set("v.AccountTypePicklist", a.getReturnValue());
            }
        });
        $A.enqueueAction(action);
    },
    fireEvent: function (component, valid) {
        let cmpEvent = component.getEvent("companyInformationEvent");
        cmpEvent.setParams({
            "CompanyName": component.find("companyName").get("v.value"),
            "CompanyEmail": component.find("companyEmail").get("v.value"),
            "CompanyPhone": component.find("companyPhone").get("v.value"),
            "AccountTypeOption": component.find("accountType").get("v.value"),
            "FormValid": valid,
        });
        cmpEvent.fire();
    },
    checkValidity: function (component) {
        let allValid = true;

        let accountNameValidity = component.find("companyName").get("v.validity").valid;
        let accountEmailValidity = component.find("companyEmail").get("v.validity").valid;
        let accountPhoneValidity = component.find("companyPhone").get("v.validity").valid;
        let accountTypeValidity = component.find("accountType").get("v.validity").valid;

        if (!accountNameValidity || !accountEmailValidity || !accountPhoneValidity || !accountTypeValidity) {
            allValid = false;
        }

        let pattern = new RegExp("^\\+375[0-9]{2}[0-9]{7}$|^\\+7[0-9]{3}[0-9]{7}$|^\\+48[0-9]{2}[0-9]{7}$");
        let accountPhone = component.find("companyPhone");
        let accountPhoneValue = accountPhone.get("v.value");
        if (!pattern.test(accountPhoneValue)) {
            //accountPhone.showHelpMessageIfInvalid("Invalid Phone Number");
            allValid = false;
        }

        return allValid;
    },
    clearAllCompanyFields: function (component) {
        let accountName = component.find("companyName");
        let accountEmail = component.find("companyEmail");
        let accountPhone = component.find("companyPhone");
        let accountType = component.find("accountType");

        accountName.set("v.value", null);
        accountEmail.set("v.value", null);
        accountPhone.set("v.value", null);
        accountType.set("v.value", null);
    }
});