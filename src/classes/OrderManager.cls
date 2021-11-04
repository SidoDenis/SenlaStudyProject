public with sharing class OrderManager {

    public static List<Order> getOrdersById(Set<Id> orderIds) {
        return [
                SELECT Id, AccountId, ShipToContact.IndividualId, Opportunity.StageName
                FROM Order
                WHERE Id IN :orderIds
        ];
    }
}