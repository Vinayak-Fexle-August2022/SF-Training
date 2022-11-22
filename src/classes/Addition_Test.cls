/*
*   Purpose         :   Test Class for "Addition" apex class
*
*   Created By      :   VM Banjara
*
*   Created Date    :   10/15/2022
*
*   Current Version :   v1.0
*
*   Revision Log    :   V_1.0 Created - VM Banjara - 10/15/2022
*/
@isTest(seeAllData = false)
public class Addition_Test
{
    @testSetup
    private static void setup()
    {
        TestDataFactory.createListOfStudentsTestData();
    }
	@istest(seeAllData = false)
    private static void test()
    {
        List<Student__c> stu = Addition.test1();
        System.assertEquals(True, !stu.isEmpty());
    }
    
}