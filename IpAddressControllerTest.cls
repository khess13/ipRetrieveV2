@isTest
public class IpAddressControllerTest {

    @isTest
    static void testGetClientIp() {
        // Set up REST context
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        req.requestURI = '/services/apexrest/getClientIp/';
        req.httpMethod = 'GET';
        RestContext.request = req;
        RestContext.response = res;

        Test.startTest();
        IpAddressController.getClientIp();
        Test.stopTest();

        System.assertEquals('application/json', res.headers.get('Content-Type'));
        System.assertNotEquals(null, res.responseBody, 'Response body should not be null');

        // Parse and verify response structure
        Map<String, Object> responseMap = (Map<String, Object>) JSON.deserializeUntyped(
            res.responseBody.toString()
        );
        System.assert(responseMap.containsKey('ip'), 'Response should contain ip key');
    }

    @isTest
    static void testGetClientIpErrorHandling() {
        // Intentionally do not set RestContext to trigger error handling
        RestContext.request = null;
        RestContext.response = new RestResponse();

        Test.startTest();
        Boolean exceptionThrown = false;
        try {
            IpAddressController.getClientIp();
        } catch (Exception e) {
            exceptionThrown = true;
        }
        Test.stopTest();

        System.assertEquals(false, exceptionThrown, 'No exception