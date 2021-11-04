public with sharing class LeadManager {

    public static List<Lead> getLeadsByIds(Set<Id> leadIds) {
        return [
                SELECT Id, Name, Phone
                FROM Lead
                WHERE Id IN :leadIds
        ];
    }

    public static List<Lead> getLeadsByPhoneOrEmail(String contactMobilePhone, String contactEmail) {
        return [
                SELECT Id, Email, Phone, FirstName, LastName
                FROM Lead
                WHERE Phone = :contactMobilePhone
                OR Email = :contactEmail
        ];
    }

    public static LeadStatus getLeadStatus() {
        return [
                SELECT Id, MasterLabel
                FROM LeadStatus
                WHERE IsConverted = TRUE
                LIMIT 1
        ];
    }
}