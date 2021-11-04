({
    init: function (cmp, event, helper) {
        cmp.set('v.myColumns', [
            {initialWidth: 100, label: 'Name', fieldName: 'Name'},
            {initialWidth: 100, label: 'Min. Price $', fieldName: 'Min_Price__c', type: 'Currency'},
            {initialWidth: 100, label: 'Max. Price $', fieldName: 'Max_Price__c', type: 'Currency'},
            {initialWidth: 100, label: 'Closed Date', fieldName: 'Closed_Date__c', type: 'Date'},
            {initialWidth: 100, label: 'Shipping Company', fieldName: 'Shipping_Company_Owner__c'}
        ]);
        helper.getData(cmp);
    },
    closeModal: function (cmp, event, helper) {
        helper.closeWindow();
    },
    createNewContract: function (cmp, event, helper) {
        helper.launchSequence(cmp);
        helper.closeWindow();
    },
    changeSelectedRow: function (cmp, event, helper) {
        let selectedRows = event.getParam('selectedRows');
        cmp.set("v.selectedRow", selectedRows[0]);
    }
});