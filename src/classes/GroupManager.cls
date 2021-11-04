public with sharing class GroupManager {

    public static Group getGroupByTypeAndDevName(String groupType, String groupDevName) {
        return [
                SELECT Id
                FROM Group
                WHERE Type = :groupType
                AND DeveloperName = :groupDevName
        ];
    }
}