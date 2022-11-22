/**
*
*  Purpose          :	Trigger Helper Class For Contact object.
*
*  Created Date     :  	14/10/2022
*
*  Created By       :  	Vinayak Banjara
*
*  Revision Logs    :  	V_1.0 - Created
*
**/
public class ManageContactSequenceTriggerHelper
{
	public Static Void arrangeContacts(List<Contact> listOfContacts, map<Id, contact> mapOfOldContats)
    {
        if(Utilities.BypassAllTriggers)
            return;
        
        List<Contact> finalContactListToBeUpdated = new List<Contact>();
        map<Id, Contact> mapOfAccountIdAndContactDetails = new map<Id, Contact>();
        
        if(listOfContacts != Null && listOfContacts.size() > 0)
        {
            for(Contact con :listOfContacts)
            {
                if(con.Paid_Amount__c != Null && con.Paid_Amount__c != mapOfOldContats.get(con.Id).Paid_Amount__c)
                {
                    mapOfAccountIdAndContactDetails.put(con.Accountid, con);
                }
            }
        }
        
        if(mapOfAccountIdAndContactDetails.values() != Null && mapOfAccountIdAndContactDetails.values().size() > 0)
        {
            for(Account acc: [SELECT Id, Name, (SELECT Id, Sequence_Number__c, 	Paid_Amount__c FROM contacts order by Paid_Amount__c DESC)
                                                FROM Account
                                                WHERE Id IN: mapOfAccountIdAndContactDetails.keySet()])
            {
                if(acc.contacts != Null && !acc.contacts.isEmpty())
                {
                    integer sequence = 1;
                    for(Contact con: acc.contacts)
                    {
                        con.Sequence_Number__c = sequence;
                        sequence++;
                    }
                    finalContactListToBeUpdated.addAll(acc.contacts);
                }
            }
            
            Utilities.BypassAllTriggers = True;
            update finalContactListToBeUpdated;
            Utilities.BypassAllTriggers = False;
        }
    }
    
    
    public Static Void arrangeNewInsertedContacts(List<Contact> listOfContacts, map<Id, contact> mapOfOldContats)
    {
        if(Utilities.BypassAllTriggers)
            return;
        
        List<Contact> finalContactListToBeUpdated = new List<Contact>();
        map<Id, Contact> mapOfAccountIdAndContactDetails = new map<Id, Contact>();
        
        if(listOfContacts != Null && listOfContacts.size() > 0)
        {
            for(Contact con :listOfContacts)
            {
                if(con.Paid_Amount__c != Null)
                {
                    mapOfAccountIdAndContactDetails.put(con.Accountid, con);
                }
            }
        }
        
        if(mapOfAccountIdAndContactDetails != Null && mapOfAccountIdAndContactDetails.keySet().size() > 0)
        {
            for(Account acc: [SELECT Id, Name, (SELECT Id, Sequence_Number__c, 	Paid_Amount__c FROM contacts order by Paid_Amount__c DESC)
                                                FROM Account
                                                WHERE Id IN: mapOfAccountIdAndContactDetails.keySet()])
            {
                if(acc.contacts != Null && !acc.contacts.isEmpty())
                {
                    integer sequence = 1;
                    for(Contact con: acc.contacts)
                    {
                        con.Sequence_Number__c = sequence;
                        sequence++;
                    }
                    finalContactListToBeUpdated.addAll(acc.contacts);
                }
            }
            
            Utilities.BypassAllTriggers = True;
            update finalContactListToBeUpdated;
            Utilities.BypassAllTriggers = False;
        }
    }
    
    
    public Static Void arrangeContactsAfterDelete(List<Contact> listOfDeletedContacts, map<Id, contact> mapOfOldContats)
    {
        if(Utilities.BypassAllTriggers)
            return;
        
        List<Contact> finalContactListToBeUpdated = new List<Contact>();
        map<Id, Contact> mapOfAccountIdAndContactDetails = new map<Id, Contact>();
        
        if(listOfDeletedContacts != Null && listOfDeletedContacts.size() > 0)
        {
            for(Contact con :listOfDeletedContacts)
            {
                mapOfAccountIdAndContactDetails.put(con.Accountid, con);
            }
        }
        
        if(mapOfAccountIdAndContactDetails != Null && mapOfAccountIdAndContactDetails.keySet().size() > 0)
        {
            for(Account acc: [SELECT Id, Name, (SELECT Id, Sequence_Number__c, 	Paid_Amount__c FROM contacts order by Paid_Amount__c DESC)
                                                FROM Account
                                                WHERE Id IN: mapOfAccountIdAndContactDetails.keySet()])
            {
                if(acc.contacts != Null && !acc.contacts.isEmpty())
                {
                    integer sequence = 1;
                    for(Contact con: acc.contacts)
                    {
                        con.Sequence_Number__c = sequence;
                        sequence++;
                    }
                    finalContactListToBeUpdated.addAll(acc.contacts);
                }
            }            
            Utilities.BypassAllTriggers = True;
            update finalContactListToBeUpdated;
            Utilities.BypassAllTriggers = False;
        }
    }
}