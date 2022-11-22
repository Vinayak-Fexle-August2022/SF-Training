/**
*
*  Purpose          :	Trigger on Contact object.
*
*  Created Date     :  	14/10/2022
*
*  Created By       :  	Vinayak Banjara
*
*  Revision Logs    :  	V_1.0 - Created
*
**/
trigger Trigger_ManageContactSequence on Contact (after insert, after update, after delete, after Undelete)
    {
        if(Utilities.BypassAllTriggers)
            return;
        
        if(Trigger.isafter)
        {
            if(Trigger.isUpdate)
            {
                if(Trigger.new != Null && Trigger.new.size() > 0)
                {
                    ManageContactSequenceTriggerHelper.arrangeContacts(Trigger.new, Trigger.oldMap);
                }
            }
            
            if(Trigger.isInsert || Trigger.IsUndelete)
            {
                if(Trigger.new != Null && Trigger.new.size() > 0)
                {
                    ManageContactSequenceTriggerHelper.arrangeNewInsertedContacts(Trigger.new, Trigger.oldMap);
                }
            }
            
            if(Trigger.isDelete)
            {
                if(Trigger.old != Null && Trigger.old.size() > 0)
                {
                    ManageContactSequenceTriggerHelper.arrangeContactsAfterDelete(Trigger.old, Trigger.oldMap);
                }
            }
        }
        
    }