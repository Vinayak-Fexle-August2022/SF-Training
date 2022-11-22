/*
Purpose         :   Test Class for "DynamicWaysToDealsWithCollections" apex class
Created By      :   Abhinav Sharma
Created Date    :   10/17/2022
Current Version :   v1.0
Revision Log    :   V_1.0 Created - Abhinav Sharma - 10/17/2022 - 88%
*/
@isTest(seeAllData=false)
private without sharing class DynamicWaysToDealWithCollection_Test 
{
    @testSetup static void setup() 
    {
    	List<Student__c> students = TestDataFactory.createListOfStudentsTestDataWithTriggerEnabled();    
    }
    
    @isTest(seeAllData=false)
    private static void testUseCases() 
    {
    	List<School__c> schools = [SELECT ID, No_of_Classes__c, No_of_Students__c 
                                   FROM School__c];
        System.assertEquals(5, schools.size());
        
        DynamicWaysToDealWithCollections dyn = new DynamicWaysToDealWithCollections();
        System.assert(dyn != null);
    }
}