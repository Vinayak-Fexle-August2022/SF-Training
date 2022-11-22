/**
*
*  Purpose          :   Class to have with/without sharing based concepts demonstration.
*
*  Created Date     :   10/06/2022
*
*  Created By       :   Abhinav Sharma
*
*  Revision Logs    :   V_1.0 - Created
*
**/
public with sharing class PlayingWithSharingConcepts 
{
    private School__c school;
    public PlayingWithSharingConcepts(ApexPages.StandardController stdController) 
    {
        this.school = (School__c)stdController.getRecord();
        
        List<School__c> schools = [SELECT ID, Name, Location__c 
                   FROM School__c];
        System.debug('@@@@@ schools ' + schools);
    }
    
    public PlayingWithSharingConcepts() 
    {
    	List<School__c> schools = [SELECT ID, Name, Location__c 
                   FROM School__c];
        System.debug('@@@@@ schools ' + schools.size());    
    }
}