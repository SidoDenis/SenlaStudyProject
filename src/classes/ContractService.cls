public with sharing class ContractService {

    public static Contract createContract(Order order, Offer__c offer) {
        Datetime dT = offer.Closed_Date__c;
        List<User> users = UserManager.getUsersByContact(order.ShipToContact);

        Contract contract = new Contract();
        contract.AccountId = order.AccountId;
        contract.OwnerId = UserInfo.getUserId();
        contract.Status = ConstantsClass.CONTRACT_DRAFT_STATUS;
        contract.SpecialTerms = offer.Special_Terms__c;
        contract.CustomerSignedDate = Date.newInstance(dT.year(), dT.month(), dT.day());
        contract.Price__c = (offer.Max_Price__c + offer.Min_Price__c) / 2;
        contract.ClientUser__c = users[0].Id;
        contract.Order__c = order.Id;
        contract.Shipping_CompanyUser__c = offer.Shipping_Company_Owner__c;
        contract.StartDate = Date.today();
        insert contract;
        return contract;
    }
}