/**
*
*  Purpose          :	Queueable Job Class for integration with Open Source Heroku App.
*
*  Created Date     :  	11/08/2022
*
*  Created By       :  	Abhinav Sharma
*
*  Revision Logs    :  	V_1.0 - Created
*
**/
public without sharing class Queueable_UpdateUserWithHerokuAppDetails implements Queueable, Database.AllowsCallouts
{
    private Set<Id> setOfSchoolsIds;
    
    public Queueable_UpdateUserWithHerokuAppDetails(Set<Id> setOfSchoolsIds) 
    {
        this.setOfSchoolsIds = setOfSchoolsIds;
    }
    
    public void execute(QueueableContext context)
    {
        if(this.setOfSchoolsIds != null && this.setOfSchoolsIds.size() > 0) 
        {
            HerokuAppIntegrationManager.makeHerokuAppCalloutAndUpdateUsers(setOfSchoolsIds);
        }    
    }
}