/**
*
*  Purpose          :	Helper Class for Trigger on Student object.
*
*  Created Date     :  	09/30/2022
*
*  Created By       :  	Abhinav Sharma
*
*  Revision Logs    :  	V_1.0 - Created
*
**/
public without sharing class StudentTriggerHelper 
{
    public static void updateNoOfStudentsDetails(List<Student__c> students, Map<Id, Student__c> mapOfOldStudents) 
    {
        /*@@@@@ students (Student__c:{Id=a025g00000BCmUuAAL, OwnerId=0055g00000DncX6AAJ, IsDeleted=false, Name=test std1, RecordTypeId=0125g000000NAIDAA4, 
         * CreatedDate=2022-10-19 15:50:47, CreatedById=0055g00000DncX6AAJ, LastModifiedDate=2022-10-19 23:44:45, LastModifiedById=0055g00000DncX6AAJ, 
         * SystemModstamp=2022-10-19 23:44:45, LastActivityDate=null, LastViewedDate=null, LastReferencedDate=null, Date_of_Birth__c=1992-10-19 00:00:00, 
         * Father_Name__c=test, Class__c=a015g00000kwDCOAA2, Age__c=30, Father_Annual_Income__c=null, 
         * School__c=_HL_ENCODED_/a005g0000335Rvy_HL_India International School - Jaipur_HL__blank_HL_})*/
        
        /*@@@@@ mapOfOldStudents {a025g00000BCmUuAAL=Student__c:{Id=a025g00000BCmUuAAL, OwnerId=0055g00000DncX6AAJ, IsDeleted=false, Name=test std1, 
         * RecordTypeId=0125g000000NAIDAA4, CreatedDate=2022-10-19 15:50:47, CreatedById=0055g00000DncX6AAJ, LastModifiedDate=2022-10-19 23:41:46, 
         * LastModifiedById=0055g00000DncX6AAJ, SystemModstamp=2022-10-19 23:41:46, LastActivityDate=null, LastViewedDate=null, LastReferencedDate=null, 
         * Date_of_Birth__c=1992-10-19 00:00:00, Father_Name__c=test, Class__c=a015g00000kwG5lAAE, Age__c=30, Father_Annual_Income__c=null, 
         * School__c=_HL_ENCODED_/a005g000036puN8_HL_India International School - Delhi_HL__blank_HL_}}*/
        
        Set<Id> setOfParentClasses = new Set<Id>();
        for(Student__c std : students != null ? students : mapOfOldStudents.values()) 
        {
            //Execute following login in case of update event
            if(students != null && mapOfOldStudents != null && mapOfOldStudents.values().size() > 0) 
            {
                //check for class__c field value changes
                if(mapOfOldStudents.get(std.Id) != null && std.Class__c != mapOfOldStudents.get(std.Id).Class__c) 
                {
                    if(std.Class__c != null) 
                    {
                        setOfParentClasses.add(std.Class__c);
                    }
                    
                    if(mapOfOldStudents.get(std.Id) != null) 
                    {
                        if(mapOfOldStudents.get(std.Id).Class__c != null) 
                        {
                            setOfParentClasses.add(mapOfOldStudents.get(std.Id).Class__c);    
                        }
                    }        
                }
            }
            //Otherwise
            else 
            {
                if(std.Class__c != null) 
            	{
                	setOfParentClasses.add(std.Class__c);
                }    
            }
        }
        if(setOfParentClasses.size() > 0) 
        {
            Map<Id, Integer> mapOfSchoolIdWithNoOfStudentsCount = new Map<Id, Integer>();
            for(Class__c cls : [SELECT ID, School__c 
                                FROM Class__c
                                WHERE ID IN : setOfParentClasses
                                AND School__c != null
                               ]) 
            {
                mapOfSchoolIdWithNoOfStudentsCount.put(cls.School__c, 0);
            }
            if(mapOfSchoolIdWithNoOfStudentsCount.values().size() > 0) 
            {
                for(Student__c student : [SELECT ID, Class__r.School__c
                                          FROM Student__c
                                          WHERE Class__c != null
                                          AND Class__r.School__c != null
                                          AND Class__c IN : setOfParentClasses
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
                List<School__c> listOfSchoolsToBeUpated = new List<School__c>();
                for(Id schId : mapOfSchoolIdWithNoOfStudentsCount.keyset()) 
                {
                    School__c sc = new School__c(Id = schId);
                    sc.No_of_Students__c = mapOfSchoolIdWithNoOfStudentsCount.get(schId);
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
}