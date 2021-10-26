/**
 * Created by Sido_ on 13.10.2021.
 */

public with sharing class DatabaseQueries {

    public static List<Lead> getLeadsByIds(Set<Id> leadIds){
        return [SELECT Id, Name, Phone FROM Lead WHERE Id = :leadIds];
    }

    public static List<Lead> getLeadsByPhoneOrEmail(String contactMobilePhone, String contactEmail){
        return [SELECT Id, Email, Phone, FirstName, LastName FROM Lead WHERE Phone = :contactMobilePhone OR Email = :contactEmail];
    }

    public static List<Contact> getContactsByIds(Set<Id> contactIds){
        return [SELECT Id, Name, Phone, AccountId FROM Contact WHERE Id = :contactIds];
    }

    public static List<Contact> getContactsByPhoneOrEmail(String contactMobilePhone, String contactEmail){
        return [SELECT Id, AccountId, Email, Phone, FirstName, LastName FROM Contact WHERE Phone = :contactMobilePhone OR Email = :contactEmail];
    }

    public static List<Account> getAccountsById(Set<Id> accountIds){
        return [SELECT Id, Email__c, Phone, Name, OwnerId FROM Account WHERE Id = :accountIds];
    }

    public static List<Account> getAccountsByEmail(String companyEmail){
        return [SELECT Id, Email__c, Phone, Name, OwnerId FROM Account WHERE Email__c = :companyEmail];
    }

    public static List<Account> getAccountsWithOrdersById(Set<Id> accountId){
        return [SELECT Id, Name,
        (SELECT Id, EffectiveDate, EndDate, Status, SLA_Offers_Date__c, Cargo_weight__c, Cargo_type__c, To_City__c, From_City__c FROM Orders)
        FROM Account WHERE Id = :accountId];
    }

    public static Group getGroupByTypeAndDevName(String groupType, String groupDevName){
        return [SELECT Id FROM Group WHERE Type = :groupType AND DeveloperName = :groupDevName];
    }

    public static List<User> getUsersByProfile(String profileName){
        return [SELECT Id, Profile.Name, Profile.Id FROM User WHERE Profile.Name = :profileName AND IsActive = TRUE];
    }

    public static LeadStatus getLeadStatus(){
        return [SELECT Id, MasterLabel FROM LeadStatus WHERE IsConverted=TRUE LIMIT 1];
    }

    public static CustomNotificationType getTypeByDeveloperName(String developerName){
        return [SELECT Id,CustomNotifTypeName FROM CustomNotificationType WHERE DeveloperName = :developerName];
    }
}