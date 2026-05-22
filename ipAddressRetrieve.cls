public class IpAddressController {
    @AuraEnabled
    public static String getClientIpAddress() {
        try {
            return System.Request.getCurrent().getRemoteAddress();
        } catch (Exception e) {
            ErrorLoggerCls.logError('getClientIpAddress error: ' + e.getMessage());
            return null;
        }
    }
}