public class LeadManager {
    public static List<Lead> getLeads(List<String> fieldApiNames, Set<Id> leadIds){
        String query = 'Select ' + String.join(fieldApiNames, ',') + ' From Lead Where id in:leadIds';
        List<sObject> sobjList = Database.query(query);
        return sobjList;
    }
    
    public void create(){
        Lead lead = new Lead(LastName = 'lastname', Company = 'company');
        insert lead;
        System.debug('00Q5g000005zSZGEA2');
    }
}