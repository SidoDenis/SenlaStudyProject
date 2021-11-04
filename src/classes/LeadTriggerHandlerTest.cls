@IsTest
private class LeadTriggerHandlerTest {
    @IsTest
    static void testUpdatePhoneRecord() {
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());

        Lead lead = new Lead();
        lead.FirstName = 'test';
        lead.LastName = 'test';
        lead.Phone = '+375298897139';
        lead.Company = 'Company';

        Test.startTest();
        Database.SaveResult result = Database.insert(lead);
        Test.stopTest();

        System.assert(result.isSuccess());
        System.assert(result.getErrors().size() == 0);
        System.assertEquals('Belarus', [SELECT Id,Country_from_phone__c FROM Lead WHERE FirstName = 'test'].Country_from_phone__c);
    }
}