trigger ContractTrigger on Contract (after insert) {
    ContractTriggerHandler handler = new ContractTriggerHandler();
    handler.execute();
}