public class staticWaysToDealWithCollections {

    Public staticWaysToDealWithCollections(){
        map<string, map<string,List<string>>> mapOfCountriesWithStateAndCityDetails = new map<string, map<string,List<string>>>();

        List<string> citiesOfRajasthan = new List<string>{'Jaipur','Udaypur'};
        map<string,List<string>> StateAndCitiesOfRajasthan = new map<string,List<string>>();
        StateAndCitiesOfRajasthan.put('Rajasthan',citiesOfRajasthan);
        mapOfCountriesWithStateAndCityDetails.put('India1', StateAndCitiesOfRajasthan);
        
        List<string> citiesOfWB = new List<string>{'Kolkata','Asansole'};
        map<string,List<string>> StateAndCitiesOfWB = new map<string,List<string>>();
    	StateAndCitiesOfWB.put('WB',citiesOfWB);
        mapOfCountriesWithStateAndCityDetails.put('India2', StateAndCitiesOfWB);
    	
        List<string> citiesOfTexas = new List<string>{'Dallas','Austin'};
        map<string,List<string>> StateAndCitiesOfTaxas = new map<string,List<string>>();
    	StateAndCitiesOfTaxas.put('Texas',citiesOfTexas);
    	mapOfCountriesWithStateAndCityDetails.put('USA1', StateAndCitiesOfTaxas);
        
        List<string> citiesOfNC = new List<string>{'Charllot','Rayleigh'};
        map<string,List<string>> StateAndCitiesOfNC  = new map<string,List<string>>();
    	StateAndCitiesOfNC.put('NC',citiesOfNC);
        mapOfCountriesWithStateAndCityDetails.put('USA', StateAndCitiesOfNC);
        
        System.debug(mapOfCountriesWithStateAndCityDetails);
    }

}