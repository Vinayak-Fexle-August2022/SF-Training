/**
*
*  Purpose          :   Class to demonstrate the dynamic ways to deal with or populate collections in apex.
*
*  Created Date     :   09/01/2022
*
*  Created By       :   Abhinav Sharma
*
*  Revision Logs    :   V_1.0 - Created
*
**/
public without sharing class DynamicWaysToDealWithCollections 
{
    //Map to have Schools Name with correspodning Classes Names and correspodning students related details with it
    Map<String, Map<String, List<Student__c>>> mapOfSchoolNameWithClassNameAndRelatedStudentsDetails;
    
    //Constructor
    public DynamicWaysToDealWithCollections() 
    {
        mapOfSchoolNameWithClassNameAndRelatedStudentsDetails = new Map<String, Map<String, List<Student__c>>>();
        
        //Loop over students to retrieve all the related and needed details
        for(Student__c student : [SELECT ID, Name, DOB__c, Class__c, Class__r.Name, Class__r.School__c, 
                                  Class__r.School__r.Name 
                                  FROM Student__c
                                  WHERE Class__c != null 
                                  	AND Class__r.School__c != null
                                 ]) 
        {
            if(mapOfSchoolNameWithClassNameAndRelatedStudentsDetails.containsKey(student.Class__r.School__r.Name))
            {
                if(mapOfSchoolNameWithClassNameAndRelatedStudentsDetails.get(student.Class__r.School__r.Name)
                   															.containsKey(student.Class__r.Name))
                {
                    mapOfSchoolNameWithClassNameAndRelatedStudentsDetails.get(student.Class__r.School__r.Name)
                        													.get(student.Class__r.Name)
                        														.add(student);
                }
                else
                {
                    mapOfSchoolNameWithClassNameAndRelatedStudentsDetails.get(student.Class__r.School__r.Name)
                        														.put(student.Class__r.Name, new List<Student__c>{ student });
                }
            }
            else
            {
                Map<String, List<Student__c>> mapOfClassNameWithStudents = new Map<String, List<Student__c>>();
                if (mapOfClassNameWithStudents.get(student.Class__r.Name) == null)
                {
                    mapOfClassNameWithStudents.put(student.Class__r.Name, new List <Student__c> ());
                }
                mapOfClassNameWithStudents.get(student.Class__r.Name).add(student);
                
                mapOfSchoolNameWithClassNameAndRelatedStudentsDetails.put(student.Class__r.School__r.Name, mapOfClassNameWithStudents);
            }
        }
        /*@@@@@ mapOfSchoolNameWithClassNameAndRelatedStudentsDetails 
		{
			India International School = 
			{
				1st - CBSE =
				(
					Student__c:
					{
						Id=a025g0000097ykkAAA, Name=Narendra Modi, Date_of_Birth__c=1991-08-10 00:00:00, Class__c=a015g00000eHQzoAAG, 
						RecordTypeId=0125g000000NAIDAA4
					}
				), 
				
				1st - RBSE =
				(
					Student__c:
					{
						Id=a025g0000097yklAAA, Name=Yogi Adityanath, Date_of_Birth__c=1994-08-31 00:00:00, Class__c=a015g00000eHQzyAAG, 
						RecordTypeId=0125g000000NAIIAA4
					}
				)
			}
		}
		*/
    }
}