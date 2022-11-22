/**
*  Assignment       :   Practice Class
*
*  Purpose          :   Apex Practice Class For Applying 10% Discount On Book Price.
*
*  Created Date     :   -
*
*  Created By       :   VM Banjara
*
*  Revision Logs    :   V_1.0 - Created
*
**/

public class MyHelloWorld 
{
	public static void applyDiscount(Book__c[] books) 
    {
   		for (Book__c b :books)
   		{
      		b.Price__c *= 0.9;
   		}
	}
}