@isTest(seeAllData = false)
public class MyDataFactory_Test
{
    @isTest(seeAllData = false)
    public static List<School__c> createListOfSchools()
    {
        List<School__c> schools = new List<School__c>();//List<Class__c> classes = new List<Class__c>();
        for(Integer i=0; i<5; i++)
        {
            School__c scl = (School__c)SmartFactory.createSObject('School__c');
            schools.add(scl);
        }
        
        insert schools;
        System.assertEquals(5, schools.size());
        return schools;
    }
    
    @isTest(seeAllData = false)
    public static List<Class__c> createListOfClasses()
    {
        List<School__c> schools = createListOfSchools();
        List<Class__c> classes = new List<Class__c>();
        
        Integer seq = 0;
        for(Integer j=0; j<5; j++)
        {
            Class__c cls = new Class__c();
            if(seq != 0 && seq != 1)
            {
                cls.School__c = schools[1].Id;
                cls.Name = 'cls'+j;
                cls.Class_Teacher_Name__c = 'teacher'+j;
                cls.No_of_Students__c = 10;
                cls.Student_Requirment__c = 'full';
                classes.add(cls);
                seq++;
            }
            else
            {
                cls.School__c = schools[0].Id;
                cls.Name = 'cls'+j;
                cls.Class_Teacher_Name__c = 'teacher'+j;
                cls.No_of_Students__c = 10;
                cls.Student_Requirment__c = 'full';
                classes.add(cls);
                seq++;
            }
        }
        
        insert classes;
        System.assertEquals(5, classes.size());
        
        List<School__c> schoolList = [SELECT Id, No_Of_Classes__c
                                      FROM School__c 
                                     ];
        System.assertEquals(5, schoolList.size());
        return classes;
    }
    
    @isTest(seeAllData = false)
    public static List<Class__c> createListOfStudents()
    {
        List<Class__c> classes = createListOfClasses();
        List<Student__c> students = new List<Student__c>();
        Integer seq = 0;
        for(Integer k=0; k<5; k++) 
        {
            if(seq != 0 && seq != 1 )
            {
                Student__c stu = new Student__c();
                stu.Class__c = classes[2].Id;
                stu.Name = 'student'+k;
                stu.DOB__c = Date.newInstance(2001, k, 1);
                stu.Father_Name__c = 'Father'+k;
                seq++;
            }
            else 
            {
                Student__c stu = new Student__c();
                stu.Class__c = classes[0].Id;
                stu.Name = 'student'+k;
                stu.DOB__c = Date.newInstance(2001, k, 1);
                stu.Father_Name__c = 'Father'+k;
                seq++;
            } 
        }
        
        List<School__c> schoolList = [SELECT Id, No_Of_Classes__c, No_Of_Students__c
                                      FROM School__c
                                     ];
        System.debug('@@@@@ schools to validate the inserted schools are valid or Not: ' + schoolList);
        System.assertEquals(5, schoolList.size());
        return classes;
    } 
}