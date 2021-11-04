public with sharing class LeadService {

    public static Contact convertLead(Lead lead, String accountName, String accountEmail, String accountPhone, String accountType,
            String contactEmail, String contactPhone, String contactFirstName, String contactLastName) {
        List<User> salesManagerUsers = UserManager.getUsersByProfile(ConstantsClass.PROFILE_NAME);

        Database.LeadConvert lc = new Database.LeadConvert();
        lc.setLeadId(lead.Id);
        LeadStatus convertStatus = LeadManager.getLeadStatus();
        lc.setConvertedStatus(convertStatus.MasterLabel);
        Database.LeadConvertResult lcr = Database.convertLead(lc);

        List<Account> accounts = AccountManager.getAccountsById(new Set<Id>{
                lcr.accountId
        });
        Account account = accounts[0];
        account.Name = accountName;
        account.OwnerId = salesManagerUsers[0].Id;
        account.Email__c = accountEmail;
        account.Phone = accountPhone;
        account.Type = accountType;
        update account;

        List<Contact> contacts = ContactManager.getContactsByIds(new Set<Id>{
                lcr.contactId
        });
        Contact contact = contacts[0];
        contact.AccountId = account.Id;
        contact.OwnerId = salesManagerUsers[0].Id;
        contact.Email = contactEmail;
        contact.Phone = contactPhone;
        contact.Language__c = ConstantsClass.LANGUAGE;
        contact.FirstName = contactFirstName;
        contact.LastName = contactLastName;
        update contact;
        return contact;
    }

    public static Contact createContact(Account account, String firstName, String lastName, String phone, String email) {
        Contact contact = new Contact();
        contact.AccountId = account.Id;
        contact.OwnerId = account.OwnerId;
        contact.Language__c = ConstantsClass.LANGUAGE;
        contact.FirstName = firstName;
        contact.LastName = lastName;
        contact.Phone = phone;
        contact.Email = email;
        insert contact;
        return contact;
    }
}