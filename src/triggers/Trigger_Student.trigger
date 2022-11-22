/**
*
*  Purpose          :	Trigger on Student object.
*
*  Created Date     :  	09/30/2022
*
*  Created By       :  	Abhinav Sharma
*
*  Revision Logs    :  	V_1.0 - Created
*
**/
trigger Trigger_Student on Student__c (after insert, after delete, after update) 
{
    try
    {
        if(Utilities.BypassAllTriggers) 
            return;
        
        if(Utilities.ByPassAllTriggers /*|| Utilities.areTriggersOnThisObjectBypassed(Constants.OBJECT_NAME_STUDENT)*/)
            return;
        
        if(Trigger.isAfter) 
        {
            if(Trigger.isInsert || Trigger.isDelete || Trigger.isUpdate)
            {
            	StudentTriggerHelper.updateNoOfStudentsDetails(trigger.new, trigger.oldMap);
            }
        }
    }
    catch(Exception e)
    {
        integer i=0;
        if(Trigger.isDelete)
            Trigger.Old[i].addError(e.getMessage());
        else
            Trigger.New[i].addError(e.getMessage());
    } 
}