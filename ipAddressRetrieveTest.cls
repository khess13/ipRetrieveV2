@isTest
public class IpAddressControllerTest {

    @isTest
    static void testGetClientIpAddress() {
        Test.startTest();
        String ip = IpAddressController.getClientIpAddress();
        Test.stopTest();

        System.assert(ip == null || ip instanceof String, 'Expected a String or null IP address');
        
        // Verify a log record was created — replace Error_Log__c with your object API name
        List<Error_Log__c> logs = [SELECT Id FROM Error_Log__c LIMIT 1];
        System.assert(!logs.isEmpty(), 'Expected a log record to be created');
    }

    @isTest
    static void testGetClientIpAddressNoException() {
        Test.startTest();
        Boolean exceptionThrown = false;
        try {
            IpAddressController.getClientIpAddress();
        } catch (Exception e) {
            exceptionThrown = true;
        }
        Test.stopTest();

        System.assertEquals(false, exceptionThrown, 'No exception should be thrown');
    }
}