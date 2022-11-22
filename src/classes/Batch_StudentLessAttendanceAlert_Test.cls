/*
*   Purpose         :   Test Class for "Batch_StudentLessAttendanceAlert" apex class
*
*   Created By      :   VM Banjara
*
*   Created Date    :   21/10/2022
*
*   Current Version :   v1.0
*
*   Revision Log    :   V_1.0 Created - VM Banjara - 10/15/2022
*/
@isTest(seeAllData = false)
private without sharing class Batch_StudentLessAttendanceAlert_Test 
{
    @testSetup
    private static void setup()
    {
        List<Student__c> students = TestDataFactory.createListOfStudentsTestData();
    }
    
    @isTest(seeAllData = false)
    private static void test_Batch_StudentLessAttendanceAlert()
    {
        List<Student__c> students = [SELECT ID, Class__c 
                                     FROM Student__c];
        System.assertEquals(5, students.size());
        
        for(Student__c std : students) 
        {
            std.Attendance__c = 50;
        }
        
        Utilities.BypassAllTriggers = true;
        update students;
        Utilities.BypassAllTriggers = false;
        
        students = [SELECT ID, Email_Sent__c 
                    FROM Student__c
                    WHERE Email_Sent__c = false
                   ];
        System.assertEquals(5, students.size());
        
        //test starts here
        Test.startTest();
            
        Batch_StudentLessAttendanceAlert stuBatch = new Batch_StudentLessAttendanceAlert();
        stuBatch.query = 'SELECT Id, Name, Email_Sent__c FROM Student__c Where Attendance__c < 75';
        Database.executeBatch(stuBatch, 200);
        
        //test stops here 
        Test.stopTest();
        students = [SELECT ID, Email_Sent__c 
                    FROM Student__c
                    WHERE Email_Sent__c = false
                   ];
        System.assertEquals(0, students.size());
        
    }
}