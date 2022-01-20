class HttpLinks {
 // static const String _localUrl = 'http://192.168.1.8:83/api/';
  static const String localUrl ='http://59.103.234.58:8002/create/video/with/image/demo';
  //title : bamboleo, artist gipsy kings

  static const String oneUrl ='http://59.103.234.58:8002/one_np';//title : Munda Shehar Lahore da, artist Naseebo Lal
  static const String twoUrl ='http://59.103.234.58:8002/two_np';//title : Lak wy Patla Lak wy, artist Naseebo Lal
  static const String threeUrl ='http://59.103.234.58:8002/three_np';//title : Blue ha Pani, artist Yo Yo honey Singh
  static const String fourUrl ='http://59.103.234.58:8002/four_np';//title : Athra Style Jatta, artist Sidhu Moosewala
  static const String fiveUrl ='http://59.103.234.58:8002/five_np';//title : Eid Mubarak, artist Aayat Arif
  static const String sixUrl ='http://59.103.234.58:8002/six_np';//title : Tera Suit, artist Tony Kakkar
  static const String _globalLocalUrl = 'https://wasisoft.com/softwares/wsms/api/';

  static const String _baseLocalUrl = localUrl;

  static const String baseUrl = 'http://59.103.234.58:8005/api';
  static const String _baseUrl = 'http://59.103.234.58:8002/api';
  static const String getCategories = '$_baseUrl/categories';
  static const String getCategory = '$baseUrl/categories';
  static const String getSongs = '/songs';
  static const String postFcmToken = '$baseUrl/fcm-token';
  static const String aboutUs = '$baseUrl/company/profilr';

  static const String AdsUrl = 'http://59.103.234.58:8005/api/adds/unit/id';
  static const String loginUrl = '${_baseLocalUrl}student/signin';
  static const String parentLoginUrl = '${_baseLocalUrl}parent/signin';
  static const String profileUrl = '/profile';
  static const String subjectListUrl = '/subjects';
  static const String testResultUrl = '/test-schedule';
  static const String timeTableUrl = '/time-table';
  static const String monthlyExamReportUrl = '/monthly-test-report?month=';
  static const AttendanceUrl = '/attendance';

}
