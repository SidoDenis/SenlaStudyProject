public class LeadHandler {

    @Future(Callout = true)
    public static void updatePhoneRecord(Set<Id> leadIds) {
        List <Lead> leads = LeadManager.getLeadsByIds(leadIds);

        for (Lead lead : leads) {
            String phoneCode = '';

            for (String code : ConstantsClass.CODES) {
                if (lead.Phone.contains(code)) {
                    phoneCode = code.substring(1);
                    break;
                }
            }

            String countryFromPhone = APIIIntegration.getPhoneCountry(phoneCode);
            lead.Country_from_phone__c = countryFromPhone;
            update lead;
        }
    }
}