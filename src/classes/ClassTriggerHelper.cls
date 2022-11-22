/**
*
*  Purpose          :	Helper Class for Trigger on Class object.
*
*  Created Date     :  	09/30/2022
*
*  Created By       :  	Abhinav Sharma
*
*  Revision Logs    :  	V_1.0 - Created
*
**/
public without sharing class ClassTriggerHelper 
{
    public static void updateStatisticsOnSchools(List<Class__c> classes, Map<Id, Class__c> mapOfOldClasses) 
    {
        Map<Id, Integer> mapOfSchoolIdWithNoOfClassesCount = new Map<Id, Integer>();
        Map<Id, Integer> mapOfSchoolIdWithNoOfStudentsCount = new Map<Id, Integer>();
        
        //No of Classes - Calculation Logic
        //Start from here
        for(Class__c cls : classes != null ? classes : mapOfOldClasses.values()) 
        {
            if(cls.School__c != null) 
            {
                mapOfSchoolIdWithNoOfClassesCount.put(cls.School__c, 0);
                
                //Only execute in case of delete operation
                if(classes == null) 
                {
                	mapOfSchoolIdWithNoOfStudentsCount.put(cls.School__c, 0);    
                }
            }
        }
        if(mapOfSchoolIdWithNoOfClassesCount.values().size() > 0) 
        {
            for(Class__c cls : [SELECT ID, School__c
                                FROM Class__c
                                WHERE School__c != null
                                AND School__c IN : mapOfSchoolIdWithNoOfClassesCount.keySet()
                               ]) 
            {
                if(!mapOfSchoolIdWithNoOfClassesCount.containsKey(cls.School__c)) 
                {
                    mapOfSchoolIdWithNoOfClassesCount.put(cls.School__c, 1);
                }
                else 
                {
                    mapOfSchoolIdWithNoOfClassesCount.put(cls.School__c, (mapOfSchoolIdWithNoOfClassesCount.get(cls.School__c) + 1));                        
                }
            }
        }
        //No of Classes - Calculation Logic
        //Ends here
        
        //No of Students - Calculation Logic
        //Start from here
        
        //Only execute in case of delete operation
        if(classes == null) 
        {
            if(mapOfSchoolIdWithNoOfStudentsCount.values().size() > 0) 
            {
                for(Student__c student : [SELECT ID, Class__r.School__c
                                          FROM Student__c
                                          WHERE Class__c != null
                                          AND Class__r.School__c != null
                                          AND Class__r.School__c IN : mapOfSchoolIdWithNoOfStudentsCount.keySet()
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
            }     
        }
           
        List<School__c> listOfSchoolsToBeUpated = new List<School__c>();
        for(Id schId : mapOfSchoolIdWithNoOfClassesCount.keyset()) 
        {
            School__c sc = new School__c(Id = schId);
            
            if(mapOfSchoolIdWithNoOfClassesCount.get(schId) != null) 
            {
                sc.No_of_Classes__c = mapOfSchoolIdWithNoOfClassesCount.get(schId);
            }
            else 
            {
            	sc.No_of_Classes__c = null;    
            }
            
            if(mapOfSchoolIdWithNoOfStudentsCount.get(schId) != null) 
            {
                sc.No_of_Students__c = mapOfSchoolIdWithNoOfStudentsCount.get(schId);
            }
            else
            {
            	sc.No_of_Students__c = null;    
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