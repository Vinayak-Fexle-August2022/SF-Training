/**
*  Assignment       :   Assignment-4th (ApexSession#4)
*
*  Purpose          :   Class to demonstrate two methods which will update number of Classes and number of student
*						fields on school object.
*
*  Created Date     :   09-Sep-2022
*
*  Created By       :   Vinayak Banjara
*
*  Revision Logs    :   V_1.1 - Created
*
**/


public without sharing class CountsManager
{
    public static void updateNoOfStudentsDetails(String schoolName)
    {
        //Condition To Handle Null Or Empty School Name.
        if(schoolName != Null && schoolName.trim().length() > 0)
        {
            
        
            List<School__c> schoolToBeUpdated = [SELECT Id, Name
                                                 FROM School__c 
                                                 where School__c.Name = :schoolName.trim() LIMIT 1];
            
           //Conndition To Handle If There Is No School Present For Given School Name.
            if(!schoolToBeUpdated.isEmpty())
            {
                AggregateResult studentCount = [SELECT Count(Student__c.Id)
                                                FROM Student__c 
                                                WHERE School__r.Id = :schoolToBeUpdated[0].Id];
                
                double countOfStudents = (double) studentCount.get('expr0');
                
                //Condition To Handle If The Given School Has No Students.
                if(countOfStudents > 0)
                {
                     schoolToBeUpdated[0].No_Of_Students__c = countOfStudents;
                     Update schoolToBeUpdated[0];
                     System.debug('Succsesfully Updated Number_Of_Students On School Object...');
                }
                else
                {
                    schoolToBeUpdated[0].No_Of_Students__c = 0;
                    Update schoolToBeUpdated[0];
                }
            }
            else
            {
                System.debug('Unable to find out a Schoool for given Name...!');
            }
        }
        else
        {
            System.debug('Invalid School Name, Please Provide Valid Name...!');
        }
    }    
    
    public static void updateNoOfClassesDetails(String schoolId)
    {
         //Condition To Handle Null Or Empty School Id.
        if(schoolId != Null && schoolId.trim().length() > 0)
        {
            
        
            List<School__c> schoolToBeUpdated = [SELECT Id, Name
                                                 FROM School__c 
                                                 where School__c.Id = :schoolId.trim() LIMIT 1];
            
           //Conndition To Handle If There Is No School Present For Given School Id.
            if(!schoolToBeUpdated.isEmpty())
            {
                
                AggregateResult studentCount = [SELECT Count(Class__c.Id)
                                                FROM Class__c 
                                                WHERE School__r.Id = :schoolToBeUpdated[0].Id];
                
                double countOfClasses = (double) studentCount.get('expr0');
                
                //Condition To Handle If The Given School Has No Students.
                if(countOfClasses > 0)
                {
                     schoolToBeUpdated[0].No_Of_classes__c = countOfClasses;
                     Update schoolToBeUpdated[0];
                     System.debug('Succsesfully Updated Number_Of_Students On School Object...');
                }
                else
                {
                    schoolToBeUpdated[0].No_Of_classes__c = 0;
                    Update schoolToBeUpdated[0];
                }
            }
            else
            {
                System.debug('Unable to find out a Schoool for given Id...!');
            }
        }
        else
        {
            System.debug('Invalid School Id, Please Provide Valid School Id...!');
        }
    }    
}



/**
*   OutPut: For Method updateNoOfStudentsDetails  => Succsesfully Updated Number_Of_Students On School Object...
*			For Method updateNoOfClassesDetails   => Succsesfully Updated Number_Of_Classes On School Object...'
*												 
**/