public class PracticeApex
{
    public PracticeApex()
    {
        list<School__c> schools = (list<School__c>)SmartFactory.createSObjectList(Constants.OBJECT_NAME_SCHOOL, false, 51000);
    }
}