/**
*
*  Purpose          :   Class to have the logic to update the key counts fields on a school record.
*
*  Created Date     :   09/06/2022
*
*  Created By       :   Abhinav Sharma
*
*  Revision Logs    :   V_1.0 - Created
*
**/
public without sharing class CountsManager 
{
    //"updateNoOfStudentsDetails" method based logic : - it will fetch school related details on the basis of given school name. 
    //if unable to find a school record then it will log a System.debug message that "Unable to find out a school for given name" 
    //otherwise for the retrieved school, it will have a further logic to count no of students associated with that school 
    //and then to update the "No of Students" field on school with that value.
    public static void updateNoOfStudentsDetails(String schoolName) 
    {
        if(String.isNotBlank(schoolName)) 
        {
            Map<Id, School__c> mapOfSchools = new Map<Id, School__c>();
            for(School__c sch : [SELECT ID, No_of_Students__c 
                                 FROM School__c
                                 WHERE Name =: schoolName.trim()
                                ]) 
            {
                mapOfSchools.put(sch.Id, sch);
            }
            if(mapOfSchools.values() != null && mapOfSchools.values().size() > 0)
            {
                CountsManager.doCalculationForNoOfStudents(mapOfSchools);    
            }
            else 
            {
                System.debug(System.Label.ERROR_MSG_UNABLE_TO_FIND_SCHOOL_BY_NAME);        
            }   
        }
        else 
        {
            System.debug(System.Label.ERROR_MSG_SCHOOL_NAME_DETAILS_MISSING);   
        }
    }
    
    public static void doCalculationForNoOfStudents(Map<Id, School__c> mapOfSchools) 
    {
        if(mapOfSchools.values() != null && mapOfSchools.values().size() > 0) 
        {
            Map<Id, Integer> mapOfSchoolIdWithNoOfStudentsCount = new Map<Id, Integer>();
            for(Id schoolId : mapOfSchools.keySet()) 
            {
                mapOfSchoolIdWithNoOfStudentsCount.put(schoolId, 0);    
            }
            
            for(Student__c student : [SELECT ID, Class__r.School__c
                                      FROM Student__c
                                      WHERE Class__c != null
                                      AND Class__r.School__c != null
                                      AND Class__r.School__c IN : mapOfSchools.keySet()
                                     ]) 
            {
                if(!mapOfSchoolIdWithNoOfStudentsCount.containsKey(student.Class__r.School__c)) 
                {
                    mapOfSchoolIdWithNoOfStudentsCount.put(student.Class__r.School__c, 1);
                }
                else 
                {
                    mapOfSchoolIdWithNoOfStudentsCount.put(student.Class__r.School__c, 
                                                           (mapOfSchoolIdWithNoOfStudentsCount.get(student.Class__r.School__c) + 1));                        
                }
            }
            
            if(mapOfSchoolIdWithNoOfStudentsCount.values() != null && mapOfSchoolIdWithNoOfStudentsCount.values().size() > 0) 
            {
                List<School__c> listOfSchoolsToBeUpated = new List<School__c>();
                for(School__c sch : mapOfSchools.values()) 
                {
                    School__c sc = mapOfSchools.get(sch.Id);
                    
                    if(mapOfSchoolIdWithNoOfStudentsCount.containsKey(sch.Id)) 
                    {
                        sc.No_of_Students__c = mapOfSchoolIdWithNoOfStudentsCount.get(sch.Id);
                    }
                    else
                    {
                        sc.No_of_Students__c = 0;
                    }
                    listOfSchoolsToBeUpated.add(sc);
                }
                if(listOfSchoolsToBeUpated.size() > 0) 
                {
                    Utilities.BypassAllTriggers = true;
                    update listOfSchoolsToBeUpated;
                    Utilities.BypassAllTriggers = false;
                }
            }
        }
    }
    
    //"updateNoOfClassesDetails" method based logic : - it will fetch school related details on the basis of given school id. 
    //if unable to find a school record then it will log a System.debug message that "Unable to find out a school for given record ID" 
    //otherwise for the retrieved school, it will have a further logic to count no of classes associated with that school and 
    //then to update the "No of Classes" field on school with that value.
    public static void updateNoOfClassesDetails(Id schoolId) 
    {
        if(schoolId != null) 
        {
            CountsManager.updateNoOfClassesDetails(new Set<Id> {schoolId});
        }
        else 
        {
            System.debug(System.Label.ERROR_MSG_SCHOOL_ID_DETAILS_MISSING);    
        }        
    }
    
    public static void updateNoOfClassesDetails(Set<Id> schoolIds) 
    {
        if(schoolIds.size() > 0) 
        {
            List<School__c> schools = [SELECT Id, Name, 
                                       (SELECT ID FROM Class__r) 
                                       FROM School__c
                                       WHERE Id IN : schoolIds
                                      ];
            
            if(schools.size() > 0) 
            {
                for (School__c sc : schools) 
                {
                    sc.No_of_Classes__c = sc.Class__r.size();
                }
                Utilities.BypassAllTriggers = true;
                update schools;
                Utilities.BypassAllTriggers = false;
            }
            else
            {
                System.debug(System.Label.ERROR_MSG_UNABLE_TO_FIND_SCHOOL_BY_ID);        
            }    
        }
    }
    
    //"updateNoOfClassesDetails" method based logic : - it will fetch school related details on the basis of given school id. 
    //if unable to find a school record then it will log a System.debug message that "Unable to find out a school for given record ID" 
    //otherwise for the retrieved school, it will have a further logic to count no of classes associated with that school and 
    //then to update the "No of Classes" field on school with that value.
    public static void updateNoOfClassesDetails2(Id schoolId) 
    {
        if(schoolId != null) 
        {
            List<School__c> schools = [SELECT Id
                                       FROM School__c
                                       WHERE Id =: schoolId
                                      ];
            if(schools.size() > 0) 
            {
                CountsManager.updateNoOfClassesDetails2(new Set<Id>{schoolId});    
            }
            else 
            {
                System.debug(System.Label.ERROR_MSG_UNABLE_TO_FIND_SCHOOL_BY_ID);        
            }
        }
        else 
        {
            System.debug(System.Label.ERROR_MSG_SCHOOL_ID_DETAILS_MISSING);    
        }        
    }
    
    public static void updateNoOfClassesDetails2(Set<Id> schoolIds) 
    {
        if(schoolIds.size() > 0) 
        {
            Map<Id, Integer> mapOfSchoolIdWithClassesCount = new Map<Id, Integer>();
            for (AggregateResult aggRes : [SELECT COUNT(ID) numOfClasses, School__c schoolId
                                           FROM Class__c
                                           WHERE School__c IN : schoolIds
                                           GROUP BY School__c
                                          ]
                ) 
            {
                Id schoolRecordId = (Id) aggRes.get(Constants.SCHOOL_ID);
                Integer numberOfAssociatedClasses = (Integer) aggRes.get(Constants.NUM_OF_CLASSES);
                mapOfSchoolIdWithClassesCount.put(schoolRecordId, numberOfAssociatedClasses);
            }
            if(mapOfSchoolIdWithClassesCount.values() != null && mapOfSchoolIdWithClassesCount.values().size() > 0) 
            {
                List<School__c> listOfSchoolsToBeUpated = new List<School__c>();
                for(Id scId : mapOfSchoolIdWithClassesCount.keySet()) 
                {
                    School__c scRec = new School__c();
                    scRec.Id = scId;
                    scRec.No_of_Classes__c = mapOfSchoolIdWithClassesCount.get(scId);
                    listOfSchoolsToBeUpated.add(scRec);
                }
                if(listOfSchoolsToBeUpated.size() > 0) 
                {
                    Utilities.BypassAllTriggers = true;
                    update listOfSchoolsToBeUpated;
                    Utilities.BypassAllTriggers = false;
                }
            }
            else 
            {
                Integer i=0;
                List<Id> listOfRecordsIds = new List<Id>();
                listOfRecordsIds.addAll(schoolIds);
                
                School__c scRecord = new School__c();
                scRecord.Id = listOfRecordsIds[i];
                scRecord.No_of_Classes__c = 0;
                
                Utilities.BypassAllTriggers = true;
                update scRecord;
                Utilities.BypassAllTriggers = false;
            }    
        }
    }
}