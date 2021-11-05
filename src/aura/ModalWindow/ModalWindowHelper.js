({
    getData: function (cmp) {
        let action = cmp.get("c.getOffersWithStatusNew");
        action.setCallback(this, $A.getCallback(function (response) {
            let state = response.getState();
            if (state === "SUCCESS") {
                cmp.set('v.myData', response.getReturnValue());
            } else if (state === "ERROR") {
                let errors = response.getError();
                console.error(errors);
            }
        }));
        $A.enqueueAction(action);
    },
    closeWindow: function () {
        $A.get("e.force:closeQuickAction").fire();
    },
    launchSequence: function (cmp) {
        let action = cmp.get("c.launchSequence");
        action.setParams({
            'offer': cmp.get("v.selectedRow"),
            'orderId': cmp.get("v.recordId")
        });
        action.setCallback(this, $A.getCallback(function (response) {
            let state = response.getState();
            if (state === "ERROR") {
                let errors = response.getError();
                console.error(errors);
            }
        }));
        $A.enqueueAction(action);
    }
});