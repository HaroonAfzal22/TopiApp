import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:image_picker/image_picker.dart';
import 'package:topi/Gradient.dart';
import 'package:topi/Shared_Pref.dart';
import 'package:topi/constants.dart';

import 'NavigationDrawer.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile>  with SingleTickerProviderStateMixin{
  final auth = FirebaseAuth.instance.currentUser;
  File? imagePath=File(SharedPref.getProfileImage());
  String name='Name',userName='Username',bio='Add a bio to your profile';
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
        actions: <Widget>[
          TextButton(
            onPressed: () {
                toastShow('Profile Updated...');
                Navigator.pop(context);
            },
            child: Text(
              'Save',
              style: TextStyle(color: Colors.white70),
            ),
          ), //IconButton
        ],
      ),
      drawer: Drawers(),
      body: SafeArea(
        child: BackgroundGradient(
          childView: ListView(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 24.0),
                    child:imagePath==null? CachedNetworkImage(
                      fit: BoxFit.cover,
                      key: UniqueKey(),
                      imageUrl: '${auth!.photoURL}',
                      imageBuilder: (context, imageProvider) => Container(
                          width: 120.0,
                          height: 120.0,
                          foregroundDecoration: BoxDecoration(
                            color: Colors.white70.withOpacity(0.4),
                            shape: BoxShape.circle,
                          ),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.contain))),
                    ):
                     Container(
                       foregroundDecoration: BoxDecoration(
                         color: Colors.white70.withOpacity(0.4),
                         shape: BoxShape.circle,
                       ),
                       child: CircleAvatar(
                         radius: 60,
                         backgroundColor: Colors.white70,
                         backgroundImage: FileImage(imagePath!,),
                       ),
                     ) ,
                  ),
                  Positioned(
                    left: MediaQuery.of(context).size.width * 0.44,
                    top: MediaQuery.of(context).size.width * 0.16,
                    child: IconButton(
                      color: Colors.white70,
                      icon: FaIcon(
                        FontAwesomeIcons.camera,
                        color: Colors.white70,
                      ),
                      onPressed: () {
                        _settingModalBottomSheet(context);
                      },
                    ),
                  )
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 16.0),
                child: Text(
                  'Change Photo',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 32.0,left: 16.0),
                child: Text(
                  'About you',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                      fontWeight: FontWeight.w500),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 32.0,left: 16.0,right: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Text('Name',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,
                      fontSize: 18.0),),
                    ),
                    Container(
                      child: TextButton.icon(
                        style: TextButton.styleFrom(padding: EdgeInsets.zero,),
                          onPressed: ()async{
                          var result = await Navigator.pushNamed(context, '/add_name');
                          setState(() {
                          if(result!='null'){name=result.toString();}
                          });
                          }, icon:Text(name,style: TextStyle(color: Colors.white70,fontWeight: FontWeight.w600,
                          fontSize: 14.0),) ,
                          label: Icon(CupertinoIcons.forward,color: Colors.white70,)),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 8.0,left: 16.0,right: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Text('Username',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,
                      fontSize: 18.0),),
                    ),
                    Container(
                      child: TextButton.icon(
                        style: TextButton.styleFrom(padding: EdgeInsets.zero,),
                          onPressed: ()async{
                          var result = await Navigator.pushNamed(context, '/user_name');
                          setState(() {
                            if(result!='null'){
                              userName=result.toString();}
                          });
                          }, icon:Text(userName,style: TextStyle(color: Colors.white70,fontWeight: FontWeight.w600,
                          fontSize: 14.0),) ,
                          label: Icon(CupertinoIcons.forward,color: Colors.white70,)),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.only(left: 16.0,right: 10),
                child: TextButton.icon(
                    style: TextButton.styleFrom(padding: EdgeInsets.zero,),
                    onPressed: (){
                      Clipboard.setData(ClipboardData(text:'www.topi.ai/@$userName' ));
                      snackShow(context, 'Link Copied');
                    }, icon:Text('www.topi.ai/@$userName',style: TextStyle(color: Colors.white70,fontWeight: FontWeight.w600,
                    fontSize: 14.0),) ,
                    label: Icon(CupertinoIcons.square_on_square,color: Colors.white70,size: 16.0,)),
              ),
              Container(
                margin: EdgeInsets.only(top: 8.0,left: 16.0,right: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Text('Bio',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,
                          fontSize: 18.0),),
                    ),
                    Container(
                      child: TextButton.icon(
                          style: TextButton.styleFrom(padding: EdgeInsets.zero,),
                          onPressed: ()async{
                            var result = await Navigator.pushNamed(context, '/add_bio',arguments: {
                              'class':'edit_profile'
                            });
                            setState(() {
                              if(result!=null){
                                bio=result.toString();}
                            });
                          }, icon:Text(bio,style: TextStyle(color: Colors.white70,fontWeight: FontWeight.w600,
                          fontSize: 14.0),) ,
                          label: Icon(CupertinoIcons.forward,color: Colors.white70,)),
                    ),
                  ],
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
          ),
        ),
      ),
    );
  }

  //for modal bottom sheet to show children
  void _settingModalBottomSheet(context) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(12))),
      builder: (BuildContext bc) => SingleChildScrollView(
        child: Column(
          children: [
            Container(
              child: TextButton(
                onPressed: () async{
                  Navigator.pop(context);
                  final pickedImage = await ImagePicker().pickImage(source: ImageSource.camera);
                  setState(() {
                    imagePath = (pickedImage != null ? File(pickedImage.path) : null)!;
                    SharedPref.setProfileImage(imagePath!);
                  });
                },
                child: Text(
                  'Take photo',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Container(
              child: Divider(
                thickness: 0.5,
                height: 0.5,
                indent: 10,
                endIndent: 10,
                color: Colors.grey.shade200,
              ),
            ),
            Container(
              child: TextButton(
                onPressed: () async{
                  Navigator.pop(context);
                  final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
                  setState(() {
                    imagePath = (pickedImage != null ? File(pickedImage.path) : null)!;
                    SharedPref.setProfileImage(imagePath!);

                  });

                },
                child: Text(
                  'Select from Gallery',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Container(
              child: Divider(
                thickness: 0.5,
                height: 0.5,
                indent: 10,
                endIndent: 10,
                color: Colors.grey.shade200,
              ),
            ),
            Container(
              child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  imagePath == null
                      ? Navigator.pushNamed(context, '/view_photo',
                          arguments: {'image': auth!.photoURL.toString()})
                      : Navigator.pushNamed(context, '/view_photo',
                          arguments: {'image': File(imagePath!.path)});
                },
                child: Text(
                  'View photo',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 4),
              child: Divider(
                thickness: 8.0,
                height: 0.5,
                color: Colors.grey.shade200,
              ),
            ),
            Container(
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Cancel',
                  style: TextStyle(
                      color: Colors.black38,
                      fontSize: 16.0,
                      fontWeight: FontWeight.normal),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
