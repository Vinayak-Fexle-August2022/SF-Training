/**
*  Assignment       :   Assignment-4th (ApexSession#4)
*
*  Purpose          :   Class to demonstrate two methods which will update number of Classes and number of student
*						fields on school object.
*
*  Created Date     :   07/09/2022
*
*  Created By       :   Vinayak Banjara
*
*  Revision Logs    :   V_1.0 - Created
*
**/


public without sharing class CountsManager
{
    public static void updateNoOfStudentsDetails(String schoolName)
    {
        List<School__c> schoolToBeUpdated = [SELECT Id, Name
                                       FROM School__c 
                                       where School__c.Name = :schoolName];
       
        if(!schoolToBeUpdated.isEmpty())
        {
            AggregateResult studentCount = [SELECT Count(Student__c.Id)
                				   FROM Student__c 
                				   WHERE School__r.Id = :schoolToBeUpdated[0].Id];
           
            double countOfStudent = (double) studentCount.get('expr0');
            schoolToBeUpdated[0].No_Of_Students__c = countOfStudent;
            Update schoolToBeUpdated[0];
            System.debug(schoolToBeUpdated[0].Id);
        }
        Else
        {
            System.debug('Unable to find out a Schoool for given Name...!');
            
        }
    }
            
    
    public static void updateNoOfClassesDetails(String schoolId)
    {
        List<School__c> schoolToBeUpdated = [SELECT Id, Name
                                       FROM School__c 
                                       where School__c.Id = :(Id)schoolId];
       
        if(!schoolToBeUpdated.isEmpty())
        {
            AggregateResult classCount = [SELECT Count(Class__c.Id)
                				   FROM Class__c 
                				   WHERE School__r.Id = :schoolToBeUpdated[0].Id];
           
            double countOfClass = (double)classCount.get('expr0');
            schoolToBeUpdated[0].No_of_Classes__c = countOfClass;
            Update schoolToBeUpdated[0];
            
        }
        Else
        {
            System.debug('Unable to find out a Schoool for given Name...!');
        }
    }
}



/**
*   OutPut: For Method updateNoOfStudentsDetails  => Succsesfully Updated Number_Of_Students On School Object...
*			For Method updateNoOfClassesDetails   => Succsesfully Updated Number_Of_Classes On School Object...'
*												 
**/