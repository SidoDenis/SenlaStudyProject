@IsTest
global class MockHttpResponseGenerator implements HttpCalloutMock {

    global HttpResponse respond(HttpRequest req) {
        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{"name":"Belarus"}');
        res.setStatusCode(200);
        return res;
    }
}