/**
*
*  Purpose          :	Apex Class to have the utilities methods.
*
*  Created Date     :  	07/19/2022
*
*  Created By       :  	Abhinav Sharma
*
*  Revision Logs    :  	V_1.0 - Created
*
**/
public without sharing class Utilities 
{
    public static Boolean BypassAllTriggers = false;
    
    public static Schema.SObjectType getObjectTypeOnBasisOfObjectName(String objName) 
    {
        if (objName == null || String.isEmpty(objName)) 
        {
            return null;
        }
        else 
        {
            if (
                Type.forName(objName) != null &&
                ((SObject) Type.forName(objName).newInstance()) != null
            ) 
            {
                return ((SObject) Type.forName(objName).newInstance()).getSObjectType();
            }
            return null;
        }
    }
    
    public static String getErrorLogMessageForRecords(List<sObject> listOfSobjectRecords) 
    {
        String log = '';
        if(listOfSobjectRecords != null && listOfSobjectRecords.size() > 0) 
        {
            List<Database.SaveResult> results = Database.update(listOfSobjectRecords, false);
            for (Database.SaveResult result : results) 
            {
                if (!result.isSuccess())
                {
                    for (Database.Error err : result.getErrors())
                    {
                        log += 'Error: '+ err.getStatusCode() + ' ' + err.getMessage();
                    }
                }
            } 
        }
        return log;
    }
}