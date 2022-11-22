/*
Purpose         :   Test Class for "ClassTriggerHelper" apex class
Created By      :   Abhinav Sharma
Created Date    :   10/20/2022
Current Version :   v1.0
Revision Log    :   V_1.0 Created - Abhinav Sharma - 10/20/2022 - 82%
*/
@isTest(seeAllData=false)
private without sharing class ClassTriggerHelper_Test 
{  
    @testSetup static void setup() 
    {
        List<Student__c> students = TestDataFactory.createListOfStudentsTestDataWithTriggerEnabled();    
    }
    
    @isTest(seeAllData=false)
    private static void testInsertUseCase() 
    {
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
                                   WHERE No_of_Classes__c = 3
                                  ];
        System.assertEquals(1, schools.size());
        
        List<Class__c> classes = [SELECT ID 
                                  FROM Class__c
                                  WHERE School__c =: schools[0].Id
                                 ];
        System.assertEquals(3, classes.size());
        
        //Start test from here
        Test.startTest();
        
        //Enable triggers
        Utilities.BypassAllTriggers = false;
        delete classes[0];
        
        classes = [SELECT ID 
                   FROM Class__c
                  ];
        System.assertEquals(4, classes.size());
        
        schools = [SELECT ID, No_of_Classes__c, No_of_Students__c 
                   FROM School__c
                   WHERE ID =: schools[0].Id
                  ];
        System.assertEquals(1, schools.size());
        System.assertEquals(2, schools[0].No_of_Classes__c);
        
        classes = [SELECT ID 
                   FROM Class__c
                   WHERE School__c =: schools[0].Id
                  ];
        System.assertEquals(2, classes.size());
        
        //Enable triggers
        Utilities.BypassAllTriggers = false;
        delete classes;
        
        classes = [SELECT ID 
                   FROM Class__c
                  ];
        System.assertEquals(2, classes.size());
        
        schools = [SELECT ID, No_of_Classes__c, No_of_Students__c 
                   FROM School__c
                   WHERE ID =: schools[0].Id
                  ];
        System.assertEquals(1, schools.size());
        System.assertEquals(0, schools[0].No_of_Classes__c);
        System.assertEquals(0, schools[0].No_of_Students__c);
        
        //Stop test here
        Test.stopTest();
	}
}