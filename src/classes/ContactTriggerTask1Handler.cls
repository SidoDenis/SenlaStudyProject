/**
 * Created by Sido_ on 12.10.2021.
 */

public with sharing class ContactTriggerTask1Handler {

    private final static String ENDPOINT = 'https://restcountries.com/v2/callingcode/';
    private final static String GET_METHOD = 'GET';
    private final static String NAME = 'name';
    private final static List<String> CODES = new List<String>{'+375', '+7', '+48'};

    @Future(Callout = true)
    public static void updatePhoneRecord(Set<Id> contactIds){
        List <Contact> contacts = DatabaseQueries.getContactsByIds(contactIds);

        for(Contact contact : contacts){
            String phoneCode = '';
            for(String code : CODES){
                if(contact.Phone.contains(code)){
                    phoneCode = code.substring(1);
                    break;
                }
            }

            Http http = new Http();
            HttpRequest httpRequest = new HttpRequest();
            httpRequest.setEndpoint(ENDPOINT + phoneCode);
            httpRequest.setMethod(GET_METHOD);
            HttpResponse response = http.send(httpRequest);

            if(response.getStatusCode() == 200) {
                String countryFromPhone = '';
                JSONParser parser = JSON.createParser(response.getBody());
                while (parser.nextToken() != null) {
                    if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) &&
                            (parser.getText() == NAME)) {
                        parser.nextToken();
                        countryFromPhone = parser.getText();
                        break;
                    }
                }
                contact.Country_from_phone__c = countryFromPhone;
                update contact;
            }
        }
    }
}