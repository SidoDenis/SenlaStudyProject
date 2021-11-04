public with sharing class AccountService {

    public static Account createAccount(String accountName, String accountEmail, String accountPhone, String accountType) {
        List<User> salesManagerUsers = UserManager.getUsersByProfile(ConstantsClass.PROFILE_NAME);

        Account account = new Account();
        account.OwnerId = salesManagerUsers[0].Id;
        account.Name = accountName;
        account.Email__c = accountEmail;
        account.Phone = accountPhone;
        account.Type = accountType;
        insert account;
        return account;
    }
}