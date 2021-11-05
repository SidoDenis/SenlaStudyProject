public with sharing class OfferManager {

    public static List<Offer__c> getOffersByStatus(String status) {
        return [
                SELECT Id, Name, Max_Price__c, Min_Price__c, Closed_Date__c, Shipping_Company_Owner__r.Name, Special_Terms__c
                FROM Offer__c
                WHERE Status__c = :status
        ];
    }
}