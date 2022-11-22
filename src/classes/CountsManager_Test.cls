@isTest(seeAllData = false)
private class CountsManager_Test
{
    @testSetup()
    private static void setUp()
    {
        List<Student__c> students = TestDataFactory.createListOfStudentsTestDataWithTriggerEnabled();
        System.assertEquals(5, students.size());
    }

    @isTest()
    private static void test_doCalculationForNoOfStudents()
    {
        List<Student__c> students = [SELECT Id 
                                     FROM Student__c 
                                    ];
        System.assertEquals(5, students.size());
        System.debug('@@@@@ schools: '+ [SELECT Id, No_Of_Students__c FROM School__c]);
        
        List<School__c> schools = [SELECT Id, No_Of_Students__c
                                   FROM School__c
                                   WHERE No_Of_Students__c =: 3
                   				  ];
         System.assertEquals(1, schools.size());
    }
}