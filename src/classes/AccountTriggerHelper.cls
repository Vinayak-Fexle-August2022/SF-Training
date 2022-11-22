/**
*
*  Purpose          :      Sharing calculation for contact object.
*
*  Created Date     :      09/11/2022
*
*  Created By       :      Vinayak Banjara
*
*  Revision Logs    :      V_1.0 - Created
*
**/
public without sharing class AccountTriggerHelper
{
    public static void apexSharingCalculationsForAccount(map<id, Account> mapOfNewAccounts, map<id, Account> mapOfOldAccounts)
    {
        set<Id> newEligibalAccountIdsSharingCalculation = new set<Id>();
        set<Id> oldEligibalAccountIdsSharingCalculation = new set<Id>();
        
        if(mapOfNewAccounts != Null && !mapOfNewAccounts.values().isEmpty())
        {
            for(Account con: mapOfNewAccounts.values())
            {
                if(true)
                {
                    newEligibalAccountIdsSharingCalculation.add(con.Id);
                }
            }
        }
        
        if(mapOfOldAccounts != Null && !mapOfOldAccounts.values().isEmpty())
        {
            for(Account con: mapOfOldAccounts.values())
            {
                if(true)
                {
                    oldEligibalAccountIdsSharingCalculation.add(con.Id);
                }
            }
        }
        
        if((newEligibalAccountIdsSharingCalculation != Null && !newEligibalAccountIdsSharingCalculation.isEmpty()) &&
           (oldEligibalAccountIdsSharingCalculation != Null && !oldEligibalAccountIdsSharingCalculation.isEmpty()))
        {
            
        }
    }
}