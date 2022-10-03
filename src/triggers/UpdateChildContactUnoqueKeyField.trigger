trigger UpdateChildContactUnoqueKeyField on Account (after insert, after update) {
	//retriving every contact that is related to the account which is Created/Updated
    List<Contact> listOfContact = [SELECT Account.Name, Account.AccountNumber, Name, UniqueKey__c 
									FROM Contact
									WHERE Accountid IN: Trigger.New 
									];
    //Loop for updating UniqueKey Field on each contact
	for(Contact con: listOfContact){
		String updateduniqueKey = '';
        //Making List Of required fields for creating Unique format
		List<String> listOfContactDetail = new List<String>{con.name, con.Account.Name, (String)con.Account.AccountNumber};
        //Loop for itterating the required fields for creating Unique format
		for(String contacyListElement: listOfContactDetail){
			updateduniqueKey += contacyListElement.substring(contacyListElement.length() - 4, contacyListElement.length());
		}
		con.UniqueKey__c = updateduniqueKey;
	}
	Update listOfContact;
}