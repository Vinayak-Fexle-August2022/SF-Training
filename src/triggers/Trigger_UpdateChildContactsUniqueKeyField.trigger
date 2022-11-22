/**
*  Assignment       :   Apex Programing Execrise #2
*
*  Purpose          :   Apex Trigger To Update Account's Child Contact's UniqueKey Field On The Behalf Of 
*						AccountName Changes.
*
*  Created Date     :   30-Sep-2022
*
*  Created By       :   Vinayak Banjara
*
*  Revision Logs    :   V_1.1 - Created
*
**/
trigger Trigger_UpdateChildContactsUniqueKeyField on Account (after insert, after update) 
{
	//retriving every contact that is related to the account which is Created/Updated
    List<Contact> listOfContact = [SELECT Account.Name, Account.AccountNumber, LastName, FirstName, UniqueKey__c 
								   FROM Contact
								   WHERE Accountid IN: Trigger.New 
								   ];
    
    //Loop for updating UniqueKey Field on each contact
	for(Contact con: listOfContact)
    {
		String updateduniqueKey = '';
        
        //Making List Of required fields for creating Unique format
		List<String> listOfContactDetail = new List<String>{con.Account.Name, (String)con.Account.AccountNumber, con.FirstName, con.LastName};
            
        //Loop for itterating the required fields for creating Unique format
		for(String contactListElement: listOfContactDetail)
        {
            //Validating That the given Field length is greater than 4
            Integer substractionValue = contactListElement.length() - 4;
            
            if(substractionValue > 0)
            {
                updateduniqueKey += contactListElement.substring(substractionValue, contactListElement.length());
            }
            else
            {
                updateduniqueKey += contactListElement;
            }
		}
		con.UniqueKey__c = updateduniqueKey;
	}
	Update listOfContact;
}