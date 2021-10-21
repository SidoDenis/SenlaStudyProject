/**
 * Created by Sido_ on 21.10.2021.
 */

@IsTest
private class PicklistControllerTest {
    @IsTest
    static void testCreateTask() {
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());

        Contact contact = new Contact();
        contact.Phone = 'phone';
        contact.FirstName = 'test';
        contact.LastName = 'test';
        insert contact;

        Task task = PicklistController.createTask(contact);
        System.assertEquals(contact.Phone, task.Mobile_Phone__c);
    }

    @IsTest
    static void testConvertLead(){
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());

        Lead lead = new Lead();
        String accountName = 'name';
        String accountEmail = 'sido_denis@list.ru';
        String accountPhone = 'phone';
        String accountType = 'type';
        String contactEmail = 'sido_denis@list.ru';
        String contactPhone = 'phone';
        String contactFirstName = 'firstname';
        String contactLastName = 'lastname';

        lead.FirstName = 'testFirstName';
        lead.LastName = 'testLastName';
        lead.Company = 'testCompany';
        lead.Phone = 'phone';
        insert lead;

        Contact contact = PicklistController.convertLead(lead, accountName, accountEmail, accountPhone, accountType,
                contactEmail, contactPhone, contactFirstName, contactLastName);
        System.assertEquals(contactPhone, contact.Phone);
    }

    @IsTest
    static void testCreateContact(){
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());

        Account account = new Account();
        String firstName = 'name';
        String lastName = 'name';
        String phone = 'phone';
        String email = 'sido_denis@list.ru';

        account.Name = 'Test account';
        account.OwnerId = '0055g0000097xI2AAI';
        insert account;

        Contact contact = PicklistController.createContact(account, firstName, lastName, phone, email);
        System.assertEquals(phone, contact.Phone);
    }

    @IsTest
    static void testCreateAccount(){
        String accountName = 'Name';
        String accountEmail = 'sido_denis@list.ru';
        String accountPhone = 'Phone';
        String accountType = 'Type';

        Account account = PicklistController.createAccount(accountName, accountEmail, accountPhone, accountType);
        System.assertEquals(accountName, account.Name);
    }

    @IsTest
    static void testCreateOpportunity(){
        Account account = new Account();
        account.Name = 'Name';
        account.OwnerId = '0055g0000097xI2AAI';

        String shippingName = 'name';
        Integer cargoWeight = 0;
        String cargoType = 'type';
        String fromCity = 'fromCity';
        String toCity = 'toCity';

        Opportunity opportunity = PicklistController.createOpportunity(account.Id, shippingName, cargoWeight,
                cargoType, fromCity, toCity);

        System.assertEquals(shippingName, opportunity.Shipping_name__c);
    }

    @IsTest(SeeAllData = true)
    static void testGetPicklistValues(){
        String objectName = 'Account';
        String field_apiName = 'Type';

        System.assertEquals(2, PicklistController.getPicklistValues(objectName, field_apiName).size());
    }
}