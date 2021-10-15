/**
 * Created by Sido_ on 13.10.2021.
 */

@IsTest
private class ContactTriggerTask1HandlerTest {
    @IsTest
    static void testUpdatePhoneRecord() {
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());

        Contact contact = new Contact();
        contact.FirstName = 'test';
        contact.LastName = 'test';
        contact.Phone = '+375298897139';
        contact.Language__c = 'RU';

        Test.startTest();
        Database.SaveResult result = Database.insert(contact);
        Test.stopTest();

        System.assert(result.isSuccess());
        System.assert(result.getErrors().size() == 0);
        System.assertEquals('Belarus', [SELECT Id,Country_from_phone__c FROM Contact WHERE FirstName = 'test'].Country_from_phone__c);
    }
}