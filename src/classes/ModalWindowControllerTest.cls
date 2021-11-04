@IsTest
private class ModalWindowControllerTest {

    @IsTest(SeeAllData=true)
    static void testCreateContract() {
        List<Account> accounts = [SELECT Id FROM Account];
        List<Contact> contacts = [SELECT Id, OwnerId, IndividualId FROM Contact];
        Order order = new Order();
        order.AccountId = accounts[0].Id;
        order.ShipToContact = contacts[0];
        order.EffectiveDate = Date.today();
        order.Status = 'New';
        insert order;

        Offer__c offer = new Offer__c();
        offer.Closed_Date__c = Datetime.now();
        offer.Special_Terms__c = 'terms';
        offer.Max_Price__c = 100;
        offer.Min_Price__c = 50;
        offer.Shipping_Company_Owner__c = contacts[0].OwnerId;
        insert offer;

        Contract contract = ContractService.createContract(order, offer);
        System.assertEquals(contract.SpecialTerms, offer.Special_Terms__c);
    }
}