@IsTest
private class SendOutdatedTasksNotificationTest {

    @TestSetup
    static void setup() {
        List<Task> tasks = new List<Task>();
        Id recordTypeId = Schema.SObjectType.Task.getRecordTypeInfosByDeveloperName()
                .get('Offers_Call').getRecordTypeId();

        for (Integer i = 0; i < 10; i++) {
            Task task = new Task();
            task.RecordTypeId = recordTypeId;
            task.OwnerId = '0055g0000097xI2AAI';
            task.Status = 'New';
            task.ActivityDate = Date.newInstance(2021, 9, 1);
            task.Priority = 'Low';
            tasks.add(task);
        }
        insert tasks;
    }

    @IsTest
    static void testBatch() {
        Test.startTest();
        SendOutdatedTasksNotification batch = new SendOutdatedTasksNotification();
        Id batchId = Database.executeBatch(batch);
        Test.stopTest();

        AsyncApexJob job = [SELECT Id, Status, NumberOfErrors, JobItemsProcessed FROM AsyncApexJob WHERE Id = :batchId];
        System.assertEquals('Completed', job.Status);
        System.assertEquals(0, job.NumberOfErrors);
        System.assertEquals(1, job.JobItemsProcessed);
    }
}