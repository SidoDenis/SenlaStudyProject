public with sharing class ContactService {

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