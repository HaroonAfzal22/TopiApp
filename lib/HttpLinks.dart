class HttpLinks {
 // static const String _localUrl = 'http://192.168.1.8:83/api/';
  static const String localUrl ='http://38.17.53.143/predict';
  static const String _globalLocalUrl = 'https://wasisoft.com/softwares/wsms/api/';

  static const String _baseLocalUrl = localUrl;

  static const String Url = '${_baseLocalUrl}students/';
  static const String loginUrl = '${_baseLocalUrl}student/signin';
  static const String parentLoginUrl = '${_baseLocalUrl}parent/signin';
  static const String profileUrl = '/profile';
  static const String subjectListUrl = '/subjects';
  static const String testResultUrl = '/test-schedule';
  static const String timeTableUrl = '/time-table';
  static const String monthlyExamReportUrl = '/monthly-test-report?month=';
  static const AttendanceUrl = '/attendance';

}
