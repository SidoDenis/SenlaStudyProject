public with sharing class AccountManager {

    public static List<Account> getAccountsById(Set<Id> accountIds) {
        return [
                SELECT Id, Email__c, Phone, Name, OwnerId
                FROM Account
                WHERE Id IN :accountIds
        ];
    }

    public static List<Account> getAccountsByEmail(String companyEmail) {
        return [
                SELECT Id, Email__c, Phone, Name, OwnerId
                FROM Account
                WHERE Email__c = :companyEmail
        ];
    }

    public static List<Account> getAccountsWithOrdersById(Set<Id> accountId) {
        return [
                SELECT Id, Name, (
                        SELECT Id, EffectiveDate, EndDate, Status, SLA_Offers_Date__c, Cargo_weight__c, Cargo_type__c, To_City__c, From_City__c
                        FROM Orders
                )
                FROM Account
                WHERE Id IN :accountId
        ];
    }
}