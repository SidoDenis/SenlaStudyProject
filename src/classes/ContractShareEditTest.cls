@IsTest
private class ContractShareEditTest {
    @IsTest
    static void testShareEdit() {
        List<User> users = [SELECT Id FROM User WHERE IsActive = TRUE LIMIT 2];
        Id userId = users[0].Id;
        Id ownerId = users[1].Id;

        Account account = new Account();
        account.Name = 'Name';
        account.OwnerId = ownerId;
        insert account;

        Contract contract = new Contract();
        contract.AccountId = account.Id;
        contract.OwnerId = ownerId;
        contract.Shipping_CompanyUser__c = userId;
        insert contract;

        List<AccountShare> accountShares = [SELECT Id, AccountId, UserOrGroupId, AccountAccessLevel FROM AccountShare];
        System.debug(accountShares);
        System.debug(users);
        System.debug(account.Id);
        System.debug(contract.Id);

        System.assertEquals(accountShares[0].UserOrGroupId, userId);
        System.assertEquals(accountShares[0].AccountAccessLevel, 'Edit');
    }
}