import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:topi/Gradient.dart';
import 'package:topi/NavigationDrawer.dart';

class PremiumFeature extends StatefulWidget {
  const PremiumFeature({Key? key}) : super(key: key);

  @override
  _PremiumFeatureState createState() => _PremiumFeatureState();
}

class _PremiumFeatureState extends State<PremiumFeature> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: SafeArea(
        child: BackgroundGradient(
          childView: ListView(
            children: [
              Container(
                height: MediaQuery.of(context).size.height*0.1,
                alignment: Alignment.center,
                child: Text(
                  'Monthly Basis Subscription ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.orangeAccent,
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10),
                        ),
                    side: BorderSide(width: 1,)),
                child: Container(
                  height: MediaQuery.of(context).size.height*0.15,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    gradient: LinearGradient(
                      colors: [
                        Color(0xff0cf22a),
                        Color(0xffdeb15d),
                        Color(0xffe0711c),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Center(
                    child: ListTile(
                      title: Text('Silver Pack',textAlign: TextAlign.center,style: TextStyle(
                      color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w700
                      ),),
                      subtitle: Text(' Ads free ',textAlign: TextAlign.center,style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w700
                      ),),
                      trailing: Text('\$0.99',style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w700
                      ),),
                      leading:Icon(FontAwesomeIcons.gift,color: Colors.white,size: 34,),
                    ),
                  ),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    side: BorderSide(width: 1,)),
                child: Container(
                  height: MediaQuery.of(context).size.height*0.15,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xff85f20c),
                        Color(0xffc5ec09),
                        Color(0xffd8e01c),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10)),

                  ),
                  child: Center(
                    child: ListTile(
                      title: Text('Gold Pack',textAlign: TextAlign.center,style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w700
                      ),),
                      subtitle: Text('Without watermark + Premium Music',textAlign: TextAlign.center,style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w700
                      ),),
                      trailing: Text('\$0.99',style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w700
                      ),),
                      leading:Icon(FontAwesomeIcons.gift,color: Colors.white,size: 34,),
                    ),
                  ),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    side: BorderSide(width: 1,)),
                child: Container(
                  height: MediaQuery.of(context).size.height*0.15,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xff5454f6),
                        Color(0xff09c5ec),
                        Color(0xff1ce046),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Center(
                    child: ListTile(
                      title: Text('Platinum Pack',textAlign: TextAlign.center,style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700
                      ),),
                      subtitle: Text('Without watermark + Premium music + Ads free',textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w700
                        ),),
                      trailing: Text('\$1.99',style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w700
                      ),),
                      leading: Icon(FontAwesomeIcons.gift,color: Colors.white,size: 34,),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _onWillPop() async {
    if (Platform.isIOS) {
      return await showDialog(
          context: context,
          builder: (context) => CupertinoAlertDialog(
            title: Text('App Subscription'),
            content: Text('Choose for App Subscription'),
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

}
