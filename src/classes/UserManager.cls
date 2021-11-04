public with sharing class UserManager {

    public static List<User> getUsersByProfile(String profileName) {
        return [
                SELECT Id, Profile.Name, Profile.Id
                FROM User
                WHERE Profile.Name = :profileName
                AND IsActive = TRUE
        ];
    }

    public static List<User> getUsersByContact(Contact contact){
        return [
                SELECT Id, Contact.Id
                FROM User
                WHERE Contact.Id = :contact.Id
        ];
    }
}