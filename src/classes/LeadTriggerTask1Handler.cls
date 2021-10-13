/**
 * Created by Sido_ on 12.10.2021.
 */

public with sharing class LeadTriggerTask1Handler {

    @Future(Callout = true)
    public static void UpdatePhoneRecord(Set<Id> leadIds){
        List <Lead> leads = [SELECT Id, Name, Phone FROM Lead WHERE Id = :leadIds];

        for(Lead lead : leads) {
            String phoneNumber = lead.Phone;
            String phoneCode = '';
            if (phoneNumber.contains('+375')) {
                phoneCode = '375';
            } else if (phoneNumber.contains('+7')) {
                phoneCode = '7';
            } else if (phoneNumber.contains('+48')) {
                phoneCode = '48';
            } else {
                return;
            }

            Http http = new Http();
            HttpRequest httpRequest = new HttpRequest();
            httpRequest.setEndpoint('https://restcountries.com/v2/callingcode/' + phoneCode);
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
                lead.Country_from_phone__c = countryFromPhone;
                update lead;
            }
        }
    }
}