class HttpLinks {
 // static const String _localUrl = 'http://192.168.1.8:83/api/';
  static const String localUrl ='http://38.17.53.143/predict';//title : bamboleo, artist gipsy kings
  static const String oneUrl ='http://38.17.53.143/one_np';//title : Munda Shehar Lahore da, artist Naseebo Lal
  static const String twoUrl ='http://38.17.53.143/two_np';//title : Lak wy Patla Lak wy, artist Naseebo Lal
  static const String threeUrl ='http://38.17.53.143/three_np';//title : Blue ha Pani, artist Yo Yo honey Singh
  static const String fourUrl ='http://38.17.53.143/four_np';//title : Athra Style Jatta, artist Sidhu Moosewala
  static const String fiveUrl ='http://38.17.53.143/five_np';//title : Eid Mubarak, artist Aayat Arif
  static const String sixUrl ='http://38.17.53.143/six_np';//title : Tera Suit, artist Tony Kakkar
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
