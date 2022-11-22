public class Addition
{
    @testVisible private static List<Student__c> test1()
    {
		return [SELECT Name FROM Student__c LIMIT 1];
    }
}