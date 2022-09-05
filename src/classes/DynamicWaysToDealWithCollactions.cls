/**
*  Assignment       :   Assignment-2nd (ApexSession#3)
*
*  Purpose          :   Class to demonstrate the dynamic ways to deal with or populate collections in apex.
*
*  Created Date     :   05/09/2022
*
*  Created By       :   Vinayak Banjara
*
*  Revision Logs    :   V_1.0 - Created
*
**/

public class DynamicWaysToDealWithCollactions {
    public DynamicWaysToDealWithCollactions(){
        map<string, map<string, List<Student__c>>> mapOfSchoolNameClassNameAndRelatedStudentDetail = new map<string, map<string, List<Student__c>>>();
        List<School__c> sclList = [SELECT Id,Name FROM School__c];
        
        for(School__c scl: sclList){
            map<string, List<Student__c>> mapOfClassNameAndRelatedStudentDetails = new map<string, List<Student__c>>();
            List<Class__c> clsList = [SELECT Name, Id FROM Class__c WHERE School__r.Id = :scl.Id];

            	for(Class__c cls: clsList){
                	List<Student__c> stuList = [SELECT Name FROM Student__c WHERE Class__r.Id = :cls.Id];
                	mapOfClassNameAndRelatedStudentDetails.put(cls.Name,stuList);
                	mapOfSchoolNameClassNameAndRelatedStudentDetail.put(scl.Name, mapOfClassNameAndRelatedStudentDetails);
               
            }
        }
      system.debug('@@@@ mapOfSchoolNameClassNameAndRelatedStudentDetail'+mapOfSchoolNameClassNameAndRelatedStudentDetail);
    }
}


/**

*
*
*	@@@@ mapOfSchoolNameClassNameAndRelatedStudentDetail{India International School={10th-CBSC=(Student__c:{Name=Vishal Mishra, Class__c=a035g0000073Dp4AAE, Id=a045g000009BwY3AAK, RecordTypeId=0125g000000eMQXAA2}, 
*																								Student__c:{Name=Narendra modi, Class__c=a035g0000073Dp4AAE, Id=a045g000009BwaJAAS, RecordTypeId=0125g000000eMQXAA2}), 
*																					 11th-CBSC=(Student__c:{Name=Shahrukh Khan, Class__c=a035g0000073Dp9AAE, Id=a045g000009BwaiAAC, RecordTypeId=0125g000000eMQhAAM}, 
*																								Student__c:{Name=Rahul Gandhi, Class__c=a03.............So-On
*
**/