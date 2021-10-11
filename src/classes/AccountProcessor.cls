global class AccountProcessor {
    @future
    public static void countContacts(List<Id> recordIds){
        List<Account> accounts = [Select Id, Name from Account Where Id IN :recordIds];
        for(Account account : accounts){
            account.Number_Of_Contacts__c = account.Contacts.size();
            update account;
        }
    }
}