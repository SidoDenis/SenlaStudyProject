public with sharing class OpportunityService {

    public static Opportunity createOpportunity(Id id, String shippingName, Integer cargoWeight,
            String cargoType, String fromCity, String toCity) {

        Date newDate = Date.newInstance(Date.today().year(), Date.today().month(),
                Date.daysInMonth(Date.today().year(), Date.today().month()));

        Opportunity opportunity = new Opportunity();
        opportunity.Name = ConstantsClass.OPPORTUNITY_NAME;
        opportunity.AccountId = id;
        opportunity.Amount = 0;
        opportunity.StageName = ConstantsClass.NEW_STATUS;
        opportunity.CloseDate = newDate;
        opportunity.Probability = 10;
        opportunity.Shipping_name__c = shippingName;
        opportunity.Cargo_weight__c = cargoWeight;
        opportunity.Cargo_type__c = cargoType;
        opportunity.From_City__c = fromCity;
        opportunity.To_City__c = toCity;
        insert opportunity;
        return opportunity;
    }
}