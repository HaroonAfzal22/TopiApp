import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:new_version/new_version.dart';
import 'package:topi/Gradient.dart';
import 'package:topi/HttpRequest.dart';
import 'package:topi/ListCards.dart';
import 'package:topi/NavigationDrawer.dart';
import 'package:topi/Shared_Pref.dart';
import 'package:topi/constants.dart';

import 'package:audioplayers/audioplayers.dart';

class SongsList extends StatefulWidget {
  @override
  _SongsListState createState() => _SongsListState();
}

class _SongsListState extends State<SongsList> {
  AudioPlayer audioPlayer= AudioPlayer();
  List europeanCountries = [];
  int? categoryId;
  int count = 0;
  List songsList = [];
  final singersList = [
    'Artist: Gipsy Kings',
    'Artist: Naseebo Lal',
    'Artist: Naseebo Lal',
    'Artist: Yo Yo Honey Singh',
    'Artist: Sidhu Moosewala',
    'Artist: Aayat Arif',
    'Artist: Tony Kakkar',
  ];

  final europeanColors = [
    Color(0xffffc3a0),
    Color(0xff6dd5ed),
    Color(0xff753a88),
    Color(0xffdd2476),
    Color(0xff2c3e50),
    Color(0xffef629f),
    Color(0xfffaaca8),
  ];
  bool isEnabled = false;
  bool isLoading = false;
  List<bool> selected = [];

  fabColor() {
    if (isEnabled) {
      return Colors.deepOrange;
    } else {
      return Colors.grey;
    }
  }

   BannerAd?  myBanner = BannerAd(
       size: AdSize.banner,
       adUnitId: SharedPref.getBannerAd(),
       listener: BannerAdListener(),
       request: AdRequest());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoading = true;
    Future.delayed(Duration(seconds: 4), () {
      if (count == 0) {
        setState(() {
          postFcmToken();
          count++;
        });
      }
    });
    myBanner!.load();
    getCategoryList();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawerScrimColor: Colors.transparent,
      floatingActionButton:isEnabled==true?
      FloatingActionButton(
        backgroundColor: fabColor(),
        onPressed: () {
          setState(() {
            stop();
            selected = List.filled(songsList.length, false);
            isClick = List.filled(songsList.length, false);
            isEnabled=false;
          });
                Navigator.pushNamed(context, '/image_pickers');
              },
        child: Icon(FontAwesomeIcons.fileImport),
        tooltip: 'Upload Image',
      ):Container(),
      bottomSheet: Padding(padding: EdgeInsets.only(bottom: 150.0)),
      body: SafeArea(
        bottom: false,
        child: BackgroundGradient(
          childView: isLoading
              ? Center(
                  child: spinkit,
                )
              : Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 110.0),
                      child: RefreshIndicator(
                        onRefresh: getCategoryList,
                        child: ListView(
                          physics: AlwaysScrollableScrollPhysics(),
                          children: [
                            SizedBox(
                              height: 8,
                            ),
                            Container(
                              height: 100,
                              child: ListView.builder(
                                physics: AlwaysScrollableScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount: europeanCountries.length,
                                itemBuilder: (context, index) {
                                  return ListCards(
                                      text: europeanCountries[index]
                                          ['category_name'],
                                      images: CachedNetworkImage(
                                        key: UniqueKey(),
                                        fit: BoxFit.fill,
                                        imageUrl: europeanCountries[index]
                                            ['category_image'],
                                        width: 50,
                                        height: 50,
                                      ),
                                      onClicks: () {
                                        /* for (int i = index + 1; i < 7; i++) {
                                    if (isClick.toList().elementAt(i)) {
                                      snackShow(context, 'Coming Soon...');
                                    }
                                  }*/
                                        setState(() {
                                          isLoading = true;
                                        });
                                        getSongsList(
                                            europeanCountries[index]['id']);
                                      });
                                },
                              ),
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Container(
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: BouncingScrollPhysics(),
                                itemCount: songsList.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () async{
                                      setState(() {
                                        if (selected.contains(true)) {
                                          if (selected[index] == true) {
                                            selected[index] = false;
                                            isEnabled = false;
                                            stop();

                                          } else {
                                            selected = List.filled(songsList.length, false);
                                            selected[index] = true;
                                            isEnabled = true;
                                            play(songsList[index]['audio']);

                                          }
                                        } else {
                                          selected[index] = true;
                                          isEnabled = true;
                                          play(songsList[index]['audio']);

                                        }
                                      });
                                      await SharedPref.setSongId(songsList[index]['id'].toString());
                                      await SharedPref.setSongPremium(songsList[index]['premium'].toString());
                                    },
                                    child: Container(
                                      height: 100,
                                      child: Card(
                                        shape: selected[index] == true
                                            ? new RoundedRectangleBorder(
                                                side: new BorderSide(
                                                    color: Colors.white,
                                                    width: 4.0),
                                                borderRadius:
                                                    BorderRadius.circular(20.0))
                                            : new RoundedRectangleBorder(
                                                side: new BorderSide(width: 1.0),
                                                borderRadius:
                                                    BorderRadius.circular(20.0)),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                            gradient: LinearGradient(
                                              colors: [
                                                Color(int.parse('0xff${songsList[index]['color'].toString().split(',').elementAt(0).substring(1,songsList[index]['color'].toString().split(',').elementAt(0).length)}')),
                                                Color(int.parse('0xff${songsList[index]['color'].toString().split(',').elementAt(1).substring(1,songsList[index]['color'].toString().split(',').elementAt(0).length)}')),
                                                Color(int.parse('0xff${songsList[index]['color'].toString().split(',').elementAt(2).substring(1,songsList[index]['color'].toString().split(',').elementAt(0).length)}')),
                                              ],
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                            ),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.spaceAround,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets.only(left: 8.0),
                                                    child: Icon(
                                                      clickIcon(index),
                                                      size: 40.0,
                                                      color: Colors.white,
                                                     /* onPressed: () {
                                                        setState(() {
                                                          if (isClick.contains(true)) {
                                                            if (isClick[index] == true) {
                                                              isClick[index] = false;
                                                              print('stop');
                                                              stop();
                                                            } else {
                                                              isClick = List.filled(songsList.length, false);
                                                              isClick[index] = true;
                                                              print('play isclick false');                                                                                       play(songsList[index]['audio']);
                                                            }
                                                          } else {
                                                            isClick[index] = true;
                                                            print('play isClick not contain');
                                                            play(songsList[index]['audio']);
                                                          }
                                                        });
                                                      },*/
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      children: [
                                                        Container(
                                                          margin: EdgeInsets
                                                              .symmetric(
                                                                  vertical: 12.0),
                                                          child: Text(
                                                            'Title: ${songsList[index]['video_name']}',
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.white,
                                                                fontWeight: FontWeight.w700,
                                                                fontSize: 18.0),
                                                          ),
                                                        ),
                                                        /*  Container(
                                                    child: Center(
                                                      child: Text(
                                                        singersList[index],
                                                        style: TextStyle(
                                                            fontSize: 12.0,
                                                            color: Colors.white),
                                                      ),
                                                    ),
                                                  ),*/
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 55.0,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                        child: AdWidget(
                          ad: myBanner!,
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  play(index)async{
    print('index $index');
    int result = await audioPlayer.play(index,volume: 10.0);
    if(result==1){
      print('playing..');
    }

  }
  stop()async{
    int result = await audioPlayer.stop();
    if(result ==1 ){
      print('stop song ');
    }
  }

  List<bool> isClick = [];

  clickIcon(index) {
    if (selected[index] == true) {
      return CupertinoIcons.pause;
    } else {
      return CupertinoIcons.play_fill;
    }
  }

  void postFcmToken() async {
    HttpRequest request = HttpRequest();
    var result =
        await request.postFcmToken(context, SharedPref.getUserFcmToken());

  }

  Future<void> getCategoryList() async {
    HttpRequest request = HttpRequest();
    var result = await request.getCategories(context);
    setState(() {
      europeanCountries = result;
      categoryId = result[0]['id'];
    });

    getSongsList(categoryId!);
  }

  void getSongsList(int id) async {
    HttpRequest request = HttpRequest();
    var songs = await request.getSongsList(context, id);
    if(songs==500){
      snackShow(context, '$songs Error try again later...');
      setState(() {
        isLoading=false;
      });
    }else {
      setState(() {
        songsList = songs;
        selected = List.filled(songs.length, false);
        isClick = List.filled(songs.length, false);
        isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    myBanner!.dispose();
    audioPlayer.stop();
  }
}
