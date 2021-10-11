trigger triggerPlatform on Platform_event__c (after insert) {
    for( Id customId : Trigger.newMap.keySet() ){
        Contact updatedContact = (Contact) JSON.deserialize(Trigger.newMap.get(customId).RawData__c, Contact.class);
        List <Account> accounts = [SELECT Id, Name, Owner.Name, Phone, Type FROM Account WHERE Id = :updatedContact.AccountId];
        Account account = accounts[0];
        account.Phone = updatedContact.Phone;
        account.Description = updatedContact.Description;
        update account;
    }
}