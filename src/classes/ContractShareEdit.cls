public class ContractShareEdit {

    public static void shareEdit(Set<Id> contractIds) {
        List<Contract> contracts = ContractManager.getAccountsById(contractIds);

        for (Contract contract : contracts) {
            List<Account> account = AccountManager.getAccountsById(new Set<Id>{
                    contract.AccountId
            });
            AccountShare share = new AccountShare();
            share.AccountId = account[0].Id;
            share.UserOrGroupId = contract.Shipping_CompanyUser__c;
            share.AccountAccessLevel = 'Edit';
            share.OpportunityAccessLevel = 'Read';
            Database.insert(share, false);
        }
    }
}