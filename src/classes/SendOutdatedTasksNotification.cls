global class SendOutdatedTasksNotification implements Database.Batchable<SObject>, Schedulable {

    private String query;

    global SendOutdatedTasksNotification(String query) {
        this.query = query;
    }

    global Database.QueryLocator start(Database.BatchableContext bc) {
        return Database.getQueryLocator(query);
    }

    global void execute(Database.BatchableContext bc, List<Task> tasks) {
        CustomNotificationType type = NotificationManager.getTypeByDeveloperName(ConstantsClass.DEVELOPER_NAME);

        for (Task task : tasks) {
            Messaging.CustomNotification notification = new Messaging.CustomNotification();
            notification.setTitle(Label.Title);
            notification.setBody(Label.Body);
            notification.setNotificationTypeId(type.Id);
            notification.setTargetId(task.Id);
            notification.send(new Set<String>{
                    task.OwnerId
            });
        }
    }

    global void finish(Database.BatchableContext bc) {

    }

    global void execute(SchedulableContext sc) {
        Database.executeBatch(new SendOutdatedTasksNotification(ConstantsClass.QUERY));
    }
}