/**
 * Created by Sido_ on 12.10.2021.
 */

trigger LeadTriggerTask1 on Lead (after insert) {
    if(Trigger.isAfter){
        if(Trigger.isInsert){
            LeadTriggerTask1Handler.UpdatePhoneRecord(Trigger.newMap.keySet());
        }
    }
}