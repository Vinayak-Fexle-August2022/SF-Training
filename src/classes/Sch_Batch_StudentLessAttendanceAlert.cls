/**
*
*  Purpose          :      To Alert Students With Less Than 75% Attendence.
*
*  Created Date     :      21/10/2022
*
*  Created By       :      Vinayak Banjara
*
*  Revision Logs    :      V_1.0 - Created
*
**/
Global without sharing class Sch_Batch_StudentLessAttendanceAlert implements Schedulable
{
	public void execute(SchedulableContext SC)
    {
        Batch_StudentLessAttendanceAlert stuBatch = new Batch_StudentLessAttendanceAlert();
        stuBatch.query = 'SELECT Id, Name, Email_Sent__c FROM Student__c Where Attendance__c < 75';
        Database.executeBatch(stuBatch, 200);
    }
}