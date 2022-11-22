/**
*
*  Purpose          :	Apex Class to have the constants
*
*  Created Date     :  	09/30/2022
*
*  Created By       :  	Abhinav Sharma
*
*  Revision Logs    :  	V_1.0 - Created
*
**/
public without sharing class Constants 
{
	public static final String CHAR_BLANK = '';
    public static final String CHAR_BLANK_SPACE = ' ';
    public static final String CHAR_DASH = '-';
    
	public static final String SCHOOL_ID = 'schoolId';
    public static final String NUM_OF_CLASSES = 'numOfClasses';
    
    public static final String OBJECT_NAME_CONTACT = 'Contact';
    public static final String OBJECT_NAME_INDIVIDUAL = 'Individual';
    public static final String OBJECT_NAME_ACCOUNT = 'Account';
    public static final String OBJECT_NAME_SCHOOL = 'School__c';
    public static final String OBJECT_NAME_CLASS = 'Class__c';
    public static final String OBJECT_NAME_STUDENT = 'Student__c';
    
    public static final String SHARING_ACCESS_TYPE_READ = 'Read';
    
    public static final String SHARING_REASON_APEX_SHARING = 'Apex_Sharing__c';
    
    public static final String HTTP_CALLOUT_OPERATION_GET = 'GET';
    
    public static final Integer HTTP_CALLOUT_SUCCESS_CODE = 200;
}