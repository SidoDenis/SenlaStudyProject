/**
 * Created by Sido_ on 13.10.2021.
 */

public with sharing class DatabaseQueries {

    public static List<Lead> getLeadsByIds(Set<Id> leadIds){
        return [SELECT Id, Name, Phone FROM Lead WHERE Id = :leadIds];
    }

    public static List<Contact> getContactsByIds(Set<Id> contactIds){
        return [SELECT Id, Name, Phone FROM Contact WHERE Id = :contactIds];
    }
}