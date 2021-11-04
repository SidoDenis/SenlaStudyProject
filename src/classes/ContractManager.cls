public with sharing class ContractManager {

    public static List<Contract> getAccountsById(Set<Id> contractIds) {
        return [
                SELECT Id, Shipping_CompanyUser__c, AccountId
                FROM Contract
                WHERE Id IN :contractIds
        ];
    }
}