public class ContactTriggerHandler extends TriggerHandler {

    public override void afterInsert(Map<Id, SObject> newRecordsMap) {
        ContactHandler.updatePhoneRecord(newRecordsMap.keySet());
    }
    public override void beforeInsert(List<SObject> newRecords) {

    }

    public override void beforeUpdate(Map<Id, SObject> updatedRecordsMap, Map<Id, SObject> oldRecordsMap) {

    }

    public override void beforeDelete(Map<Id, SObject> deletedRecordsMap) {

    }

    public override void afterUpdate(Map<Id, SObject> updatedRecordsMap, Map<Id, SObject> oldRecordsMap) {

    }

    public override void afterDelete(Map<Id, SObject> deletedRecordsMap) {

    }

    public override void afterUndelete(Map<Id, SObject> undeletedRecordsMap) {

    }
}