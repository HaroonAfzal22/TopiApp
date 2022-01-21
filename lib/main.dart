import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:image_picker/image_picker.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:topi/AboutUs.dart';
import 'package:topi/AppCategory.dart';
import 'package:topi/CategoryList.dart';
import 'package:topi/ChewiePlayer.dart';
import 'package:topi/GetImage.dart';
import 'package:topi/Google/GoogleAds.dart';
import 'package:topi/InAppReview.dart';
import 'package:topi/PrivacyPolicy.dart';
import 'package:topi/ShareFile.dart';
import 'package:topi/Shared_Pref.dart';
import 'package:topi/SongsList.dart';
import 'package:topi/constants.dart';
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
  print('a bg message just show up:${message.data}');
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
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      /* RemoteNotification ?notification = message.notification;
      AndroidNotification ?android = message.notification?.android;
      if (notification != null && android != null) {
        Navigator.pushNamed(this.context, '/notifications');
      }*/
    });

  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/starter': (context) => StartScreen(),
        '/songs_list': (context) => SongsList(),
        '/image_pickers': (context) => ImagePickers(),
        '/share_file': (context) => DemoApp(),
        '/in_app_review': (context) => InAppReviews(),
        '/video_players': (context) => VideoPlayers(),
        '/google_ads': (context) => Googles(),
        '/app_category': (context) => AppCategory(),
        '/about_us': (context) => AboutUs(),
        '/privacy_policy': (context) => PrivacyPolicy(),
      },
      home: AppCategory(),
    );
  }
}


class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with SingleTickerProviderStateMixin{

  bool isClick=false;
  bool isVisible=false;
  var texts='not Click', iconsValue=Icons.keyboard_arrow_down;
  var typeId=1;
  onClick(){
    setState(() {
      if(isClick){
        iconsValue =Icons.clear;
        texts = 'not Clicked';
        isClick=false;
        isVisible=false;
        print('click  $texts');
      }else{
        iconsValue =Icons.keyboard_arrow_down;
        texts = ' Clicked';
        isClick=true;
        isVisible=true;
        print('clicked at');
      }
    });
  }


  late AnimationController animationController;

  @override
  void initState() {
    // TODO: implement initState
    animationController = AnimationController(vsync: this, duration: Duration(seconds: 20),
    );
    animationController.addListener(() {
      setState(() {

      });
    });

    //animationController.repeat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final percentage = animationController.value * 100;

    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xffFC9425),
          onPressed: () {  },
          child: Text('T',
            style: TextStyle(
            fontFamily: 'FredokaOne',
            fontSize: 40.0
          ),),
        ),
        body: Container(
          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.only(right: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 80.0),
                      child: Text(
                        'Topi'.toUpperCase(),
                        style: TextStyle(
                          fontSize: 24.0,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          color: Color(0xffFC9425),
                        ),
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            vertical: 0.0, horizontal: 20.0),
                        side: BorderSide(
                          color: Color(0xffFCCC44),
                          width: 0.5,
                        ),
                      ),
                      onPressed: () {},
                      child: Text(
                        'Premium',
                        style: TextStyle(
                          color: Color(0xffDC3843),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration:kBoxDecorate,
                margin:kTestMargin,
                child: DropdownButtonHideUnderline(
                  child: Padding(
                    padding: kTestPadding,
                    child: DropdownButton<String>(
                      value: '$typeId',
                      isExpanded: true,
                      icon: Icon(
                        iconsValue,
                        color: Colors.white,
                      ),
                      items: getDropDownTypeItem(),
                      dropdownColor: Color(0xffFC9425),
                      onChanged: (value) {
                        setState(() {
                          typeId = int.parse(value!);
                          isClick=true;
                        });
                      },
                    ),
                  ),
                ),
              ),
              Visibility(
                visible: isClick,
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 15,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: <Widget>[
                          Container(
                              decoration: BoxDecoration(
                                color: Color(0xffFC9425),
                                border: Border.all(color: Color(0xffFC9425)),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              margin: EdgeInsets.only(top: 4.0,right: 16.0,left: 16.0),
                              child: ListTile(
                                visualDensity: VisualDensity(vertical: -4),
                                leading: Text('List of songs category',style: TextStyle(color: Colors.white),),
                                onTap:() {
                                  setState(() {
                                    isClick=false;
                                    texts='not clicked';
                                  });
                                } ,
                              )
                          ),
                          Divider(height: 8,indent: 14,endIndent: 14,)
                        ],
                      );
                    }),
              ),
              Container(
                width: double.infinity,
                height: 50,
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: LiquidLinearProgressIndicator(
                  borderRadius: 12.0,
                  value: animationController.value,
                  valueColor: AlwaysStoppedAnimation(Color(0xffFC9425)),
                  center: Text('${percentage.toStringAsFixed(0)}%',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),),
                  direction: Axis.horizontal,
                  backgroundColor: Colors.grey.shade300,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<DropdownMenuItem<String>> getDropDownTypeItem() {
    List<DropdownMenuItem<String>> dropDown = [];
    for (int i = 0; i <12; i++) {
      var id = i;
      var text ='class_name';
      var newWidget = DropdownMenuItem(
        child: Text(
          '$text',
          style: TextStyle(fontSize: 18.0, color: Colors.white),
        ),
        value: '$id',
      );
      dropDown.add(newWidget);
    }
    return dropDown;
  }
}
