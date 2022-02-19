import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:topi/Gradient.dart';
import 'package:topi/Shared_Pref.dart';

class AddBio extends StatefulWidget {
  const AddBio({Key? key}) : super(key: key);

  @override
  State<AddBio> createState() => _AddBioState();
}

class _AddBioState extends State<AddBio> {
  String? value;
  NativeAd? myNative;
  bool isAdLoaded = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myNative = NativeAd(
      adUnitId: SharedPref.getNativeAd()??'',
      factoryId: 'listTile',
      request: AdRequest(),
      listener: NativeAdListener(
        // Called when an ad is successfully received.
        onAdLoaded: (Ad ad) => {
          setState(() {
            isAdLoaded = true;
          }),
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          ad.dispose();
        },
      ),
    );
    setState(() {
      myNative!.load();
    });
  }
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        elevation: 0.0,
        leading: TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(
            'Cancel',
            style: TextStyle(color: Colors.white70),
          ),
        ),
        title: Image.asset(
          'assets/topi.png',
          fit: BoxFit.contain,
          width: 80,
          height: 80,
        ),
        centerTitle: true,
        actions: <Widget>[
          TextButton(
            onPressed: () {
              if(args.containsValue('edit_profile')){
                Navigator.of(context).pop(value);
              }else{
                Navigator.of(context).pop(value);
              }
            },
            child: Text(
              'Save',
              style: TextStyle(color: Colors.white70),
            ),
          ), //IconButton
        ],
      ),
      backgroundColor: Colors.black87,
      body: SafeArea(
          child: BackgroundGradient(
              childView: Column(
        children: [
          Container(
            margin: EdgeInsets.all(8.0),
            child: TextFormField(
              autofocus: true,
              autocorrect: true,
              onChanged: (String? values) {
                setState(() {
                  value = values;
                });
              },
              buildCounter: (_,
                      {required currentLength,
                      maxLength,
                      required isFocused}) =>
                  Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        currentLength.toString() + "/" + maxLength.toString(),
                        style: TextStyle(color: Colors.white70),
                      )),
              style: TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                focusColor: Colors.white70,
                floatingLabelStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.white70,
                ),
                contentPadding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 10.0),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                  borderSide: const BorderSide(color: Colors.white, width: 2.0),
                ),
                labelText: "Add bio",
              ),
              maxLength: 80,
              maxLines: 2,
            ),
          ),
          isAdLoaded
              ? Container(
            alignment: Alignment.bottomCenter,
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: AdWidget(
              ad: myNative!,
            ),
          )
              : Text('loading...')
        ],
      ))),
    );
  }
}
