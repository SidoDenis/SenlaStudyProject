public with sharing class AuraComponentController {

    @AuraEnabled
    public static void launchSequence(String companyName, String companyEmail, String companyPhone, String accountType,
            String contactFirstName, String contactLastName, String contactEmail, String contactMobilePhone,
            String shippingName, Integer cargoWeight, String cargoType, String fromCity, String toCity, String dateValue) {

        Date dateParsed = Date.parse(dateValue);

        List<Contact> contacts = ContactManager.getContactsByPhoneOrEmail(contactMobilePhone, contactEmail);
        if (!contacts.isEmpty()) {
            TaskService.createTask(contacts[0]);
            OpportunityService.createOpportunity(contacts[0].AccountId, shippingName, cargoWeight, cargoType, fromCity, toCity);
            return;
        }

        List<Lead> leads = LeadManager.getLeadsByPhoneOrEmail(contactMobilePhone, contactEmail);
        if (!leads.isEmpty()) {
            Contact contact = LeadService.convertLead(leads[0], companyName, companyEmail, companyPhone, accountType,
                    contactEmail, contactMobilePhone, contactFirstName, contactLastName);
            TaskService.createTask(contact);
            OpportunityService.createOpportunity(contact.AccountId, shippingName, cargoWeight, cargoType, fromCity, toCity);
            return;
        }

        List<Account> accounts = AccountManager.getAccountsByEmail(companyEmail);
        if (!accounts.isEmpty()) {
            Contact contact = ContactService.createContact(accounts[0], contactFirstName, contactLastName, contactMobilePhone, contactEmail);
            TaskService.createTask(contact);
            OpportunityService.createOpportunity(contact.AccountId, shippingName, cargoWeight, cargoType, fromCity, toCity);
        } else {
            Account account = AccountService.createAccount(companyName, companyEmail, companyPhone, accountType);
            Contact contact = ContactService.createContact(account, contactFirstName, contactLastName, contactMobilePhone, contactEmail);
            TaskService.createTask(contact);
            OpportunityService.createOpportunity(account.Id, shippingName, cargoWeight, cargoType, fromCity, toCity);
        }
    }
}