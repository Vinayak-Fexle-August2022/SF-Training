Global without sharing class Sch_Batch_StudentLessAttendanceAlert implements Schedulable
{
	public void execute(SchedulableContext SC)
    {
        Batch_StudentLessAttendanceAlert stuBatch = new Batch_StudentLessAttendanceAlert();
        stuBatch.query = 'SELECT Id, Name, Email_Sent__c FROM Student__c Where Attendance__c < 75';
        Database.executeBatch(stuBatch, 200);
    }
}