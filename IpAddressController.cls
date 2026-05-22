@RestResource(urlMapping='/getClientIp/*')
global class IpAddressController {
    
    @HttpGet
    global static void getClientIp() {
        try {
            RestContext.response.addHeader('Content-Type', 'application/json');
            String ip = RestContext.request.remoteAddress;
            RestContext.response.responseBody = Blob.valueOf('{"ip":"' + ip + '"}');
        } catch (Exception e) {
            ErrorLoggerCls.logError('getClientIp error: ' + e.getMessage());
            RestContext.response.statusCode = 500;
            RestContext.response.responseBody = Blob.valueOf('{"error":"Unable to retrieve IP"}');
        }
    }
}