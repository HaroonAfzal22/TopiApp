import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pay/pay.dart';
import 'package:topi/Gradient.dart';
import 'package:topi/NavigationDrawer.dart';
import 'package:topi/OutlineBtn.dart';
import 'package:topi/constants.dart';

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
                height: MediaQuery.of(context).size.height * 0.1,
                alignment: Alignment.center,
                child: Text(
                  'Subscription Plan',
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
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                    side: BorderSide(
                      width: 1,
                    )),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.15,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    gradient: LinearGradient(
                      colors: [
                        Color(0xff0cf268),
                        Color(0xffd0be22),
                        Color(0xff1c1fe0),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: Center(
                    child: ListTile(
                      title: Text(
                        'Silver Pack',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w700),
                      ),
                      subtitle: Text(
                        ' Ads free + Premium templates',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w700),
                      ),
                      trailing: Container(
                        // padding: const EdgeInsets.all(8.0),
                        child: UnicornOutlineButton(
                          strokeWidth: 1,
                          radius: 10,
                          gradient: LinearGradient(
                              colors: [Colors.cyan, Colors.deepOrangeAccent]),
                          child: Text(
                            'Details',
                            style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w700,
                                foreground: Paint()..shader = linearGradient),
                          ),
                          onPressed: () {
                            //show();
                            _settingModalBottomSheet(
                                context, '\$2.99', '\$16.99', '\$29.99');
                          },
                        ),
                      ),
                      /* Text('\$0.99',style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w700
                      ),),*/
                      leading: Icon(
                        FontAwesomeIcons.gift,
                        color: Colors.white,
                        size: 34,
                      ),
                    ),
                  ),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    side: BorderSide(
                      width: 1,
                    )),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.15,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xff85f20c),
                        Color(0xffec6b09),
                        Color(0xff1ca2e0),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Center(
                    child: ListTile(
                      title: Text(
                        'Gold Pack',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w700),
                      ),
                      subtitle: Text(
                        'Without watermark + Premium Music',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w700),
                      ),
                      trailing: Container(
                        // padding: const EdgeInsets.all(8.0),

                        child: UnicornOutlineButton(
                          strokeWidth: 1,
                          radius: 10,
                          gradient: LinearGradient(
                              colors: [Colors.cyan, Colors.deepOrangeAccent]),
                          child: Text(
                            'Details',
                            style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w700,
                                foreground: Paint()..shader = linearGradient),
                          ),
                          onPressed: () {},
                        ),
                      ),
                      /* Text('\$0.99',style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w700
                      ),),*/
                      leading: Icon(
                        FontAwesomeIcons.gift,
                        color: Colors.white,
                        size: 34,
                      ),
                    ),
                  ),
                ),
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    side: BorderSide(
                      width: 1,
                    )),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.15,
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
                      title: Text(
                        'Platinum Pack',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w700),
                      ),
                      subtitle: Text(
                        'Without watermark + Premium music + Ads free',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w700),
                      ),
                      trailing: Container(
                        // padding: const EdgeInsets.all(8.0),

                        child: UnicornOutlineButton(
                          strokeWidth: 1,
                          radius: 10,
                          gradient: LinearGradient(
                              colors: [Colors.cyan, Colors.deepOrangeAccent]),
                          child: Text(
                            'Details',
                            style: TextStyle(
                                fontSize: 12.0,
                                fontWeight: FontWeight.w700,
                                foreground: Paint()..shader = linearGradient),
                          ),
                          onPressed: () {},
                        ),
                      ),
                      /*Text('\$1.99',style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w700
                      ),),*/
                      leading: Icon(
                        FontAwesomeIcons.gift,
                        color: Colors.white,
                        size: 34,
                      ),
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
  final _amount=<PaymentItem>[];

  //for modal bottom sheet to show children
  void _settingModalBottomSheet(context, monthly, halfly, yearly) {
    _amount.add(PaymentItem(amount: '$monthly',label: 'Monthly',status: PaymentItemStatus.final_price));
    showModalBottomSheet(
      backgroundColor: Color(0xffD7CCC8),
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25))),
      builder: (BuildContext bc) => Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(top: 9),
                  child: Divider(
                    thickness: 1.0,
                    height: 0.5,
                    indent: 10,
                    endIndent: 10,
                    color: Colors.grey.shade300,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 16.0, bottom: 8.0),
                child: Text(
                  'Subscription Category',
                  style: TextStyle(
                      //color: Color(int.parse('newColor'),),
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(top: 9),
                  child: Divider(
                    thickness: 1.0,
                    height: 0.5,
                    indent: 10,
                    endIndent: 10,
                    color: Colors.grey.shade300,
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Card(
                elevation: 8.0,
                margin: EdgeInsets.symmetric(vertical: 8.0),
                //   color: Color(int.parse('newColor')),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    gradient: LinearGradient(
                      colors: [
                        Color(0xff5454f6),
                        Color(0xff09c5ec),
                        Color(0xff1ce046),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  height: 120,
                  width: 110,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('1-Month',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22.0,
                              fontWeight: FontWeight.bold)),
                      Text(
                        '$monthly',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 8.0,
                margin: EdgeInsets.symmetric(vertical: 8.0),
                //   color: Color(int.parse('newColor')),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xff85f20c),
                        Color(0xffec6b09),
                        Color(0xff1ca2e0),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  height: 120,
                  width: 110,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('6-Month',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22.0,
                              fontWeight: FontWeight.bold)),
                      Text(
                        '$halfly',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 8.0,
                margin: EdgeInsets.symmetric(vertical: 8.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    gradient: LinearGradient(
                      colors: [
                        Color(0xff0cf268),
                        Color(0xffd0be22),
                        Color(0xff1c1fe0),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  height: 120,
                  width: 110,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text('1-Year',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 22.0,
                              fontWeight: FontWeight.bold)),
                      Text(
                        '$yearly',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          GooglePayButton(
            width: MediaQuery.of(context).size.width,
            height: 50,
            paymentConfigurationAsset: 'gpay.json',
            paymentItems: _amount,
            style: GooglePayButtonStyle.black,
            type: GooglePayButtonType.subscribe,
            margin: const EdgeInsets.only(top: 15.0,right: 20,left: 20),
            onPaymentResult: (onGooglePayResult){
              print(onGooglePayResult);
              },
            loadingIndicator: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
         /* InkWell(
            child: AnimatedContainer(
              duration:  const Duration(milliseconds: 200,),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(20),
                boxShadow:
                  [
                  const BoxShadow(
                    color: Colors.grey,
                    offset: Offset(4, 4),
                    blurRadius: 15,
                    spreadRadius: 1,
                  ),
                  const BoxShadow(
                    color: Colors.white,
                    offset: Offset(-4, -4),
                    blurRadius: 15,
                    spreadRadius: 1,
                  ),
                ]
              ),
              child: Row(
                children: [
                  Text('Subscribe with'),
                  Icon(
                    FontAwesomeIcons.googlePay,
                    size: 28.0,
                  )
                ],
              ),
            ),
          ),*/
          /*  GridView.builder(
            padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
            shrinkWrap: true,
            itemBuilder: (context, index) => InkWell(
              child: Card(
                margin: EdgeInsets.symmetric(horizontal: 4.0, vertical: 8.0),
             //   color: Color(int.parse('newColor')),
                child: ListTile(
                  title: Text('name',
                      style: TextStyle(color: Colors.orange)),
                  subtitle: Text(
                    '$monthly',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              onTap: () async {
                Navigator.of(context).pop();
                toastShow('name selected');
              },
            ),
            itemCount: 3, gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          ),*/
        ],
      ),
    );
  }

  show() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0)), //this right here
            child: Container(
              height: 200,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'What do you want to remember?'),
                    ),
                    SizedBox(
                      width: 320.0,
                      child: ElevatedButton(
                        style:ElevatedButton.styleFrom(primary: const Color(0xFF1BC0C5),),
                        onPressed: () {},
                        child: Text(
                          "Save",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}
