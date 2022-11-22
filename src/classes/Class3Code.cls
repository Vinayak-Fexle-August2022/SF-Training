/**
*  Assignment       :   Sample Apex Class
*
*  Purpose          :   Sample Apex Class Shared By Abhinav Sir Which Is Created During Apex Session.
*
*  Created Date     :   -
*
*  Created By       :   VM Banjara
*
*  Revision Logs    :   V_1.0 - Created
*
**/

public class Class3Code
{
    //Member Variables
    List<String> indiaTeamPlayerNames;
    String [] indiaTeamPlayerNames2;
    Set<String> setofIndiaTeamPlayerNames;
    Set<String> setofIndiaTeamPlayerNames2;
    Map<Integer, String> mapOfBattingOrderWithPlayerName;
    Map<Integer, String> mapOfBattingOrderWithPlayerName2;

    //Constructor
    public Class3Code()
    {
        //Memory allocation to the collections
        indiaTeamPlayerNames = new List<String>();
        indiaTeamPlayerNames2 = new List<String>{'A', 'B', 'C'};
        setofIndiaTeamPlayerNames = new Set<String>();
        setofIndiaTeamPlayerNames2 = new Set<String>{'X', 'Y', 'X'};
        mapOfBattingOrderWithPlayerName = new Map<Integer, String>();
        mapOfBattingOrderWithPlayerName = new Map<Integer, String>{1 => 'Sachin', 2 => 'Sehwag', 3 => 'Yuvraj'};

        //Adding Values into the list
        indiaTeamPlayerNames.add('Scahin');
        indiaTeamPlayerNames.add('Abhinav');
        indiaTeamPlayerNames.add('Bhavi');

        //Adding values into the set
        setofIndiaTeamPlayerNames.add('Sachin');
        setofIndiaTeamPlayerNames.add('Abhinav');
        setofIndiaTeamPlayerNames.add('Sachin');

        //Debug Log Statements
        System.debug('@@@@ indiaTeamPlayerNames ' + indiaTeamPlayerNames);
        System.debug('@@@@ indiaTeamPlayerNames2 ' + indiaTeamPlayerNames2);
        System.debug('@@@@ setofIndiaTeamPlayerNames ' + setofIndiaTeamPlayerNames);

        //Soeting for the list
        indiaTeamPlayerNames.sort();

        System.debug('@@@@ indiaTeamPlayerNames after ' + indiaTeamPlayerNames);

        //Getting value from the list
        System.debug('@@@@ indiaTeamPlayerNames Get 1 ' + indiaTeamPlayerNames[0]);
        System.debug('@@@@ indiaTeamPlayerNames Get 2 ' + indiaTeamPlayerNames[1]);
        System.debug('@@@@ indiaTeamPlayerNames Get 3 ' + indiaTeamPlayerNames.get(2));

        //popualting map with key and values
        mapOfBattingOrderWithPlayerName.put(1, 'Sachin');
        mapOfBattingOrderWithPlayerName.put(2, 'Sehwag');
        mapOfBattingOrderWithPlayerName.put(3, 'Yuvraj');

        //Getting value from the map
        System.debug('@@@@ mapOfBattingOrderWithPlayerName Get 1 ' + mapOfBattingOrderWithPlayerName.get(1));
        System.debug('@@@@ mapOfBattingOrderWithPlayerName Get 2 ' + mapOfBattingOrderWithPlayerName.get(2));
        System.debug('@@@@ mapOfBattingOrderWithPlayerName Get 2 ' + mapOfBattingOrderWithPlayerName.get(10));

    }
}