public class IpAddressController {
    @AuraEnabled
    public static String getClientIpAddress() {
        try {
            List<AuthSession> sessions = [
                SELECT SourceIp FROM AuthSession
                WHERE UsersId = :UserInfo.getUserId()
                AND IsCurrent = true
                LIMIT 1
            ];
            if (!sessions.isEmpty()) {
                return sessions[0].SourceIp;
            }
            return null;
        } catch (Exception e) {
            ErrorLoggerCls.logError('getClientIpAddress error: ' + e.getMessage());
            return null;
        }
    }
}