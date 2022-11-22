/**
*  Assignment       :   Assignment-3
*
*  Purpose          :   Test class for StaticWaysToDealWithCollection Class.
*
*  Created Date     :   -
*
*  Created By       :   VM Banjara
*
*  Revision Logs    :   V_1.0 - Created
*
**/


@isTest
public class StaticWaysToDealWithCollections_Test
{
    @isTest private Static void testMapOfCountryWithStateAndCityDetails()
    {
        //Getting The Result map By Calling The staticWaysToDealWithCollectionsV1 methon By Class Name
        map<string, map<string,List<string>>> mapOfCountryWithStateAndCityDetails = staticWaysToDealWithCollections.staticWaysToDealWithCollectionsV1();
        
        //In Above Four Lines We Are Validating Cities Of Related States Of Related Countries 
        System.assertEquals(new List<String>{'Jaipur', 'Udaypur'}, mapOfCountryWithStateAndCityDetails.get('India').get('Rajasthan'));
        System.assertEquals(new List<String>{'Kolkata','Asansole'}, mapOfCountryWithStateAndCityDetails.get('India').get('WB'));
        System.assertEquals(new List<String>{'Dallas','Austin'}, mapOfCountryWithStateAndCityDetails.get('USA').get('Texas'));
        System.assertEquals(new List<String>{'Charllot','Rayleigh'}, mapOfCountryWithStateAndCityDetails.get('USA').get('NC'));
        
    }
}