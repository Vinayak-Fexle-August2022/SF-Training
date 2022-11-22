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
public without sharing class Batch_StudentLessAttendanceAlert implements Database.Batchable<sObject>, Database.stateful
{
    public String query;
    public String log;
    
    public Batch_StudentLessAttendanceAlert()
    {
	    query = '';
    	log = '';
    }
    
    public Database.QueryLocator start(Database.BatchableContext BC)
    {
        return Database.getQueryLocator(query);
    }
    
    public void execute(Database.BatchableContext BC, List<Student__c> students)
    {
        for(Student__c s : students)
        {
            log += s.Name + ' ';
            s.Email_Sent__c = true;  
        }
        update students;
    }
    
    public void finish(Database.BatchableContext BC)
    {
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        
        String[] toAddresses = new String[] {'rahul.gupta@fexle.com'};
            
        mail.setToAddresses(toAddresses);
        
        mail.setSubject('Students With Less Than 75% Attendance');
        
        mail.setPlainTextBody('List Of Student Name Who having less than 75% Attendance ' + log);
        
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
    }
}