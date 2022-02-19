import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static late SharedPreferences _preferences;

  static Future<void> init() async =>
      _preferences = await SharedPreferences.getInstance();

  static Future<void> removeData() async {

    for (String key in _preferences.getKeys()) {
      if (key != "base_url" && key != "fcm_token") {
       await _preferences.remove(key);
      }
    }
  }
  static void removeSchoolInfo() {
    for (String key in _preferences.getKeys()) {
      if (key == "school" && key == "branch" && key =='school_logo'&& key =='school_color') {
        _preferences.remove(key);
      }
    }
  }
  static Future<void> setNativeAd(String userName) => _preferences.setString('native_ad', userName);
  static Future<void> setBannerAd(String userName) => _preferences.setString('banner_ad', userName);
  static Future<void> setInterstitialAd(String userName) => _preferences.setString('interstitial_ad', userName);
  static Future<void> setRewardedAd(String userName) => _preferences.setString('rewarded_ad', userName);
  static Future<void> setBio(String userName) => _preferences.setString('bio', userName);
  static Future<void> setProfileImage(File userName) => _preferences.setString('profile_image', userName.path.toString());


  static Future<void> setUserFcmToken(String userName) => _preferences.setString('fcm_token', userName);

  static Future<void> setSongPremium(String name) => _preferences.setString('song_premium', name);


  static Future<void> setSongId(String name) => _preferences.setString('song_id', name);

  static Future<void> setAppVersion(String userName) async {_preferences.setString('app_version', userName);}

  static  getNativeAd() => _preferences.getString('native_ad');
  static  getBio() => _preferences.getString('bio');
  static  getBannerAd() => _preferences.getString('banner_ad');
  static  getInterstitialAd() => _preferences.getString('interstitial_ad');
  static  getRewardedAd() => _preferences.getString('rewarded_ad');
  static  getProfileImage() => _preferences.getString('profile_image');



  static String? getUserFcmToken() => _preferences.getString('fcm_token');

  static  getSongPremium() => _preferences.getString('song_premium');

  static getSongId() => _preferences.get('song_id');

  static String? getAppVersion() => _preferences.getString('app_version');


}
