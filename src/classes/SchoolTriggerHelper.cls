/**
*
*  Purpose          :    Helper Class for Trigger on School Object object.
*
*  Created Date     :      09/30/2022
*
*  Created By       :      Abhinav Sharma
*
*   Updated By		:	   VM Banjara
*
*  Revision Logs    :      V_1.0 - Created
*
**/
public without sharing class SchoolTriggerHelper
{
    public static void performValidationLogics(List<School__c> schools, Map<Id, School__c> mapOfOldSchools) 
    {
        for(School__c sc : schools) 
        {
            if(String.isBlank(sc.About_US__c)) 
            {
            	sc.addError(System.Label.ERROR_MSG_ABOUT_US_DETAILS_MISSING);  
                //sc.About_US__c.addError(System.Label.ERROR_MSG_ABOUT_US_DETAILS_MISSING);
            }    
        }    
    } 
    
    public static void doApexSharingCalculations(List<School__c> schools, Map<Id, School__c> mapOfOldSchools) 
    {
        Set<Id> setOfEligibleSchoolsForSharingAddition = new Set<Id>();
        Set<Id> setOfEligibleSchoolsForSharingDeletion = new Set<Id>();
        Boolean isAnyRelaventChangesHappens = false;
        
        for(School__c sch : schools) 
        {
            if(mapOfOldSchools != null) 
            {
                //System.isBatch(): if the execution is done in the context of batch then it will return True.
                if(System.isBatch() || (sch.No_of_Teacher__c != mapOfOldSchools.get(sch.Id).No_of_Teacher__c)) 
                {
                    if(sch.No_of_Teacher__c  != null) 
                    {
                        if(sch.No_of_Teacher__c > Integer.valueOf(System.Label.NO_OF_TEACHERS_THRESHOLD_FOR_SHARING_RECALCULATION))
                        {
                            setOfEligibleSchoolsForSharingAddition.add(sch.Id);
                        }
                        else 
                        {
                            setOfEligibleSchoolsForSharingDeletion.add(sch.Id);
                        }        
                    }
                    else 
                    {
                        setOfEligibleSchoolsForSharingDeletion.add(sch.Id);
                    }
                    isAnyRelaventChangesHappens = true;
                }    
            }
        }
        
        List<User> integrationUserDetails = new List<User>();
        
        //Only execute the logic if relavent field(s) values got changes
        if(isAnyRelaventChangesHappens) 
        {
            if(setOfEligibleSchoolsForSharingAddition.size() > 0 || setOfEligibleSchoolsForSharingDeletion.size() > 0) 
            {
                integrationUserDetails = [SELECT Id FROM User 
                                          WHERE Id =: System.Label.INTEGRATION_USER_RECORD_ID
                                          AND IsActive = true
                                         ];    
            }
            
            if(integrationUserDetails.size() > 0) 
            {
                List<School__Share> listOfManagedSharingRecordsToBeInserted = new List<School__Share>();
                if(setOfEligibleSchoolsForSharingAddition.size() > 0) 
                {
                    //Loop over school records and create sharing record for the Integration User
                    for(Id schId : setOfEligibleSchoolsForSharingAddition) 
                    {
                        // Create new sharing object for the custom object Job.
                        School__Share schoolShare  = new School__Share();
                        schoolShare.ParentId = schId;
                        schoolShare.UserOrGroupId = integrationUserDetails[0].Id;
                        schoolShare.AccessLevel = Constants.SHARING_ACCESS_TYPE_READ;
                        schoolShare.RowCause = Schema.School__Share.RowCause.Apex_Sharing__c;
                        listOfManagedSharingRecordsToBeInserted.add(schoolShare);
                    }
                    if(listOfManagedSharingRecordsToBeInserted.size() > 0) 
                    {
                        Utilities.BypassAllTriggers = true;
                        insert listOfManagedSharingRecordsToBeInserted;   
                        Utilities.BypassAllTriggers = false;
                        
                        //Make a integration callout and do further processing 
                        //if sharing records will be created successfully
                        
                        //Via future method
                        //HerokuAppIntegrationManager.makeCalloutToHerokuAndUpdateUsers(setOfEligibleSchoolsForSharingAddition);
                    
                        //enqueue the Queueable job for processing
                    	Queueable_UpdateUserWithHerokuAppDetails queueableJob = new Queueable_UpdateUserWithHerokuAppDetails(setOfEligibleSchoolsForSharingAddition);
                        ID jobID = System.enqueueJob(queueableJob);
                    }
                }  
                if(setOfEligibleSchoolsForSharingDeletion.size() > 0) 
                {
                    List<School__Share> listOfManagedSharingRecordsToBeDeleted = [SELECT Id, ParentId, RowCause, UserOrGroupId 
                                                                                  FROM School__share 
                                                                                  WHERE ParentId IN: setOfEligibleSchoolsForSharingDeletion 
                                                                                  AND RowCause =: Constants.SHARING_REASON_APEX_SHARING];
                    
                    if(listOfManagedSharingRecordsToBeDeleted.size() > 0)
                    {
                        Utilities.BypassAllTriggers = true;
                        delete listOfManagedSharingRecordsToBeDeleted;
                        Utilities.BypassAllTriggers = false;
                    }    
                }
            } 
            else 
            {
                schools[0].addError(System.Label.ERROR_INTEGRATION_USER_IS_DEACTIVATED);            
            }         
        } 
    }
    
    public static void updateNoOfStudentsDetailsInBeforeCase(List<School__c> schools, Map<Id, School__c> mapOfOldSchools) 
    {
        //Map to hold the school record Id as a key and then upto recalcualted no of students counts as value
        Map<Id, Integer> mapOfSchooldIdWithNoOfStudentsCounts = new Map<Id, Integer>();
        
        for(School__c sch : schools)
        {
            mapOfSchooldIdWithNoOfStudentsCounts.put(sch.Id, 0);
        }
        if(mapOfSchooldIdWithNoOfStudentsCounts.values().size() > 0) 
        {
            for(Student__c student : [SELECT ID, Class__r.School__c
                                      FROM Student__c
                                      WHERE Class__c != null
                                      AND Class__r.School__c != null
                                      AND Class__r.School__c IN : mapOfSchooldIdWithNoOfStudentsCounts.keySet()
                                     ]) 
            {
                if(!mapOfSchooldIdWithNoOfStudentsCounts.containsKey(student.Class__r.School__c)) 
                {
                    mapOfSchooldIdWithNoOfStudentsCounts.put(student.Class__r.School__c, 1);
                }
                else 
                {
                    mapOfSchooldIdWithNoOfStudentsCounts.put(student.Class__r.School__c, 
                                                             (mapOfSchooldIdWithNoOfStudentsCounts.get(student.Class__r.School__c) + 1));                        
                }
            }
            for(School__c sc : schools) 
            {
                if(mapOfSchooldIdWithNoOfStudentsCounts.get(sc.Id) != null) 
                {
                    sc.No_Of_Students__c = mapOfSchooldIdWithNoOfStudentsCounts.get(sc.Id);    
                }
            }
        }   
    }
    
    public static void updateNoOfClassesDetailsInBeforeCase(List<School__c> schools, Map<Id, School__c> mapOfOldSchools) 
    {
        //Map to hold the school record Id as a key and then upto recalcualted no of classes counts as value
        Map<Id, Integer> mapOfSchooldIdWithNoOfClassesCounts = new Map<Id, Integer>();
        
        for(School__c sch : schools)
        {
            mapOfSchooldIdWithNoOfClassesCounts.put(sch.Id, 0);
        }
        
        if(mapOfSchooldIdWithNoOfClassesCounts.values().size() > 0) 
        {
            for(Class__c cls : [SELECT Id, School__c 
                                FROM Class__c 
                                WHERE School__c != null
                                AND School__c IN : mapOfSchooldIdWithNoOfClassesCounts.keySet()])
            {
                if(!mapOfSchooldIdWithNoOfClassesCounts.containsKey(cls.School__c)) 
                {
                    mapOfSchooldIdWithNoOfClassesCounts.put(cls.School__c, 1);
                }
                else 
                {
                    mapOfSchooldIdWithNoOfClassesCounts.put(cls.School__c, 
                                                            (mapOfSchooldIdWithNoOfClassesCounts.get(cls.School__c) + 1));
                }
            }
            for(School__c sc : schools) 
            {
                if(mapOfSchooldIdWithNoOfClassesCounts.get(sc.Id) != null) 
                {
                    sc.No_Of_Classes__c = mapOfSchooldIdWithNoOfClassesCounts.get(sc.Id);    
                }
            }
        }
    }
    
    /*public static void updateNoOfStudentsDetails(List<School__c> schools, Map<Id, School__c> mapOfOldSchools) 
    {
        Set<Id> setOfEligibleSchools = new Set<Id>();
        for(School__c sc : schools)
        {
            //Only execute in the case of update
            //Only execute the following logic if someone changes the value of "No of Students" field value
            if(mapOfOldSchools != null && sc.No_of_Students__c != mapOfOldSchools.get(sc.Id).No_of_Students__c)
            {
                setOfEligibleSchools.add(sc.Id);    
            }
        }
        //Only execute the following logic if we will have the eligible school record(s)
        if(setOfEligibleSchools.size() > 0)
        {
            //An additional query because trigger.new is a read only collection in case of after event
            Map<Id, School__c> mapOfSchools = new Map<Id, School__c>();
            for(School__c sch : [SELECT ID, No_of_Students__c 
                                 FROM School__c
                                 WHERE ID IN : setOfEligibleSchools
                                ]) 
            {
                mapOfSchools.put(sch.Id, sch);
            }
            if(mapOfSchools.values().size() > 0) 
            {
                CountsManager.doCalculationForNoOfStudents(mapOfSchools);        
            }
        }
    }
    
    public static void updateNoOfClassesDetails(List<School__c> schools, Map<Id, School__c> mapOfOldSchools) 
    {
        Set<Id> setOfEligibleSchools = new Set<Id>();
        for(School__c sc : schools)
        {
            //Only execute in the case of update
            //Only execute the following logic if someone changes the value of "No of Classes" field value
            if(mapOfOldSchools != null && sc.No_of_Classes__c  != mapOfOldSchools.get(sc.Id).No_of_Classes__c )
            {
                setOfEligibleSchools.add(sc.Id);    
            }
        }     
        //Only execute the following logic if we will have the eligible school record(s)
        if(setOfEligibleSchools.size() > 0)
        {
            //An additional query because trigger.new is a read only collection in case of after event
            List<School__c> listOfSchoolsToBeUpdated = [SELECT ID, No_of_Classes__c,
                                                        (SELECT ID FROM Classes__r) 
                                                        FROM School__c
                                                        WHERE ID IN : setOfEligibleSchools
                                                       ];
            if(listOfSchoolsToBeUpdated.size() > 0) 
            {
                for(School__c sch : listOfSchoolsToBeUpdated) 
                {
                    sch.No_of_Classes__c = sch.Classes__r.size();
                }
                Utilities.BypassAllTriggers = true;
                update listOfSchoolsToBeUpdated;
                Utilities.BypassAllTriggers = false;
            }
        }
    }*/
}