import 'dart:io';

import 'package:better_player/better_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:topi/ChewiePlayer.dart';
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
  String value = 'Tap to add bio';
  bool isLoading = false;
  File? imagePath = File(SharedPref.getProfileImage());
  List<BetterPlayerListVideoPlayerController>? controller = [];
  int _selectTab=0;
  List result=[
  /*  "https://cdn.pixabay.com/photo/2021/11/03/12/28/trees-6765630_960_720.jpg",
    "https://cdn.pixabay.com/photo/2022/02/15/07/27/travel-7014427_960_720.jpg",
    "https://cdn.pixabay.com/photo/2020/12/02/10/30/hike-5796976__340.jpg",
    "https://cdn.pixabay.com/photo/2017/05/09/03/46/alberta-2297204__340.jpg",
    "https://cdn.pixabay.com/photo/2017/10/10/07/48/hills-2836301__340.jpg",
    "https://cdn.pixabay.com/photo/2017/06/24/02/56/art-2436545__340.jpg",
    "https://cdn.pixabay.com/photo/2015/02/04/08/03/baby-623417__340.jpg",
   "https://cdn.pixabay.com/photo/2016/11/29/09/19/baby-1868683__340.jpg",*/
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    for (int i = 0; i < result.length; i++) {
      controller?.insert(i, BetterPlayerListVideoPlayerController());
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
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
          bottom: false,
          child: BackgroundGradient(
            childView: ListView(
              shrinkWrap: true,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 12.0),
                  child: imagePath == null
                      ? CachedNetworkImage(
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
                        )
                      : Container(
                          foregroundDecoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: CircleAvatar(
                            backgroundColor: Colors.deepOrange,
                            radius: 60,
                            child: CircleAvatar(
                              radius: 60 - 1,
                              backgroundImage: Image.file(
                                imagePath!,
                                fit: BoxFit.contain,
                              ).image,
                            ),
                          ),
                        ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 8.0),
                  child: Text(
                    '${auth!.displayName}',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 12.0, right: 30, left: 30),
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
                                    fontSize: 12.0,
                                    color: Colors.white70),
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
                                text: 'Followers',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.0,
                                    color: Colors.white70),
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
                                    fontSize: 12.0,
                                    color: Colors.white70),
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
                        width: MediaQuery.of(context).size.width * 0.4,
                        height: 40,
                        child: UnicornOutlineButton(
                          strokeWidth: 0.5,
                          radius: 4,
                          gradient: LinearGradient(
                              colors: [Colors.white70, Colors.white70]),
                          child: Text(
                            'Edit Profile',
                            style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w700,
                                foreground: Paint()..shader = linearGradient),
                          ),
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              '/edit_profile',
                            );
                          },
                        ),
                      ),
                      SizedBox(
                        width: 6.0,
                      ),
                      Container(
                        height: 40,
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(4.0)),
                              side: BorderSide(
                                  color: Colors.white70, width: 0.5)),
                          onPressed: () {},
                          child: FaIcon(
                            FontAwesomeIcons.bookmark,
                            color: Colors.white70,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 8.0),
                  child: TextButton(
                    onPressed: () async {
                      var result =
                          await Navigator.pushNamed(context, '/add_bio');
                      if (result != null) {
                        setState(() {
                          value = result.toString();
                        });
                        await SharedPref.setBio(value);
                      }
                    },
                    child: Text(
                      SharedPref.getBio() ?? value,
                      style: TextStyle(color: Colors.white70, fontSize: 16.0),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border(top: BorderSide(color: Colors.white70,width: 0.5),bottom: BorderSide(color: Colors.white70,width: 0.5))
                  ),
                  child: TabBar(
                    physics: AlwaysScrollableScrollPhysics(),
                    indicator: UnderlineTabIndicator(
                        borderSide: BorderSide(width: 2.0,color: Colors.deepOrange,),
                        insets: EdgeInsets.symmetric(horizontal:40.0)
                    ),
                    tabs: [
                      Tab(icon: Icon(CupertinoIcons.rectangle_grid_3x2)),
                      Tab(icon: Icon(CupertinoIcons.heart_slash)),
                      Tab(icon: Icon(CupertinoIcons.lock)),
                    ],
                    onTap: (index){
                      setState(() {
                        _selectTab=index;
                      });
                    },

                  ),
                ),
                Container(
                  child: Builder(builder: (_){
                    if (_selectTab == 0) {
                      return result.isNotEmpty ?
                      Container(
                        child:GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                          itemBuilder: (context,index){
                            return  Container(
                              child:Stack(
                                fit: StackFit.expand,
                                children: [
                                  CachedNetworkImage(
                                    fit: BoxFit.fill,
                                    imageUrl: "${result[index]}",
                                    placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                                    errorWidget: (context, url, error) => Icon(Icons.error),
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(4.0),
                                    child: Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Icon(CupertinoIcons.play_arrow,color: Colors.white70,size: 16.0,),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 21.0,bottom: 4.0),
                                    child: Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Text('50k',style: TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.white70
                                      ), ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },itemCount: result.length,) ,
                      ):
                      Container(
                        margin: EdgeInsets.only(top: 30.0),
                        child: Column(
                          children: [
                            Container(
                              child: Text('Upload your first video',style: TextStyle(
                                  fontSize: 17.0,color: Colors.white,fontWeight: FontWeight.w600
                              ),),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 36.0,vertical: 8.0),

                              child: Text('Upload video with different sound effects \n'
                                  'and much more which will appear on your profile',
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.clip,
                                style: TextStyle(
                                  fontSize: 12.0,color: Colors.white70,fontWeight: FontWeight.w600
                              ),),
                            ),
                            Container(
                              child: TextButton(
                                onPressed: () {  },
                              child: Text('Upload video',style: TextStyle(
                                  fontSize: 15.0,color: Colors.redAccent,fontWeight: FontWeight.w600
                              ),),),
                            ),
                          ],
                        ),
                      );//1st custom tabBarView
                    } else if (_selectTab == 1) {
                      return   Container(
                        child:GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                          itemBuilder: (context,index){
                            return  Container(
                              child:Stack(
                                fit: StackFit.expand,
                                children: [
                                  CachedNetworkImage(
                                    fit: BoxFit.fill,
                                    imageUrl: "${result[index]}",
                                    placeholder: (context, url) => CircularProgressIndicator(),
                                    errorWidget: (context, url, error) => Icon(Icons.error),
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(4.0),
                                    child: Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Icon(CupertinoIcons.play_arrow,color: Colors.white70,size: 16.0,),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 21.0,bottom: 4.0),
                                    child: Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Text('50k',style: TextStyle(
                                          fontSize: 13.0,
                                          color: Colors.white70
                                      ), ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },itemCount: result.length,) ,
                      );//1st custom tabBarView
                    } else {
                      return   Container(
                        child:GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                          itemBuilder: (context,index){
                            return  Container(
                              child:Stack(
                                fit: StackFit.expand,
                                children: [
                                  CachedNetworkImage(
                                    fit: BoxFit.fill,

                                    imageUrl: "${result[index]}",
                                    placeholder: (context, url) => CircularProgressIndicator(),
                                    errorWidget: (context, url, error) => Icon(Icons.error),
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(4.0),
                                    child: Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Icon(CupertinoIcons.play_arrow,color: Colors.white70,size: 16.0,),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.all(4.0),
                                    child: Align(
                                      alignment: Alignment.bottomRight,
                                      child: Icon(CupertinoIcons.lock,color: Colors.white70,size: 16.0,),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 21.0,bottom: 4.0),
                                    child: Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Text('50k',style: TextStyle(
                                          fontSize: 13.0,
                                          color: Colors.white70
                                      ), ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },itemCount: result.length,) ,
                      );//1st custom tabBarView
                    }
                  }),
                )
             /*   Container(
                  height:46*result.length.toDouble(),
                  child: TabBarView(
                    children: [
                     Container(
                       child:GridView.builder(
                         physics: NeverScrollableScrollPhysics(),
                         shrinkWrap: true,
                           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                           itemBuilder: (context,index){
                             return  Container(
                               child: BetterPlayerListVideoPlayer(
                                 BetterPlayerDataSource(
                                     BetterPlayerDataSourceType.network,
                                     '${result[index]}'),
                                 playFraction: 0.8,
                                 betterPlayerListVideoPlayerController:
                                 controller![index],
                                 configuration: BetterPlayerConfiguration(
                                   expandToFill: true,
                                   autoDispose: false,
                                   aspectRatio: 1.0,
                                   autoPlay: false,
                                   controlsConfiguration:
                                   BetterPlayerControlsConfiguration(
                                       enableMute: false,
                                       enableOverflowMenu: false,
                                       enablePlayPause: false,
                                       enableFullscreen: false,
                                       enableSkips: false,
                                       showControlsOnInitialize: false,
                                       enableProgressText: false,
                                       playIcon:
                                       CupertinoIcons.play_arrow_solid,
                                       controlBarColor: Colors.transparent,
                                       enableProgressBar: false),
                                 ),
                               ),
                             );
                           },itemCount: result.length,) ,
                     ),
                     Container(color: Colors.cyanAccent,),
                     Container(color: Colors.tealAccent,),
                    ],
                  ),
                ),*/
              ],
            ),
          ),
        ),
      ),
    );
  }
}
