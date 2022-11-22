/*
*   Purpose         :   Test Class for "SchoolTriggerHelper" apex class
*
*   Created By      :   Abhinav Sharma
*
*   Current Version :   v1.0
*
*   Revision Log    :   V_1.0 Created - Abhinav Sharma - Oct-13-2022
*/
@isTest(seeAllData=false)
private without sharing class SchoolTriggerHelper_Test 
{  
    @testSetup static void setup() 
    {
        List<Student__c> students = TestDataFactory.createListOfStudentsTestDataWithTriggerEnabled();
    }
    
    @isTest(seeAllData=false)
    private static void testPerformValidationLogics() 
    {
        List<School__c> schools = [SELECT ID, No_of_Classes__c, No_of_Students__c, About_US__c 
                                   FROM School__c];
        System.assertEquals(5, schools.size());
        
        for(School__c sc : schools) 
        {
            sc.About_US__c = null;
        }
        
        //Start test from here
        Test.startTest();
        
        //Update accounts records
        try 
        {
            update schools;    
        }
        catch(Exception ex) 
        {
            System.assert(ex.getMessage().contains(System.Label.ERROR_MSG_ABOUT_US_DETAILS_MISSING));
        }
    }    
    
    @isTest(seeAllData=false)
    private static void testNoOfClassesDetails() 
    {
        List<School__c> schools = [SELECT ID, No_of_Classes__c, No_of_Students__c 
                                   FROM School__c];
        System.assertEquals(5, schools.size());
        
        /*@@@@ schools (School__c:{Id=a005g000036s9NVAAY, No_of_Classes__c=2, No_of_Students__c=2}, 
                        School__c:{Id=a005g000036s9NWAAY, No_of_Classes__c=3, No_of_Students__c=3}, 
                        School__c:{Id=a005g000036s9NXAAY}, 
                        School__c:{Id=a005g000036s9NYAAY}, 
                        School__c:{Id=a005g000036s9NZAAY})
*/
        
        schools = [SELECT ID, No_of_Classes__c 
                   FROM School__c
                   WHERE No_of_Classes__c = 2
                  ];
        System.assertEquals(1, schools.size());
        
        //Start test from here
        Test.startTest();
        
        schools[0].No_of_Classes__c = 0;
        update schools;
        
        schools = [SELECT ID, No_of_Classes__c 
                   FROM School__c
                   WHERE No_of_Classes__c = 2
                  ];
        System.assertEquals(1, schools.size());
        
        //Stop test here
        Test.stopTest();
    }
    
    @isTest(seeAllData=false)
    static void testNoOfStudentDetails() 
    {
        List<School__c> schools = [SELECT ID, No_of_Classes__c, No_of_Students__c 
                                   FROM School__c];
        System.assertEquals(5, schools.size());
        
        /*@@@@ schools (School__c:{Id=a005g000036s9NVAAY, No_of_Classes__c=2, No_of_Students__c=2}, 
                        School__c:{Id=a005g000036s9NWAAY, No_of_Classes__c=3, No_of_Students__c=3}, 
                        School__c:{Id=a005g000036s9NXAAY}, 
                        School__c:{Id=a005g000036s9NYAAY}, 
                        School__c:{Id=a005g000036s9NZAAY})
*/
        
        schools = [SELECT ID, No_of_Classes__c 
                   FROM School__c
                   WHERE No_of_Students__c = 3
                  ];
        System.assertEquals(1, schools.size());
        
        //Start test from here
        Test.startTest();
        
        Utilities.BypassAllTriggers = false;
        schools[0].No_of_Students__c = 0;
        update schools;
        
        schools = [SELECT ID, No_of_Students__c 
                   FROM School__c
                   WHERE No_of_Students__c = 3
                  ];
        System.assertEquals(1, schools.size());
        
        //Stop test here
        Test.stopTest();        
    }
    
    @isTest(seeAllData = False)
    private static void testdoApexSharingCalculations()
    {
        /* Creating mock HTTP response for test
        StaticResourceCalloutMock mock = new StaticResourceCalloutMock();
        mock.setStaticResource('AnimalResource');
        mock.setStatusCode(200);
        mock.setHeader('Content-Type', 'application/json;charset=UTF-8');
		*/
        
        
        // Associate the callout with a mock response
        Test.setMock(HttpCalloutMock.class, new makeHerokuAppCalloutAndUpdateUsersMock());
        
        List<School__c> schools = [SELECT ID, No_of_Classes__c, No_of_Students__c 
                                   FROM School__c 
                                   WHERE No_Of_Teacher__c != Null
                                  ];
        System.assertEquals(5, schools.size());
        
        schools = [SELECT ID, No_Of_Teacher__c
                   FROM School__c 
                   WHERE No_Of_Teacher__c != Null
                   AND No_Of_Teacher__c < 10 Limit 2
                  ];
        System.assertEquals(2, schools.size());
        
        //Test Starts Here
        Test.startTest();
        
        List<School__share> schoolManagedSharingRecords = [SELECT Id, UserOrGroupId
                                                           FROM School__share
                                                           WHERE UserOrGroupId =: System.Label.INTEGRATION_USER_RECORD_ID
                                                          ];
        System.assertEquals(0, schoolManagedSharingRecords.size());
        
        for(School__c sch: schools)
        {
            sch.No_Of_Teacher__c = 15;
        }
        update(schools);
        
        //Test Stops Here
        Test.stopTest();
        
        schoolManagedSharingRecords = [SELECT Id, UserOrGroupId
                                       FROM School__share
                                       WHERE UserOrGroupId =: System.Label.INTEGRATION_USER_RECORD_ID
                                      ];
        System.assertEquals(2, schoolManagedSharingRecords.size());
        
        List<User> integrationUserDetails = [SELECT Id, Heroku_App_Response__c FROM User
                                             WHERE Id =: System.Label.INTEGRATION_USER_RECORD_ID
                                             AND IsActive = true
                                            ];
        System.assertEquals(1, integrationUserDetails.size());
        System.debug('@@@@ integrationUserDetails'+ integrationUserDetails[0]);
        System.assertEquals(schools[0].Id+' '+schools[1].Id+' '+' - majestic badger - fluffy bunny - scary bear - chicken', integrationUserDetails[0].Heroku_App_Response__c);
        
        
    }
}