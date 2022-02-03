import 'dart:io';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:new_version/new_version.dart';
import 'package:topi/Community.dart';
import 'package:topi/HttpRequest.dart';
import 'package:topi/Notifications.dart';
import 'package:topi/Shared_Pref.dart';
import 'package:topi/SongsList.dart';
import 'package:topi/constants.dart';
import 'NavigationDrawer.dart';

class AppCategory extends StatefulWidget {
  @override
  _AppCategoryState createState() => _AppCategoryState();
}

class _AppCategoryState extends State<AppCategory> {
  var log = 'assets/background.png';
  bool isLoading = false;
  int _page = 1;
  GlobalKey<CurvedNavigationBarState> _bottomsKey = GlobalKey();
  FirebaseDynamicLinks dynamicLinks= FirebaseDynamicLinks.instance;

  final resultScreens = [
    Community(),
    SongsList(),
    Notifications(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      getAds();
    //  initDynamicLinks();
    });
     _checkVersion();
  }
  void initDynamicLinks()async{
    dynamicLinks.onLink.listen((linkData) {
      final Uri uri = linkData.link;
      final query= uri.queryParameters;
     if(query.isNotEmpty){
       Navigator.pushNamed(context, '/community');
     }
    });


  }

  void getAds() async {
    HttpRequest request = HttpRequest();
    var result = await request.getAds(context);
    if (result == null) {
      toastShow('Data not Found');
    } else if (result.toString().contains('Error')) {
      toastShow('$result');
    } else {
      await SharedPref.setBannerAd(result['banner_id']);
      await SharedPref.setNativeAd(result['native_id']);
      await SharedPref.setInterstitialAd(result['inter_id']);
      await SharedPref.setRewardedAd(result['reward_id']);
    }
  }
  _checkVersion() async {
    final newVersion = NewVersion(androidId: "com.topi.ai");
    final status = await newVersion.getVersionStatus();
    await SharedPref.setAppVersion(status!.storeVersion);

    if (!status.storeVersion.contains(status.localVersion)) {
      newVersion.showUpdateDialog(
        context: context,
        versionStatus: status,
        dialogTitle: 'Update Available!!!',
        dialogText:
            'A new Version of Topi.Ai is available! Which Version is ${status.storeVersion} but your Version is ${status.localVersion}.\n\n Would you Like to update it now?',
        updateButtonText: 'Update Now',
      );
    }
  }

  Future<bool> _onWillPop() async {
    if (Platform.isIOS) {
      return await showDialog(
              context: context,
              builder: (context) => CupertinoAlertDialog(
                    title: Text('Close Application'),
                    content: Text('Do you want to exit an App?'),
                    actions: <Widget>[
                      CupertinoDialogAction(
                        child: Text('No'),
                        onPressed: () => Navigator.of(context).pop(false),
                      ),
                      CupertinoDialogAction(
                          child: Text('Yes'),
                          onPressed: () {
                            Navigator.of(context).pop(true);
                            //db.close();
                          }),
                    ],
                  )) ??
          false;
    } else {
      return (await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Close Application'),
              content: Text('Do you want to exit an App?'),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text('No'),
                ),
                TextButton(
                  onPressed: () async {
                    Navigator.of(context).pop(true);
                    //  await db.close();
                  },
                  child: Text('Yes'),
                ),
              ],
            ),
          )) ??
          false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? Container(
            color: Colors.white,
            child: Center(
              child: spinkit, //declared in constants class
            ),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black87,
              systemOverlayStyle: SystemUiOverlayStyle.light,
              elevation: 0.0,
              title: Image.asset(
                'assets/topi.png',
                fit: BoxFit.contain,
                width: 80,
                height: 80,
              ),
              centerTitle: true,
            ),
            drawer: Drawers(),
            backgroundColor: Colors.black87,
            extendBody: true,
            bottomNavigationBar: CurvedNavigationBar(
              index: _page,
              color: Colors.deepOrange,
              backgroundColor: Colors.transparent,
              key: _bottomsKey,
              height: 50,
              items: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Icon(
                      FontAwesomeIcons.solidFileVideo,
                      color: Colors.white,
                      size: 25,
                    ),
                    Visibility(
                      visible: _page == 0 ? false : true,
                      child: Text(
                        'Community',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(CupertinoIcons.music_note_2,
                        color: Colors.white, size: 25),
                    Visibility(
                        visible: _page == 1 ? false : true,
                        child: Text(
                          'Songs',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(CupertinoIcons.bell_solid,
                        color: Colors.white, size: 25),
                    Visibility(
                        visible: _page == 2 ? false : true,
                        child: Text(
                          'Notification',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )),
                  ],
                ),
              ],
              onTap: (index) {
                setState(() {
                  _page = index;
                });
              },
            ),
            body: WillPopScope(
                onWillPop: _onWillPop, child: resultScreens[_page]),
          );
  }

  @override
  void dispose() {
    _page = 1;
    super.dispose();
  }
}
