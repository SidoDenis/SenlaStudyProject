@IsTest
private class RestWebServiceTest {
    @IsTest
    static void testGetOrdersByClientId() {
        Test.setMock(HttpCalloutMock.class, new MockHttpResponseGenerator());

        Account newAccount = new Account();
        newAccount.Name = 'Name';
        newAccount.OwnerId = '0055g0000097xI2AAI';
        insert newAccount;

        Contact contact = new Contact();
        contact.Phone = 'phone';
        contact.FirstName = 'test';
        contact.LastName = 'test';
        contact.AccountId = newAccount.Id;
        insert contact;

        RestRequest request = new RestRequest();
        request.requestURI =
                'https://senla-4b-dev-ed.my.salesforce.com/services/apexrest/AC/'
                        + contact.Id;
        request.httpMethod = 'GET';
        RestContext.request = request;

        RestWebService.Response response = RestWebService.getOrdersByClientId();

        System.assert(response != null);
        System.assertEquals(response.clientId, contact.Id);
    }
}