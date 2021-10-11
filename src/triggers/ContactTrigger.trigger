trigger ContactTrigger on Contact (after update) {
for( Id contactId : Trigger.newMap.keySet() ){
        if( Trigger.oldMap.get( contactId ).Phone != Trigger.newMap.get( contactId ).Phone ||
          Trigger.oldMap.get( contactId ).Description != Trigger.newMap.get( contactId ).Description){
              Platform_event__c event = new Platform_event__c();
              String JSONString = JSON.serialize(Trigger.newMap.get( contactId ));
              event.RawData__c = JSONString;
              insert event;
              //Trigger.newMap.get( contactId ).Description = JSONString;
        }
    }
}