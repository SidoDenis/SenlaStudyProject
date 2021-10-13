/**
 * Created by Sido_ on 12.10.2021.
 */

public with sharing class ContactTriggerTask1Handler {

    @Future(Callout = true)
    public static void UpdatePhoneRecord(Set<Id> contactIds){
        List <Contact> contacts = [SELECT Id, Name, Phone FROM Contact WHERE Id = :contactIds];

        for(Contact contact : contacts){
            String phoneNumber = contact.Phone;
            String phoneCode = '';
            if(phoneNumber.contains('+375')){
                phoneCode = '375';
            } else if(phoneNumber.contains('+7')){
                phoneCode = '7';
            } else if(phoneNumber.contains('+48')){
                phoneCode = '48';
            } else {
                return;
            }

            Http http = new Http();
            HttpRequest httpRequest = new HttpRequest();
            httpRequest.setEndpoint('https://restcountries.com/v2/callingcode/'+phoneCode);
            httpRequest.setMethod('GET');
            HttpResponse response = http.send(httpRequest);

            if(response.getStatusCode() == 200) {
                String countryFromPhone = '';
                JSONParser parser = JSON.createParser(response.getBody());
                while (parser.nextToken() != null) {
                    if ((parser.getCurrentToken() == JSONToken.FIELD_NAME) &&
                            (parser.getText() == 'name')) {
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