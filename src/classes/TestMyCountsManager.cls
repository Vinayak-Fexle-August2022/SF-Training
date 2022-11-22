/**
*  Assignment       :   Assignment-3
*
*  Purpose          :   Test class for CountsManager.
*
*  Created Date     :   -
*
*  Created By       :   VM Banjara
*
*  Revision Logs    :   V_1.0 - Created
*
**/

@isTest
public class TestMyCountsManager 
{
    //testSetup method for creating records for testing CountsManager class Methods
    @testSetup static void recordOfSchoolClassAndStudents()
    {
		School__c scl = new School__c();
    	scl.Name = 'West Point School';
    	scl.No_Of_Teacher__c = 20;
        scl.No_Of_Classes__c = 4;
    	scl.No_of_Students__c = 203;
    	insert scl;

		School__c scl1 = new School__c();
		scl1.Name = 'Siddhi Vinayaka';
        scl1.No_Of_Teacher__c = 10;
    	scl1.No_Of_Classes__c = 2;
    	scl1.No_of_Students__c = 87;
        insert scl1;
        
    	Class__c cls = new Class__c();
    	cls.Name = '1ST Class';
    	cls.Class_Teacher_Name__c = 'Akash Jha';
    	cls.No_of_Students__c = 43;
    	cls.School__c = scl.Id;
    	insert cls;
         
    	Student__c stu = new Student__c();
    	stu.Name = 'Abhi Sharma';
    	stu.Father_Name__c = 'Manoj Kumar Sharma';
        stu.School__c = scl.Id;
        stu.Class__c = cls.Id;
        stu.DOB__c = Date.newInstance(1999,05,23);
    	Test.stopTest();
    	insert stu;
        
        
    }
    
    //Test Method To Validate If We Pass School Name Which Have Some records.
    @istest private static void testUpdateNoOfStudentsDetails()
    {
		CountsManager.updateNoOfStudentsDetails('West Point School');
        
        List<School__c> studentCount = [SELECT Id, No_Of_Students__c from School__c 
                                        Where Name = :'West Point School'];
        
        System.assertEquals(1, studentCount[0].No_Of_Students__c);
        
    }
    
    //Test Method To Validate If We Pass School Id Which Have Some records In the Method Which is Updating No_Of_Classes.
    @istest private static void testUpdateNoOfClassesDetails()
    {
        List<School__c> sclId = [SELECT Id from School__c 
                                 Where Name = :'West Point School'];
        
        CountsManager.updateNoOfClassesDetails(sclId[0].Id);
        
        List<School__c> classCount = [SELECT Id, No_Of_Classes__c from School__c 
                                      Where Name = :'West Point School'];
        
        System.assertEquals(1, classCount[0].No_Of_CLasses__c);    
    }
    
    //Test Method To Validate The Results When We Pass School Name Which Have No records Which is Updating No_Of_Students!
    @isTest private Static void testNullSchoolForCountOfStudents()
    {
        CountsManager.updateNoOfStudentsDetails('Siddhi Vinayaka');
        
        List<School__c> studentCount = [SELECT Id, No_Of_Students__c from School__c 
                                        Where Name = :'Siddhi Vinayaka'
                                       ];
        
        System.assertEquals(0, studentCount[0].No_Of_Students__c);
    }
    
    //Test Method To Validate The Results When We Pass School Id Which Have No records Which is Updating No_Of_Classes!
    @istest private static void testNullSchoolForCountOfClasses()
    {
        List<School__c> sclId = [SELECT Id from School__c 
                                 Where Name = :'Siddhi Vinayaka'
                                ];
        
        CountsManager.updateNoOfClassesDetails(sclId[0].Id);
        
        List<School__c> classCount = [SELECT Id, No_Of_Classes__c from School__c 
                                      Where Name = :'Siddhi Vinayaka'
                                     ];
        
        System.assertEquals(0, classCount[0].No_Of_Classes__c);
        
    }
    
}