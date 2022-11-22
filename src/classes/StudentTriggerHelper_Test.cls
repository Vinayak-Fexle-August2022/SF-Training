/*
Purpose         :   Test Class for "StudentTriggerHelper" apex class
Created By      :   Abhinav Sharma
Created Date    :   10/20/2022
Current Version :   v1.0
Revision Log    :   V_1.0 Created - Abhinav Sharma - 10/20/2022 - 94%
*/
@isTest(seeAllData=false)
private without sharing class StudentTriggerHelper_Test 
{  
    @testSetup static void setup() 
    {
        //List<Bypass_Logic__c> listOfByPassLogicRecords = TestDataFactory.createBypassLogicRecords();
        List<Student__c> students = TestDataFactory.createListOfStudentsTestDataWithTriggerEnabled();    
    }
    
    @isTest(seeAllData=false)
    private static void testInsertUseCase() 
    {
        //List<Bypass_Logic__c> listOfByPassLogicRecords = [SELECT ID FROM Bypass_Logic__c];
        //System.assertEquals(1, listOfByPassLogicRecords.size());
        
        List<School__c> schools = [SELECT ID, No_of_Classes__c, No_of_Students__c 
                                   FROM School__c];
        System.assertEquals(5, schools.size());

        //Start test from here
        Test.startTest();
        
        schools = [SELECT ID, No_of_Classes__c 
                   FROM School__c
                   WHERE No_of_Classes__c = 2
                  ];
        System.assertEquals(1, schools.size());
        
        //Stop test here
        Test.stopTest();
    }
    
    @isTest(seeAllData=false)
    private static void testDeleteUseCase() 
    {
        /*@@@@ schools (
            School__c:{Id=a005g000036s9NVAAY, No_of_Classes__c=2, No_of_Students__c=2}, 
            School__c:{Id=a005g000036s9NWAAY, No_of_Classes__c=3, No_of_Students__c=3}, 
            School__c:{Id=a005g000036s9NXAAY}, 
            School__c:{Id=a005g000036s9NYAAY}, 
            School__c:{Id=a005g000036s9NZAAY})
        */
        
        List<School__c> schools = [SELECT ID, No_of_Classes__c, No_of_Students__c 
                                   FROM School__c
                                   WHERE No_of_Students__c = 3
                                  ];
        System.assertEquals(1, schools.size());
        
        List<Student__c> students = [SELECT ID, Class__r.School__c 
                                     FROM Student__c
                                     WHERE Class__r.School__c =: schools[0].Id
                                    ];
        System.assertEquals(3, students.size());
        
        //Start test from here
        Test.startTest();
        
        //Enable triggers
        Utilities.BypassAllTriggers = false;
        delete students[0];
        
        students = [SELECT ID 
                   FROM Student__c
                  ];
        System.assertEquals(4, students.size());
        
        schools = [SELECT ID, No_of_Classes__c, No_of_Students__c 
                   FROM School__c
                   WHERE ID =: schools[0].Id
                  ];
        System.assertEquals(1, schools.size());
        System.assertEquals(2, schools[0].No_of_Students__c);
        
        students = [SELECT ID, Class__r.School__c
                   FROM Student__c
                   WHERE Class__r.School__c =: schools[0].Id
                  ];
        System.assertEquals(2, students.size());
        
        //Enable triggers
        Utilities.BypassAllTriggers = false;
        delete students;
        
        students = [SELECT ID 
                   FROM Student__c
                  ];
        System.assertEquals(2, students.size());
        
        schools = [SELECT ID, No_of_Classes__c, No_of_Students__c 
                   FROM School__c
                   WHERE ID =: schools[0].Id
                  ];
        System.assertEquals(1, schools.size());
        System.assertEquals(3, schools[0].No_of_Classes__c);
        System.assertEquals(0, schools[0].No_of_Students__c);
        
        //Stop test here
        Test.stopTest();
	}
    
    @isTest(seeAllData=false)
    private static void testUpdateUseCase() 
    {
        List<School__c> schools = [SELECT ID, No_of_Classes__c, No_of_Students__c 
                                   FROM School__c];
        System.assertEquals(5, schools.size());

        schools = [SELECT ID, No_of_Classes__c 
                   FROM School__c
                   WHERE No_of_Classes__c = 2
                  ];
        System.assertEquals(1, schools.size());
        
        List<Student__c> students = [SELECT ID, Class__r.School__c 
                                     FROM Student__c
                                     WHERE Class__r.School__c =: schools[0].Id
                                    ];
        System.assertEquals(2, students.size());
        
        //Start test from here
        Test.startTest();
        
        //Enable triggers
        Utilities.BypassAllTriggers = false;
        for(Student__c std : students) 
        {
        	std.Class__c = null;
        }
        update students;
        
        schools = [SELECT ID, No_of_Classes__c, No_of_Students__c 
                   FROM School__c
                   WHERE ID =: schools[0].Id
                  ];
        System.assertEquals(1, schools.size());
        System.assertEquals(0, schools[0].No_of_Students__c);
        
		//Stop test here
        Test.stopTest();
    }
}