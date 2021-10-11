public with sharing class ContactController {
    @AuraEnabled
    public static List<Task> getContacts() {
        List<Task> tasks = [SELECT Id, Subject, Status, ActivityDate, Description FROM Task];
        return tasks;
    }
}