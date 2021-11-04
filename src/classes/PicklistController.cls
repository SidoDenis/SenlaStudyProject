public with sharing class PicklistController {

    @AuraEnabled(Cacheable = true)
    public static List<String> getPicklistValues(String objectName, String field_apiName) {
        List<String> optionList = new List<String>();
        Map<String, Schema.SObjectType> gd = Schema.getGlobalDescribe();
        Map<String, Schema.SObjectField> field_map = gd.get(objectName.toLowerCase()).getDescribe().fields.getMap();
        List<Schema.PicklistEntry> picklistValues = field_map.get(field_apiName).getDescribe().getPickListValues();
        for (Schema.PicklistEntry pv : picklistValues) {
            optionList.add(pv.getValue());
        }
        return optionList;
    }
}