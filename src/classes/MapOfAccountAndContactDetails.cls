/**
*  Assignment       :   Assesment Task
*
*  Purpose          :   Apex Class For Evaluating A Map Of Account Id And Related Contact Details``.
*
*  Created Date     :   -
*
*  Created By       :   VM Banjara
*
*  Revision Logs    :   V_1.0 - Modified
*
**/


public class MapOfAccountAndContactDetails 
{
    public MapOfAccountAndContactDetails()
    {
        map<Id, map<Id, Contact>> accountContactMap = new map<Id, map<Id, Contact>>();
        List<Contact> contactList = [SELECT Id, Name, accountid 
                                     From Contact
                                    ];
        
        for(Contact con: contactList)
        {
            if(accountContactMap.containsKey(con.accountid))
            {
                if(accountContactMap.get(con.accountid).containsKey(con.Id))
                {
                    continue;
                }
                else
                {
                    accountContactMap.get(con.accountid).put(con.Id, con);
                } 
            }
            else
            {
                map<Id, Contact> conMap2 = new map<Id, Contact>{con.Id => con};
                accountContactMap.put(con.accountid, conMap2);
            }
        }
        
        List<map<Id, Contact>> val = accountContactMap.values();
        system.debug('@@@@ accountContactMap'+ accountContactMap);
        
        for(map<Id, Contact> valElements: val)
        {
            System.debug(valElements);
        }

    }
}