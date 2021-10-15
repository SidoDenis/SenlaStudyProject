/**
 * Created by Sido_ on 15.10.2021.
 */

global class SendOutdatedTasksNotification implements Database.Batchable<SObject>, Schedulable{

    private final static String QUERY = 'SELECT ID, RecordType.name, OwnerId, ActivityDate, Status FROM Task';
    private final static String STATUS = 'New';
    private final static String NAME = 'Offers Call';
    private final static String DEVELOPER_NAME = 'Batch_Notification';

    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(QUERY);
    }

    global void execute(Database.BatchableContext bc, List<Task> tasks) {
        List<Task> outdatedTasks = new List<Task>();
        CustomNotificationType type = DatabaseQueries.getTypeByDeveloperName(DEVELOPER_NAME);

        for (Task task : tasks) {
            if (task.ActivityDate <= Date.today() && task.Status == STATUS && task.RecordType.Name == NAME) {
                outdatedTasks.add(task);
            }
        }
        System.debug(outdatedTasks);

        for (Task task : outdatedTasks) {
            Messaging.CustomNotification notification = new Messaging.CustomNotification();
            notification.setTitle(Label.Title);
            notification.setBody(Label.Body);
            notification.setNotificationTypeId(type.Id);
            notification.setTargetId(task.Id);
            notification.send(new Set<String>{task.OwnerId});
        }
    }

    global void finish(Database.BatchableContext bc) {
        AsyncApexJob job = [SELECT Id, Status, NumberOfErrors, JobItemsProcessed, TotalJobItems, CreatedBy.Email FROM AsyncApexJob WHERE Id = :bc.getJobId()];
        System.debug(job);
    }

    global void execute(SchedulableContext sc) {
        Database.executeBatch(new SendOutdatedTasksNotification());
    }
}