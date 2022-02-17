import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:topi/Gradient.dart';
import 'package:topi/OutlineBtn.dart';
import 'package:topi/constants.dart';

import 'NavigationDrawer.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final auth = FirebaseAuth.instance.currentUser;

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
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  key: UniqueKey(),
                  imageUrl: '${auth!.photoURL}',
                  imageBuilder: (context, imageProvider) => Container(
                      width: 120.0,
                      height: 120.0,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.contain))),
                  ),
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
                    RichText(                       textAlign: TextAlign.center,

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
                          //Navigator.pushNamed(context, '/premium_feature');
                        },
                      ),
                    ),
                    SizedBox(width: 6.0,),
                    Container(
                      height: 40,
                      child: OutlinedButton.icon(
                            style:OutlinedButton.styleFrom(
                              shape:RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.0)
                              ),
                              side: BorderSide(color: Colors.white70)
                            ),
                            onPressed: (){}, icon: FaIcon(
                          FontAwesomeIcons.bookmark,
                          color: Colors.white70,
                        ), label: Text(''))
                    ),
                  ],
                ),

              ),
              Container(
                margin: EdgeInsets.only(top: 8.0),
                child: TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/add_bio');
                  },
                  child: Text('Tap to add bio',style: TextStyle(color: Colors.white70,fontSize: 16.0),),),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
