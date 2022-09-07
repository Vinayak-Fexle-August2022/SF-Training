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

    //constructor
    public DynamicWaysToDealWithCollactions(){
        map<string, map<string, List<Student__c>>> mapOfSchoolNameClassNameAndRelatedStudentDetail = new map<string, map<string, List<Student__c>>>();
        
        //for loop to get school object records one-by-one
        for(School__c school: [SELECT Id,Name FROM School__c])
        {
            map<string, List<Student__c>> mapOfClassNameAndRelatedStudentDetails = new map<string, List<Student__c>>();
            
            //for loop to get class object records respect to the related school one-by-one
            for(Class__c cls: [SELECT Name, Id FROM Class__c WHERE School__r.Id = :school.Id])
            {
                
                //getting List of students related to perticuler Class
                List<Student__c> studentList = [SELECT Name FROM Student__c WHERE Class__r.Id = :cls.Id];
                
                mapOfClassNameAndRelatedStudentDetails.put(cls.Name,studentList);
                mapOfSchoolNameClassNameAndRelatedStudentDetail.put(school.Name, mapOfClassNameAndRelatedStudentDetails);


               
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