
// api link url class
class HttpLinks {
  static const String localUrl ='http://59.103.234.58:8002/create/video/with/image/demo';
  static const String localsUrl ='http://59.103.234.58:8002/demo_p';
  //title : bamboleo, artist gipsy kings
  static const String oneUrl ='http://59.103.234.58:8002/one_np';
/*
  static const String oneUrl ='http://59.103.234.58:8002/one_np';//title : Munda Shehar Lahore da, artist Naseebo Lal
  static const String twoUrl ='http://59.103.234.58:8002/two_np';//title : Lak wy Patla Lak wy, artist Naseebo Lal
  static const String threeUrl ='http://59.103.234.58:8002/three_np';//title : Blue ha Pani, artist Yo Yo honey Singh
  static const String fourUrl ='http://59.103.234.58:8002/four_np';//title : Athra Style Jatta, artist Sidhu Moosewala
  static const String fiveUrl ='http://59.103.234.58:8002/five_np';//title : Eid Mubarak, artist Aayat Arif
  static const String sixUrl ='http://59.103.234.58:8002/six_np';//title : Tera Suit, artist Tony Kakkar
  static const String _globalLocalUrl = 'https://wasisoft.com/softwares/wsms/api/';*/


  static const String baseUrl = 'http://59.103.234.58:8005/api';
  //static const String baseUrl = 'http://192.168.1.16:8001/api';
  static const String _baseUrl = 'http://59.103.234.58:8002/api';
  static const String getCategories = '$_baseUrl/categories';
  static const String getCategory = '$baseUrl/categories';
  static const String getSongs = '/songs';
  static const String postFcmToken = '$baseUrl/fcm-token';
  static const String aboutUs = '$baseUrl/company/profilr';
  static const String privacyPolicy = '$baseUrl/privicy/policy';
  static const String adminVideos = '$baseUrl/admin/videos';
  static const String notifications = '$baseUrl/all/notifactions';
  static const String likeApi = '$baseUrl/likes';

  static const String AdsUrl = 'http://59.103.234.58:8005/api/adds/unit/id';


}
