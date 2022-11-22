/**
*
*  Purpose          :	Helper Class for integration with Open Source Heroku App.
*
*  Created Date     :  	11/08/2022
*
*  Created By       :  	Abhinav Sharma
*
*  Revision Logs    :  	V_1.0 - Created
*
**/
public without sharing class HerokuAppIntegrationManager 
{
    @future(callout=true)
    public static void makeCalloutToHerokuAndUpdateUsers(Set<Id> schoolsIds) 
    {
        if(schoolsIds != null && schoolsIds.size() > 0) 
        {
            HerokuAppIntegrationManager.makeHerokuAppCalloutAndUpdateUsers(schoolsIds);
        }	
    }
    
    public static void makeHerokuAppCalloutAndUpdateUsers(Set<Id> schoolsIds) 
    {
        if(schoolsIds != null && schoolsIds.size() > 0) 
        {
            Http http = new Http();
            
            HttpRequest request = new HttpRequest();
            request.setEndpoint(System.Label.ENDPOINT_HEROKU_APP);
            request.setMethod(Constants.HTTP_CALLOUT_OPERATION_GET);
            
            HttpResponse response = http.send(request);
            
            // If the request is successful, parse the JSON response.
            if(response.getStatusCode() == Constants.HTTP_CALLOUT_SUCCESS_CODE) 
            {
                List<User> integrationUserDetails = [SELECT Id, Heroku_App_Response__c FROM User 
                                                     WHERE Id =: System.Label.INTEGRATION_USER_RECORD_ID
                                                     AND IsActive = true
                                                    ];
                
                if(integrationUserDetails.size() > 0) 
                {
                    if(response.getBody() != null) 
                    {
                        String tempResponse = Constants.CHAR_BLANK;
                        for(ID schId : schoolsIds) 
                        {
                            tempResponse += schId + Constants.CHAR_BLANK_SPACE;
                        }
                        
                        // Deserialize the JSON string into collections of primitive data types.
                        Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
                        
                        // Cast the values in the 'animals' key as a list
                        List<Object> animals = (List<Object>) results.get('animals');
                        
                        for(Object animal: animals)
                        {
                            tempResponse += Constants.CHAR_BLANK_SPACE + Constants.CHAR_DASH + Constants.CHAR_BLANK_SPACE
                                + animal;
                        }
                        integrationUserDetails[0].Heroku_App_Response__c = tempResponse;    
                    }
                    
                    Utilities.BypassAllTriggers = true;
                    update integrationUserDetails;   
                    Utilities.BypassAllTriggers = false; 
                } 
            }
        }
    }
    
}