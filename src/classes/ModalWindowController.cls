public with sharing class ModalWindowController {

    @AuraEnabled(Cacheable = true)
    public static List<Offer__c> getOffersWithStatusNew() {
        return OfferManager.getOffersByStatus(ConstantsClass.NEW_STATUS);
    }

    @AuraEnabled
    public static void launchSequence(Offer__c offer, Id orderId) {
        if (offer == null) return;
        List<Order> orders = OrderManager.getOrdersById(new Set<Id>{
                orderId
        });
        ContractService.createContract(orders[0], offer);

        Opportunity opportunity = orders[0].Opportunity;
        opportunity.StageName = ConstantsClass.OPPORTUNITY_STAGE_NAME;
        update opportunity;

        offer.Status__c = ConstantsClass.OFFER_WINNER_STATUS;
        update offer;

        List<Offer__c> loserOffers = getOffersWithStatusNew();
        for (Offer__c loserOffer : loserOffers) {
            loserOffer.Status__c = ConstantsClass.OFFER_LOSER_STATUS;
            update loserOffer;
        }
    }
}