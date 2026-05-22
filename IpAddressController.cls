@RestResource(urlMapping='/getClientIp/*')
global class IpAddressController {
    @HttpGet
    global static void getClientIp() {
        RestContext.response.addHeader('Content-Type', 'application/json');
        String ip = RestContext.request.remoteAddress;
        RestContext.response.responseBody = Blob.valueOf('{"ip":"' + ip + '"}');
    }
}