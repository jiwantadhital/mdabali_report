class ApiClass {
  static const String testUrl =
      // "https://pg.bittiyasewa.com/api";
      "http://pg.infodev.com.np/api";
  // "http://172.31.1.20";
  static const String loginUrl = '/web-login';
  static const String totpUrl = '/otp/verify/totp';
  static const String pastFiveMonthUrl =
      '/reportingApi/transaction/past-five-month';
  static const String topupUrl = '/reportingApi/transaction/today-aggregate';
  static const String smsUrl = '/mdabaliApi/sms/aggregate-report';
  static const String memberLimitUrl = '/mdabaliApi/customer/limit';
  static const String summaryReportUrl = '/reportingApi/summary-report?';
  static const String initUrl = '/mobileApi/user/init/reporting';
}
