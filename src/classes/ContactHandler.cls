public with sharing class ContactHandler {

    @Future(Callout = true)
    public static void updatePhoneRecord(Set<Id> contactIds) {
        List <Contact> contacts = ContactManager.getContactsByIds(contactIds);

        for (Contact contact : contacts) {
            String phoneCode = '';

            for (String code : ConstantsClass.CODES) {
                if (contact.Phone.contains(code)) {
                    phoneCode = code.substring(1);
                    break;
                }
            }

            String countryFromPhone = APIIIntegration.getPhoneCountry(phoneCode);
            contact.Country_from_phone__c = countryFromPhone;

        }
        update contacts;
    }
}