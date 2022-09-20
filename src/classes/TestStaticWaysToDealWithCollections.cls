@isTest
public class TestStaticWaysToDealWithCollections
{
    @isTest private Static void testMapOfSchoolClassAndRelatedStudentDetails()
    {
        //Getting The Result map By Calling The staticWaysToDealWithCollectionsV1 methon By Class Name
        map<string, map<string,List<string>>> MapOfSchoolClassAndRelatedStudentDetails = staticWaysToDealWithCollections.staticWaysToDealWithCollectionsV1();
        
        //In Above Four Lines We Are Validating Cities Of Related States Of Related Countries 
        System.assertEquals(new List<String>{'Jaipur', 'Udaypur'}, MapOfSchoolClassAndRelatedStudentDetails.get('India').get('Rajasthan'));
        System.assertEquals(new List<String>{'Kolkata','Asansole'}, MapOfSchoolClassAndRelatedStudentDetails.get('India').get('WB'));
        System.assertEquals(new List<String>{'Dallas','Austin'}, MapOfSchoolClassAndRelatedStudentDetails.get('USA').get('Texas'));
        System.assertEquals(new List<String>{'Charllot','Rayleigh'}, MapOfSchoolClassAndRelatedStudentDetails.get('USA').get('NC'));
        
    }
}