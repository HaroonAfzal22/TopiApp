import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:topi/Gradient.dart';
import 'package:topi/ListCards.dart';
import 'package:topi/constants.dart';

import 'package:audioplayers/audioplayers.dart';

class SongsList extends StatefulWidget {
  @override
  _SongsListState createState() => _SongsListState();
}

class _SongsListState extends State<SongsList> {
  AudioCache player = AudioCache(fixedPlayer: AudioPlayer());
  final europeanCountries = [
    'Popular',
    'Coming Soon...',
    'Coming Soon...',
    'Coming Soon...',
    'Coming Soon...',
    'Coming Soon...',
    'Coming Soon...',
  ];
  final songsList = [
    'Title: Bamboleo',
    'Title: Munda Shehar Lahore da',
    'Title: Patla Lak way',
    'Title: Pani Pani',
    'Title: Athra Style Jatta',
    'Title: Eid Mubarak',
    'Title: Tera Suit',
  ];
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
  List<bool> selected = [];

  fabColor() {
    if (isEnabled) {
      return Colors.green;
    } else {
      return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        brightness: Brightness.dark,
        elevation: 0.0,
        title: Image.asset(
          'assets/topi.png',
          fit: BoxFit.contain,
          width: 80,
          height: 80,
        ),
        centerTitle: true,
      ),
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
                    isEnabled=false;

                  });

                  Navigator.pushNamed(context, '/image_pickers', arguments: {
                    'song_name': 'bamboleo',
                  });
                } else if (isClick.toList().elementAt(1) == true) {
                  setState(() {
                    isClick[1] = false;
                    selected[1] = false;
                    clickIcon(1);
                    isEnabled=false;

                  });

                  Navigator.pushNamed(context, '/image_pickers', arguments: {
                    'song_name': 'munda_lahori',
                  });
                } else if (isClick.toList().elementAt(2) == true) {
                  setState(() {
                    isClick[2] = false;
                    selected[2] = false;
                    clickIcon(2);
                    isEnabled=false;

                  });

                  Navigator.pushNamed(context, '/image_pickers', arguments: {
                    'song_name': 'patla_lak',
                  });
                } else if (isClick.toList().elementAt(3) == true) {
                 setState(() {
                   isClick[3] = false;
                   selected[3] = false;
                   clickIcon(3);
                   isEnabled=false;

                 });

                  Navigator.pushNamed(context, '/image_pickers', arguments: {
                    'song_name': 'pani_pani',
                  });
                } else if (isClick.toList().elementAt(4) == true) {
                 setState(() {
                   isClick[4] = false;
                   selected[4] = false;
                   clickIcon(4);
                   isEnabled=false;

                 });

                  Navigator.pushNamed(context, '/image_pickers', arguments: {
                    'song_name': 'athra_style',
                  });
                } else if (isClick.toList().elementAt(5) == true) {

               setState(() {
                 isClick[5] = false;
                 selected[5] = false;
                 clickIcon(5);
                 isEnabled=false;

               });

                  Navigator.pushNamed(context, '/image_pickers', arguments: {
                    'song_name': 'eid_mubarak',
                  });
                } else if (isClick.toList().elementAt(6) == true) {
                  setState(() {
                    isClick[6] = false;
                    selected[6] = false;
                    clickIcon(6);
                    isEnabled=false;

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
      body: SafeArea(
        child: BackgroundGradient(
          childView: ListView(
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
                  itemCount: 7,
                  itemBuilder: (context, index) {
                    return ListCards(
                        text: europeanCountries[index],
                        images: CachedNetworkImage(
                          key: UniqueKey(),
                          fit: BoxFit.fill,
                          imageUrl: europeanFlags[index],
                          width: 50,
                          height: 50,
                        ),
                        onClicks: () {
                          print('click at ${europeanCountries[index]}');
                          for (int i = index + 1; i < 7; i++) {
                            if (isClick.toList().elementAt(i)) {
                              snackShow(context, 'Coming Soon...');
                            }
                          }
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
                  itemCount: 7,
                  itemBuilder: (context, index) {
                    if (isClick.length != 7) {
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
                        } else if (isClick.toList().elementAt(1) == true) {
                          player.play('munda_shahar.mp3');
                        } else if (isClick.toList().elementAt(2) == true) {
                          player.play('patla_lak.mp3');
                        } else if (isClick.toList().elementAt(3) == true) {
                          player.play('pani_pani.mp3');
                        } else if (isClick.toList().elementAt(4) == true) {
                          player.play('athra_style.mp3');
                        } else if (isClick.toList().elementAt(5) == true) {
                          player.play('eid_mubarak.mp3');
                        } else if (isClick.toList().elementAt(6) == true) {
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
                                      color: Colors.white, width: 4.0),
                                  borderRadius: BorderRadius.circular(4.0))
                              : new RoundedRectangleBorder(
                                  side: new BorderSide(width: 1.0),
                                  borderRadius: BorderRadius.circular(4.0)),
                          color: europeanColors[index],
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
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
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                              vertical: 12.0),
                                          child: Text(
                                            songsList[index],
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 16.0),
                                          ),
                                        ),
                                        Container(
                                          child: Center(
                                            child: Text(
                                              singersList[index],
                                              style: TextStyle(
                                                  fontSize: 12.0,
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
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

  @override
  void dispose() {
    super.dispose();
    player.fixedPlayer!.stop();
  }
}
