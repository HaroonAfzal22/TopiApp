import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  AudioCache player = AudioCache(fixedPlayer: AudioPlayer());
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
  final europeanFlags = [
    'https://st2.depositphotos.com/1023173/6070/v/950/depositphotos_60708117-stock-illustration-red-hash-on-yellow.jpg',
    'https://st3.depositphotos.com/6736296/33335/v/1600/depositphotos_333352716-stock-illustration-tik-tok-logo-editorial-vector.jpg',
    'https://st2.depositphotos.com/4017237/6536/i/950/depositphotos_65367503-stock-photo-crumpled-flag-of-india.jpg',
    'https://img.freepik.com/free-vector/flag-usa-united-states-america-background_53500-169.jpg?size=626&ext=jpg',
    'https://upload.wikimedia.org/wikipedia/commons/thumb/0/09/Flag_of_South_Korea.svg/2560px-Flag_of_South_Korea.svg.png',
    'https://upload.wikimedia.org/wikipedia/en/thumb/f/f3/Flag_of_Russia.svg/1200px-Flag_of_Russia.svg.png',
    'https://wallpapercave.com/wp/wp2571235.jpg'
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
      return Colors.green;
    } else {
      return Colors.grey;
    }
  }

  final BannerAd myBanner = BannerAd(
      size: AdSize.banner,
      adUnitId: 'ca-app-pub-3940256099942544/6300978111',
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
    myBanner.load();
    // _checkVersion();
    getCategoryList();
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
            'A new Version of TOPI.AI is available! which is ${status.storeVersion}. but your Version is  ${status.localVersion}.\n\n Would you Like to update it now?',
        updateButtonText: 'Update Now',
      );
    }
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
      ),
      drawer: Drawers(),
      drawerScrimColor: Colors.transparent,
      floatingActionButton: FloatingActionButton(
        backgroundColor: fabColor(),
        onPressed: isEnabled
            ? () {
                player.fixedPlayer!.stop();
                if (isClick.toList().elementAt(0) == true) {
                  setState(() {
                    isClick[0] = false;
                    selected[0] = false;
                    clickIcon(0);
                    isEnabled = false;
                  });

                  Navigator.pushNamed(context, '/image_pickers', arguments: {
                    'song_name': 'bamboleo',
                  });
                } else if (isClick.toList().elementAt(1) == true) {
                  setState(() {
                    isClick[1] = false;
                    selected[1] = false;
                    clickIcon(1);
                    isEnabled = false;
                  });

                  Navigator.pushNamed(context, '/image_pickers', arguments: {
                    'song_name': 'munda_lahori',
                  });
                } else if (isClick.toList().elementAt(2) == true) {
                  setState(() {
                    isClick[2] = false;
                    selected[2] = false;
                    clickIcon(2);
                    isEnabled = false;
                  });

                  Navigator.pushNamed(context, '/image_pickers', arguments: {
                    'song_name': 'patla_lak',
                  });
                } else if (isClick.toList().elementAt(3) == true) {
                  setState(() {
                    isClick[3] = false;
                    selected[3] = false;
                    clickIcon(3);
                    isEnabled = false;
                  });

                  Navigator.pushNamed(context, '/image_pickers', arguments: {
                    'song_name': 'pani_pani',
                  });
                } else if (isClick.toList().elementAt(4) == true) {
                  setState(() {
                    isClick[4] = false;
                    selected[4] = false;
                    clickIcon(4);
                    isEnabled = false;
                  });

                  Navigator.pushNamed(context, '/image_pickers', arguments: {
                    'song_name': 'athra_style',
                  });
                } else if (isClick.toList().elementAt(5) == true) {
                  setState(() {
                    isClick[5] = false;
                    selected[5] = false;
                    clickIcon(5);
                    isEnabled = false;
                  });

                  Navigator.pushNamed(context, '/image_pickers', arguments: {
                    'song_name': 'eid_mubarak',
                  });
                } else if (isClick.toList().elementAt(6) == true) {
                  setState(() {
                    isClick[6] = false;
                    selected[6] = false;
                    clickIcon(6);
                    isEnabled = false;
                  });
                  Navigator.pushNamed(context, '/image_pickers', arguments: {
                    'song_name': 'tera_suit',
                  });
                }
              }
            : () {
                snackShow(context, 'please choose song first...');
              },
        child: Icon(CupertinoIcons.arrow_up_doc_fill),
      ),
      bottomSheet: Padding(padding: EdgeInsets.only(bottom: 90.0)),
      body: SafeArea(
        child: BackgroundGradient(
          childView: isLoading
              ? Center(
                  child: spinkit,
                )
              : Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 55.0),
                      child: ListView(
                        physics: ScrollPhysics(),
                        children: [
                          SizedBox(
                            height: 8,
                          ),
                          Container(
                            height: 100,
                            child: ListView.builder(
                              physics: ScrollPhysics(),
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
                                      width: 60,
                                      height: 50,
                                    ),
                                    onClicks: () {
                                      /* for (int i = index + 1; i < 7; i++) {
                                  if (isClick.toList().elementAt(i)) {
                                    snackShow(context, 'Coming Soon...');
                                  }
                                }*/
                                      setState(() {
                                  isLoading=true;
                                });
                                      getSongsList(europeanCountries[index]['id']);
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
                                if (isClick.length != songsList.length) {
                                  isClick.add(false);
                                  selected.add(false);
                                }
                                return GestureDetector(
                                  onTap: () {
                                    //   Navigator.pushNamed(context, '/share_file');
                                    setState(() {
                                      if (isClick[index] == true) {
                                        isClick[index] = false;
                                        selected[index] = false;
                                        isEnabled = false;
                                      } else {
                                        isClick[index] = true;
                                        selected[index] = true;
                                        isEnabled = true;
                                        /* if (isClick.toList().elementAt(1) ||
                                      isClick.toList().elementAt(2) ||
                                      isClick.toList().elementAt(3) ||
                                      isClick.toList().elementAt(4) ||
                                      isClick.toList().elementAt(5) ||
                                      isClick.toList().elementAt(6)) {
                                    isEnabled = false;
                                    snackShow(context, 'Coming Soon...');
                                  }*/
                                      }
                                    });
                                    if (isClick.toList().elementAt(0) == true) {
                                      player.play('bamboleo.mp3');
                                    } else if (isClick.toList().elementAt(1) ==
                                        true) {
                                      player.play('munda_shahar.mp3');
                                    } else if (isClick.toList().elementAt(2) ==
                                        true) {
                                      player.play('patla_lak.mp3');
                                    } else if (isClick.toList().elementAt(3) ==
                                        true) {
                                      player.play('pani_pani.mp3');
                                    } else if (isClick.toList().elementAt(4) ==
                                        true) {
                                      player.play('athra_style.mp3');
                                    } else if (isClick.toList().elementAt(5) ==
                                        true) {
                                      player.play('eid_mubarak.mp3');
                                    } else if (isClick.toList().elementAt(6) ==
                                        true) {
                                      player.play('tera_suit.mp3');
                                    } else {
                                      player.fixedPlayer!.stop();
                                    }
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
                                      color:Color(int.parse('0xff${songsList[index]['color'].toString().substring(1,songsList[index]['color'].length)}')),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Expanded(
                                                child: Icon(
                                                  clickIcon(index),
                                                  size: 40.0,
                                                ),
                                              ),
                                              Expanded(
                                                flex: 4,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                  children: [
                                                    Container(
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              vertical: 12.0),
                                                      child: Text(
                                                        'Title: ${songsList[index]['video_name']}',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 16.0),
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
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 1.0,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 60,
                        child: AdWidget(
                          ad: myBanner,
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  List<bool> isClick = [];

  clickIcon(index) {
    if (isClick[index] == true) {
      return CupertinoIcons.pause;
    } else {
      return CupertinoIcons.play_fill;
    }
  }

  void postFcmToken() async {
    HttpRequest request = HttpRequest();
    var result =
        await request.postFcmToken(context, SharedPref.getUserFcmToken());

    debugPrint('result $result');
  }

  void getCategoryList() async {
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

    setState(() {
      songsList = songs;
      isLoading=false;
    });
  }

  @override
  void dispose() {
    super.dispose();
    myBanner.dispose();
    player.fixedPlayer!.stop();
  }
}
