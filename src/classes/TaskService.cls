public with sharing class TaskService {

    public static Task createTask(Contact contact) {
        Id recordTypeId = Schema.SObjectType.Task.getRecordTypeInfosByDeveloperName().get(ConstantsClass.RECORD_TYPE).getRecordTypeId();
        Group queue = GroupManager.getGroupByTypeAndDevName(ConstantsClass.GROUP_TYPE, ConstantsClass.GROUP_DEV_NAME);

        Task newTask = new Task();
        newTask.RecordTypeId = recordTypeId;
        newTask.OwnerId = queue.Id;
        newTask.Status = ConstantsClass.NEW_STATUS;
        newTask.Theme__c = ConstantsClass.TASK_SUBJECT + contact.FirstName + ' ' + contact.LastName;
        newTask.Auto_Created_del__c = true;
        newTask.Priority = ConstantsClass.TASK_PRIORITY;
        newTask.Mobile_Phone__c = contact.Phone;
        newTask.ActivityDate = Date.today() + 3;
        newTask.Subject = ConstantsClass.TASK_SUBJECT;
        insert newTask;
        return newTask;
    }
}