public class APIIIntegration {

    public class InvalidCodeException extends Exception {

    }

    public static String getPhoneCountry(String phoneCode){
        Http http = new Http();
        HttpRequest httpRequest = new HttpRequest();
        httpRequest.setEndpoint(ConstantsClass.ENDPOINT + phoneCode);
        httpRequest.setMethod(ConstantsClass.GET_METHOD);
        HttpResponse response = http.send(httpRequest);

        if (response.getStatusCode() == 200) {
            String countryFromPhone = '';
            JSONParser parser = JSON.createParser(response.getBody());
            while (parser.nextToken() != null) {
                if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) &&
                        (parser.getText() == ConstantsClass.NAME)) {
                    parser.nextToken();
                    countryFromPhone = parser.getText();
                    break;
                }
            }
            return countryFromPhone;
        } else {
            throw new InvalidCodeException('Invalid Phone Code');
        }
    }
}