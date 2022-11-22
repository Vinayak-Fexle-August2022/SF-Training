trigger Trigger_UpdateAccountName on Account (before insert)
{
	for(Account acc:Trigger.new)
    {
        acc.Name = acc.Name + '_' + Date.Today();
    }
}