/**
 * Created by Sido_ on 12.10.2021.
 */

trigger ContactTriggerTask1 on Contact (after insert) {
    if(Trigger.isAfter){
        if(Trigger.isInsert){
            ContactTriggerTask1Handler.updatePhoneRecord(Trigger.newMap.keySet());
        }
    }
}