/**
*
*  Purpose          :	Batch class for doing Sharing Rules based recalculation for the School object.
*
*  Created Date     :  	04/11/2022
*
*  Created By       :  	Abhinav Sharma
*
*  Revision Logs    :  	V_1.0 - Created
*
**/
public without sharing class Batch_RecalculateSharingRuleForSchools implements Database.Batchable<Sobject>
{
    @TestVisible static Integer emailLimits;
    public String query;
    public String log;
    
    public Batch_RecalculateSharingRuleForSchools() 
    {
        query = 'SELECT ID FROM School__c';
        log = '';
    }
    
    public Database.QueryLocator start(Database.BatchableContext BC)
    {
        return Database.getQueryLocator(query);
    }
    
    // The executeBatch method is called for each chunk of records returned from start.
    public void execute(Database.BatchableContext bc, List<School__c> scope)
    {
        log = utilities.getErrorLogMessageForRecords(scope);
    }
    
    public void finish(Database.BatchableContext BC)
    {
        Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
        
        mail.setToAddresses(new String[] {'vinayak.banjara@fexle.com'});
        mail.setReplyTo('batch@acme.com');
        mail.setSenderDisplayName('Batch Processing');
        mail.setSubject('Batch Process Completed');
        mail.setPlainTextBody('Batch Process has completed ' + log + ' ' + query);
        Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
        Batch_RecalculateSharingRuleForSchools.emailLimits = Limits.getEmailInvocations();
    }
}