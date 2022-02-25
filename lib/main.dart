import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:provider/provider.dart';
import 'package:topi/AboutUs.dart';
import 'package:topi/AddBio.dart';
import 'package:topi/AddName.dart';
import 'package:topi/AddUserName.dart';
import 'package:topi/AppCategory.dart';
import 'package:topi/ChewiePlayer.dart';
import 'package:topi/Community.dart';
import 'package:topi/EditProfile.dart';
import 'package:topi/GetImage.dart';
import 'package:topi/Google/GoogleAds.dart';
import 'package:topi/InAppReview.dart';
import 'package:topi/Notifications.dart';
import 'package:topi/PremiumFeature.dart';
import 'package:topi/PrivacyPolicy.dart';
import 'package:topi/ShareFile.dart';
import 'package:topi/Shared_Pref.dart';
import 'package:topi/SongsList.dart';
import 'package:topi/ViewPhoto.dart';
import 'package:topi/constants.dart';
import 'package:topi/google_sign_in.dart';
import 'package:topi/home_screen.dart';
import 'package:topi/profile.dart';
import 'package:topi/starter.dart';


const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'high_importance_channel',
  'High Importance Notifications',
  importance: Importance.high,
  playSound: true,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  RemoteNotification? notification = message.notification;
  print('a bg message just show up:${notification!.title}');
}
FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPref.init();
  MobileAds.instance.initialize();
  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness:
        Brightness.light,
  ));
  runApp(MyApp());
  // color used code  #FCCC44 as like yellow, #FC9425 like orange,#DC3843 like red
}

class MyApp extends StatefulWidget {

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    firebaseMessaging.getToken().then((value) {
      setState(() {
        SharedPref.setUserFcmToken(value!);
      });
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        flutterLocalNotificationsPlugin.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(channel.id, channel.name,
                  color: Colors.amber[600],
                  playSound: true,
                  icon: '@mipmap/ic_launcher'),
            ));
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context)=>DataValueProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/songs_list': (context) => SongsList(),
          '/image_pickers': (context) => ImagePickers(),
          '/share_file': (context) => DemoApp(),
          '/in_app_review': (context) => InAppReviews(),
          '/video_players': (context) => VideoPlayers(),
          '/google_ads': (context) => Googles(),
          '/app_category': (context) => AppCategory(),
          '/about_us': (context) => AboutUs(),
          '/privacy_policy': (context) => PrivacyPolicy(),
          '/notification': (context) => Notifications(),
          '/community': (context) => Community(),
          '/premium_feature': (context) => PremiumFeature(),
          '/profile': (context) => Profile(),
          '/add_bio': (context) => AddBio(),
          '/add_name': (context) => AddName(),
          '/user_name': (context) => AddUserName(),
          '/edit_profile': (context) => EditProfile(),
          '/view_photo': (context) => ViewPhoto(),
        },
        home: AppCategory(),
      ),
    );
  }
}
