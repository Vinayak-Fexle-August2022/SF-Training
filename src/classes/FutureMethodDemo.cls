/**
*
*  Purpose          :	Future method to make API Callout / To learn API Callout.
*
*  Created Date     :  	14/11/2022
*
*  Created By       :  	Vinayak Banjara
*
*  Revision Logs    :  	V_1.0 - Created
*
**/
Global class FutureMethodDemo 
{
    @future(Callout = True)
    public static void futureMethodApiCalloutPractice(String endPoint)
    {
        
        HTTP h = new HTTP();
        httpRequest req = new httpRequest();
        
        //setting httpRequest endpoint and method type(GET or POST).
        req.setEndPoint(endPoint);
        req.setMethod('GET');
        
        httpResponse res = h.send(req);
        
        //getting 
        Map<String, object> results = (Map<String, object>) JSON.deserializeUntyped(res.getBody());
        System.debug('@@@@ results'+ results);
        System.debug('@@@@ jsonBody'+ res.getBody());
    }
}