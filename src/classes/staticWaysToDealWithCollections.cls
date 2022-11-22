/**
*  Assignment       :   Assignment-1st (ApexSession#3)
*
*  Purpose          :   Class to demonstrate the static ways to deal with or populate collections in apex.
*
*  Created Date     :   05/09/2022
*
*  Created By       :   Vinayak Banjara
*
*  Revision Logs    :   V_1.0 - Created
*
**/


public class staticWaysToDealWithCollections {

    Public static map<string, map<string,List<string>>> staticWaysToDealWithCollectionsV1()
    {
        map<string, map<string,List<string>>> mapOfCountriesWithStateAndCityDetails = new map<string, map<string,List<string>>>();


        mapOfCountriesWithStateAndCityDetails.put('India', new map<string,List<string>>
                                                  {
                                                      'Rajasthan' => new List<String>{'Jaipur','Udaypur'},
                                                      'WB' => new List<String>{'Kolkata','Asansole'}
                                                  } 
                                                 );
        
       mapOfCountriesWithStateAndCityDetails.put('USA', new map<string,List<string>>
                                                  {
                                                      'Texas' => new List<String>{'Dallas','Austin'},
                                                      'NC' => new List<String>{'Charllot','Rayleigh'}
                                                  } 
                                                 );
        
        return mapOfCountriesWithStateAndCityDetails;
        
    }

}