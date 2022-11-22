@isTest(seeAllData = false)
global without sharing class makeHerokuAppCalloutAndUpdateUsersMock implements HttpCalloutMock
{

	global static HTTPResponse respond(HTTPRequest request) 
    {
        HTTPResponse response = new HTTPResponse();
        response.setHeader('Content-Type', 'application/json');
        response.setbody('{"animals": ["majestic badger", "fluffy bunny", "scary bear", "chicken"]}');
        response.setStatusCode(200);
        
        return response;
    }
}