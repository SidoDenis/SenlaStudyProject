public with sharing class NotificationManager {

    public static CustomNotificationType getTypeByDeveloperName(String developerName) {
        return [
                SELECT Id,CustomNotifTypeName
                FROM CustomNotificationType
                WHERE DeveloperName = :developerName
        ];
    }
}