import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:topi/Gradient.dart';
import 'package:topi/OutlineBtn.dart';
import 'package:topi/Shared_Pref.dart';
import 'package:topi/constants.dart';


class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final auth = FirebaseAuth.instance.currentUser;
  String value='Tap to add bio';
  bool isLoading=false;
  File? imagePath = File(SharedPref.getProfileImage());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* appBar: AppBar(
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
      drawer: Drawers(),*/
      backgroundColor: Colors.black87,
      extendBody: true,
      body: SafeArea(
        child: BackgroundGradient(
          childView: ListView(
            children: [
              Container(
                  margin: EdgeInsets.only(top: 12.0),
                child:imagePath==null? CachedNetworkImage(
                  fit: BoxFit.cover,
                  key: UniqueKey(),
                  imageUrl: '${auth!.photoURL}',
                  imageBuilder: (context, imageProvider) => Container(
                      width: 120.0,
                      height: 120.0,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: imageProvider, fit: BoxFit.contain))),
                ):
                Container(
                  foregroundDecoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: CircleAvatar(
                    backgroundColor: Colors.deepOrange,
                    radius: 60,
                    child: CircleAvatar(
                      radius: 60-1,
                      backgroundImage: Image.file(imagePath!,fit: BoxFit.contain,).image,
                    ),
                  ),
                ) ,
              ),
              Container(
                margin: EdgeInsets.only(top: 8.0),
                child: Text(
                  '${auth!.displayName}',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.white,
                  fontSize: 20.0),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 12.0,right: 30,left: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                     RichText(
                       textAlign: TextAlign.center,
                  text: TextSpan(
                      text: '0 \n\t',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                      ),
                      children: [
                    TextSpan(
                      text: 'Following',
                      style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0,color: Colors.white70
                  ),
                    ),
                  ]),
                ),
                    RichText(                       textAlign: TextAlign.center,

                      text: TextSpan(
                          text: '0 \n\t',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),children: [
                        TextSpan(
                          text: 'Followers',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0,color: Colors.white70
                          ),
                        ),
                      ]),
                    ),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          text: '0 \n\t',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                          children: [
                        TextSpan(
                          text: 'Like',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12.0,color: Colors.white70
                          ),
                        ),
                      ]),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 24.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width:MediaQuery.of(context).size.width*0.4,
                      height:40,
                      child: UnicornOutlineButton(
                        strokeWidth: 0.5,
                        radius: 4,
                        gradient: LinearGradient(colors: [
                          Colors.white70,
                          Colors.white70
                        ]),
                        child: Text(
                          'Edit Profile',
                          style: TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w700,
                              foreground: Paint()
                                ..shader = linearGradient),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, '/edit_profile',);
                        },
                      ),
                    ),
                    SizedBox(width: 6.0,),
                    Container(
                      height: 40,
                      child:OutlinedButton(
                        style:OutlinedButton.styleFrom(
                          shape:RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4.0)
                          ),
                          side: BorderSide(color: Colors.white70,width: 0.5)
                      ),onPressed: () {  }, child: FaIcon(
                        FontAwesomeIcons.bookmark,
                        color: Colors.white70,
                      ),),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 8.0),
                child: TextButton(
                  onPressed: ()async {
                 var result=  await Navigator.pushNamed(context, '/add_bio');
                 if(result!=null) {
                   setState(() {
                     value = result.toString();
                   });
                   await SharedPref.setBio(value);
                 }
                  },
                  child: Text(SharedPref.getBio()??value,style: TextStyle(color: Colors.white70,fontSize: 16.0),),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
