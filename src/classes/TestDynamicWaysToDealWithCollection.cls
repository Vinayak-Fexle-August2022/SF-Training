/**
*  Assignment       :   Assignment-3
*
*  Purpose          :   Test class for DynamicWaysToDealWithCollection Class.
*
*  Created Date     :   -
*
*  Created By       :   VM Banjara
*
*  Revision Logs    :   V_1.0 - Created
*
**/

@isTest
public class TestDynamicWaysToDealWithCollection 
{
    @testSetup Static void requiredRecordCreation()
    {
       School__c scl = new School__c();
    	scl.Name = 'West Point School';
    	scl.No_Of_Teacher__c = 20;
    	scl.No_Of_Classes__c = 4;
    	scl.No_of_Students__c = 203;
    	insert scl;
        
    	Class__c cls1 = new Class__c();
    	cls1.Name = '1ST Class';
    	cls1.Class_Teacher_Name__c = 'Akash Jha';
    	cls1.No_of_Students__c = 43;
    	cls1.School__c = scl.Id;
        cls1.Student_Requirment__c = 'Required';
    	insert cls1;
        
        Class__c cls2 = new Class__c();
    	cls2.Name = '2nd Class';
    	cls2.Class_Teacher_Name__c = 'Akash Jha';
    	cls2.No_of_Students__c = 43;
    	cls2.School__c = scl.Id;
        cls2.Student_Requirment__c = 'Required';
    	insert cls2;
         
    	Student__c stu1 = new Student__c();
    	stu1.Name = 'Abhi Sharma';
    	stu1.Father_Name__c = 'Manoj Kumar Sharma';
        stu1.School__c = scl.Id;
        stu1.Class__c = cls1.Id;
        stu1.DOB__c = Date.newInstance(1999,05,23); 
        insert stu1;
    	
        Student__c stu2 = new Student__c();
    	stu2.Name = 'Rahul Gupta';
    	stu2.Father_Name__c = 'Gupta Uncle';
        stu2.School__c = scl.Id;
        stu2.Class__c = cls1.Id;
        stu2.DOB__c = Date.newInstance(1996,03,29);
        insert stu2;
    	
        Student__c stu3 = new Student__c();
    	stu3.Name = 'Manoj Naik';
    	stu3.Father_Name__c = 'Santosh Naik';
        stu3.School__c = scl.Id;
        stu3.Class__c = cls2.Id;
        stu3.DOB__c = Date.newInstance(1991,07,13);
        insert stu3;
        
    }
    
	@isTest Static void test_creatingDynamicMapOfSchoolClassAndRelatedStudentDetails()
    {
        Test.startTest();
        map<string, map<string, List<Student__c>>> result = DynamicWaysToDealWithCollections.creatingDynamicMapOfSchoolClassAndRelatedStudentDetails();
        List<Student__c> studentList = [SELECT Name, Id, DOB__c, AGE__c, Class__c, Class__r.Name, Class__r.School__c, Class__r.School__r.Name
                             	 		FROM Student__c 
                             	 		WHERE Class__c != Null
                             		 		And Class__r.School__c != Null
                                       ];
        Test.stopTest();
        
        System.assertEquals(new List<Student__c>{studentList[0], studentList[1]}, result.get('West Point School').get('1ST Class'));
        System.assertEquals(new List<Student__c>{studentList[2]}, result.get('West Point School').get('2nd Class'));
        
    }   
}