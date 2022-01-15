import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:share_plus/share_plus.dart';
import 'package:topi/Shared_Pref.dart';

class Drawers extends StatefulWidget {

  @override
  _DrawersState createState() => _DrawersState();
}
enum Availability { loading, available, unavailable }
// Navigation Drawer used to set data
class _DrawersState extends State<Drawers> {
  String _appStoreId = '';
  String _microsoftStoreId = '';
  final InAppReview _inAppReview = InAppReview.instance;
  Availability _availability = Availability.loading;

  // to update fcm token and get new color from api

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      try {
        final isAvailable = await _inAppReview.isAvailable();
        setState(() {
          _availability = isAvailable && !Platform.isAndroid
              ? Availability.available
              : Availability.unavailable;
        });
      } catch (e) {
        setState(() => _availability = Availability.unavailable);
      }
    });
}
  Future<void> _requestReview() => _inAppReview.requestReview();

  Future<void> _openStoreListing() => _inAppReview.openStoreListing(
    appStoreId: _appStoreId,
    microsoftStoreId: _microsoftStoreId,
  );
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Color(0xff2c3e50),
        child: ListView(
          children: [
            DrawerHeader(
              margin: EdgeInsets.zero,
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.transparent
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Image.asset('assets/topi.png',width: MediaQuery.of(context).size.width/2,height: MediaQuery.of(context).size.width/5,),
                    ),
                  ],
                )
            ),
            Divider(
              thickness: 0.5,
              height: 0.5,
              color: Colors.white,
            ),
            //listTiles class use for design drawer items
            listTiles(
                icon: CupertinoIcons.lock_shield_fill,
                onClick: () {
                  Navigator.pop(context);
                 // Navigator.pushNamed(context, '/google_ads');
                },
                text: 'Privacy Policy'),
            listTiles(
                icon:FontAwesomeIcons.solidShareSquare,
                onClick: (){
                  Navigator.pop(context);
                  _shareLink();
                },
                text: 'Share'),
            listTiles(
                icon: Icons.star,
                onClick: () {
                  Navigator.pop(context);
                  _openStoreListing();
                },
                text: 'Rate us'),
            listTiles(
                icon: Icons.android_sharp,
                onClick:  () {
                  Navigator.pop(context);
                },
                text: 'App Version : ${SharedPref.getAppVersion()}'),
          ],
        ),
      ),
    );
  }

}

void _shareLink() {
  Share.share('https://play.google.com/store/apps/details?id=com.topi.ai&hl=en&gl=US');
  
}
//${SharedPref.getAppVersion()}
Column listTiles(
    {required IconData icon, required String text, required var onClick}) {
  return Column(
    children: [
      ListTile(
        minLeadingWidth: 8.0,
        leading: Icon(
          icon,
          color: Color(0xffFCCC44),
        ),
        title: Text(
          text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0
          ),
        ),
        onTap: onClick,
      ),
      /*Divider(
        thickness: 0.5,
        height: 0.5,
        indent: 18,
        endIndent: 20,
        color: Colors.grey.shade300,
      ),*/
    ],
  );
}
