public with sharing class ContactManager {

    public static List<Contact> getContactsByIds(Set<Id> contactIds) {
        return [
                SELECT Id, Name, Phone, AccountId
                FROM Contact
                WHERE Id IN :contactIds
        ];
    }

    public static List<Contact> getContactsByPhoneOrEmail(String contactMobilePhone, String contactEmail) {
        return [
                SELECT Id, AccountId, Email, Phone, FirstName, LastName
                FROM Contact
                WHERE Phone = :contactMobilePhone
                OR Email = :contactEmail
        ];
    }
}