import 'dart:io';

import 'package:better_player/better_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:marquee/marquee.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:preload_page_view/preload_page_view.dart';
import 'package:share_plus/share_plus.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:topi/constants.dart';
import 'package:topi/HttpRequest.dart';
import 'package:topi/Shared_Pref.dart';
import 'package:collection/collection.dart';
import 'OutlineBtn.dart';

class Community extends StatefulWidget {
  const Community({Key? key}) : super(key: key);

  @override
  _CommunityState createState() => _CommunityState();
}

class _CommunityState extends State<Community> {
  var log = 'images/background.png';

  int value = 0;
  var data = [];
  bool isVisible = true, isDownloaded = false;
  bool isLoading = false;
  var activeIndex = 5;
  late var isLiked ;
  List<bool> isDescClick = [];
  List isLikedCount = [], isCommentCount = [], isShareCount = [];
  var indexes = [],
      listing = [],
      values = [1, 2, 3, 4, 5],
      pos = [
        "http://www.exit109.com/~dnn/clips/RW20seconds_1.mp4",
        "http://www.exit109.com/~dnn/clips/RW20seconds_1.mp4",
        "http://www.exit109.com/~dnn/clips/RW20seconds_1.mp4",
        "http://www.exit109.com/~dnn/clips/RW20seconds_1.mp4",
        "http://www.exit109.com/~dnn/clips/RW20seconds_1.mp4",
        "http://www.exit109.com/~dnn/clips/RW20seconds_1.mp4",
        "http://www.exit109.com/~dnn/clips/RW20seconds_1.mp4",
        "http://www.exit109.com/~dnn/clips/RW20seconds_1.mp4",
        "http://www.exit109.com/~dnn/clips/RW20seconds_1.mp4",
        "http://www.exit109.com/~dnn/clips/RW20seconds_1.mp4",
      ],
      vid = [];
  List<BetterPlayerListVideoPlayerController>? controller = [];
  bool isInterstitialAdReady = false;
  int? indexPoint;
  InterstitialAd? _interstitialAd;
  PreloadPageController _pageController = PreloadPageController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoading = true;
    _loadInterstitialAd();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      getCommunity();
    });
  }

  void testingVideoLink(index) async {
    String uriPrefix = 'https://wasisoft.page.link'; // https://topi.ai
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: uriPrefix,
      androidParameters:
          AndroidParameters(packageName: 'com.topi.ai', minimumVersion: 0),
      link: Uri.parse(uriPrefix + '/community'),
    );

    //final ShortDynamicLink shortDynamicLink = await FirebaseDynamicLinks.instance.buildShortLink(parameters);
    Uri uri = await FirebaseDynamicLinks.instance.buildLink(parameters);
    //shortDynamicLink.shortUrl;
    Share.share(uri.toString(), subject: 'Topi.Ai Songs');

    print('value of share ${isShareCount[index]}');
  }

  getCommunity() async {
    HttpRequest request = HttpRequest();
    var result = await request.getCommunity(context);
    var likes = await request.getLikesCount(context);
    var shares = await request.getSharesCount(context);
    setState(() {
      if (result == null || result.isEmpty) {
        toastShow('Data not Found...');
        isLoading = false;
      } else if (result.toString().contains('Error')) {
        toastShow('$result...');
        isLoading = false;
      } else {
        for (int i = 0; i < result.length; i++) {
          controller?.insert(i, BetterPlayerListVideoPlayerController());
        }
        data = result;
        isLikedCount = likes['likes'];
        isShareCount = shares['share'];
        isCommentCount = List<int>.filled(data.length, 0);
        isLiked = List<bool>.filled(data.length, false);
        isLoading = false;
      }
    });
  }

  Future<bool> _loadMore() async {
    debugPrint("onLoadMore");
    //await Future.delayed(Duration(seconds: 0, milliseconds: 2000));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.black54,
      bottomSheet: Padding(padding: EdgeInsets.only(bottom: 100.0)),
      body: SafeArea(
        bottom: false,
        child: isLoading
            ? Center(child: spinkit)
            : PreloadPageView.builder(
                preloadPagesCount: 5,
                controller: _pageController,
                onPageChanged: (index) {
                  controller!.forEach((controllers) => controllers.pause());
                  controller![index].play();
                  if (index % 4 == 0) {
                    // interAd();
                  }
                },
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int index) {
                  controller![0].play();
                  return Container(
                    padding: EdgeInsets.only(bottom: 13.0),
                    child: Container(
                      child: Stack(
                        children: [
                          Container(
                            child: BetterPlayerListVideoPlayer(
                              BetterPlayerDataSource(
                                  BetterPlayerDataSourceType.network,
                                  '${data[index]['video']}'),
                              playFraction: 0.8,
                              betterPlayerListVideoPlayerController:
                                  controller![index],
                              configuration: BetterPlayerConfiguration(
                                expandToFill: true,
                                autoDispose: false,
                                aspectRatio: 1.0,
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
                          ),
                          /*Positioned(
                            bottom: 140,
                            left: 130,
                            child: Container(
                              height: 120,
                              child: Lottie.asset('assets/arrow.json',
                                  repeat: true, animate: true),
                            ),
                          ),
                          Container(
                            alignment: Alignment.bottomCenter,
                            margin: EdgeInsets.only(bottom: 100),
                            child: ElevatedButton.icon(
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.deepOrange,
                                    //background color of button
                                    side: BorderSide(
                                        width: 1, color: Colors.brown),
                                    //border width and color
                                    elevation: 3,
                                    //elevation of button
                                    shape: RoundedRectangleBorder(
                                        //to set border radius to button
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    padding: EdgeInsets.all(
                                        20) //content padding inside button
                                    ),
                                onPressed: () async {
                                  await SharedPref.setSongId(
                                      data[index]['modal_id'].toString());
                                  await SharedPref.setSongPremium(
                                      data[index]['premium'].toString());
                                  Navigator.pushNamed(
                                      context, '/image_pickers');
                                },
                                icon: Icon(
                                  FontAwesomeIcons.video,
                                  size: 14,
                                ),
                                label: Text(
                                  'Create this video',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.0,
                                  ),
                                )),
                          )*/
                          Positioned(
                            bottom: MediaQuery.of(context).size.height - 150,
                            right: MediaQuery.of(context).size.width * 0.01,
                            child: Container(
                              padding: const EdgeInsets.all(8.0),
                              child: Visibility(
                                visible: data[index]['premium'] != '0'
                                    ? true
                                    : false,
                                child: UnicornOutlineButton(
                                  strokeWidth: 1,
                                  radius: 10,
                                  gradient: LinearGradient(colors: [
                                    Colors.cyan,
                                    Colors.deepOrangeAccent
                                  ]),
                                  child: Text(
                                    'Premium',
                                    style: TextStyle(
                                        fontSize: 14.0,
                                        fontWeight: FontWeight.w700,
                                        foreground: Paint()
                                          ..shader = linearGradient),
                                  ),
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, '/premium_feature');
                                  },
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                              bottom: 420,
                              left: MediaQuery.of(context).size.width - 55,
                              child: Container(
                                child: CircleAvatar(
                                  radius: 26,
                                  backgroundColor: Colors.deepOrange,
                                  child: CircleAvatar(
                                    radius: 25.0,
                                    child: Image.asset(
                                      'assets/topi.png',
                                    ),
                                  ),
                                ),
                              )),
                          StackDesign(
                            bottomMargin: 360.0,
                            leftMargin: 55,
                            counts: likeId(index) ?? 0,
                            colors: isLiked[index] == true
                                ? Colors.red
                                : Colors.white,
                            ikon: CupertinoIcons.heart_solid,
                            onClick: () {
                             setState(() {
                               if (isLiked[index] == true) {
                                 isLiked[index]=false;
                               } else {
                                 isLiked[index]=true;
                               }
                             });
                            },
                          ),
                          StackDesign(
                            bottomMargin: 290.0,
                            leftMargin: 55,
                            counts: isCommentCount.length,
                            colors: Colors.white,
                            ikon: FontAwesomeIcons.solidCommentDots,
                            onClick: () {
                              _settingModalBottomSheet(context);
                            },
                          ),
                          StackDesign(
                            bottomMargin: 220.0,
                            leftMargin: 55,
                            counts: shareId(index)?? 0 ,
                            colors: Colors.white,
                            ikon: CupertinoIcons.arrowshape_turn_up_right_fill,
                            onClick: () {
                              testingVideoLink(index);
                            },
                          ),
                          StackDesign(
                            bottomMargin: 150.0,
                            leftMargin: 60,
                            counts: 15,
                            ikon: FontAwesomeIcons.download,
                            colors: Colors.white,
                            onClick: () {
                              _onSave(context, data[index]['video']);
                            },
                          ),
                          Positioned(
                              bottom: 50,
                              left: MediaQuery.of(context).size.width - 85,
                              child: InkWell(
                                onTap: () async {
                                  await SharedPref.setSongId(
                                      data[index]['modal_id'].toString());
                                  await SharedPref.setSongPremium(
                                      data[index]['premium'].toString());
                                  Navigator.pushNamed(
                                      context, '/image_pickers');
                                },
                                child: Container(
                                  height: 100,
                                  child: Lottie.asset(
                                      'assets/cd_animation.json',
                                      repeat: true,
                                      animate: true),
                                ),
                              )),
                          Positioned(
                            bottom: 100,
                            right: MediaQuery.of(context).size.width - 85,
                            child: Container(
                              child: Text(
                                '@Topi.Ai official',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 80,
                            right: MediaQuery.of(context).size.width - 20,
                            child: Container(
                              child: Icon(
                                CupertinoIcons.music_note_2,
                                color: Colors.white,
                                size: 14,
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 80,
                            right: MediaQuery.of(context).size.width - 150,
                            left: MediaQuery.of(context).padding.left + 30,
                            child: Container(
                              height: 15,
                              child: Marquee(
                                text: '${data[index]['video_name']}',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w700),
                                blankSpace: 10,
                                velocity: 30,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                itemCount: data.length,
              ),
      ),
    );
  }

  likeId(index) {
    List value = [];
    data.forEach((dates) {
      isLikedCount.forEach((likes) {
        if (dates['id'] == likes['video_id']) {
          value.add(likes['like']);
        }
      });
    });
    return value[index];
  }
  shareId(index) {
    List value = [];
    data.forEach((dates) {
      isShareCount.forEach((likes) {
        if (dates['id'] == likes['video_id']) {
          value.add(likes['share']);
        }
      });
    });
    return value[index];
  }

// load interstitial ad
  void _loadInterstitialAd() {
    InterstitialAd.load(
        adUnitId: SharedPref.getInterstitialAd() ?? '',
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(onAdLoaded: (ad) {
          this._interstitialAd = ad;
          ad.fullScreenContentCallback =
              FullScreenContentCallback(onAdDismissedFullScreenContent: (ad) {
            //back screen call
          });
          isInterstitialAdReady = true;
        }, onAdFailedToLoad: (err) {
          print('Load Failed ${err.message}');
          isInterstitialAdReady = false;
        }));
  }

  // check if ad ready
  interAd() {
    if (isInterstitialAdReady) {
      _interstitialAd?.show();
      _loadInterstitialAd();
    } else {
      toastShow('Ad not work');
      _loadInterstitialAd();
    }
  }

  // pop up menu dialog three dots
  showMenuDialog(context, details) async {
    double left = details.dx;
    double top = details.dy;
    await showMenu(
            context: context,
            position: RelativeRect.fromLTRB(left, top, 0, 0),
            items: [
              PopupMenuItem<String>(child: Text('Edit'), value: '1'),
              PopupMenuItem<String>(child: Text('Delete'), value: '-1'),
            ],
            elevation: 8.0)
        .then((item) {
      switch (item) {
        case '1':
          value = 1;
          break;
        case '-1':
          value = -1;
          break;
      }
    });
  }

  void _onSave(BuildContext context, image) async {
    if (await Permission.storage.request().isGranted &&
        await Permission.accessMediaLocation.request().isGranted) {
      File value = File('$image');
      var paths = await GallerySaver.saveVideo(value.path);
      if (paths.toString().isNotEmpty) {
        toastShow('Video Saved in gallery!');
        isDownloaded = true;
      }
    } else {
      await [
        Permission.accessMediaLocation,
        Permission.storage,
      ].request();
    }
  }

  void _onShare(BuildContext context, image) async {
    // final box = context.findRenderObject() as RenderBox?;
    print('image path $image');
    if (image != null) {
      await Share.share(
        image, /*   sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size*/
      );
    }
  }

  //for modal bottom sheet to show children
  void _settingModalBottomSheet(context) {
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
                margin: EdgeInsets.only(bottom: 8.0),
                child: Text(
                  '1000 comments',
                  style: TextStyle(
                      color: Color(0xff0a1829),
                      fontSize: 14.0,
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
                        'monthly',
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
                        'halfly',
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
                        'yearly',
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
          InkWell(
            child: AnimatedContainer(
              duration: const Duration(
                milliseconds: 200,
              ),
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
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
                  ]),
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
          ),
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

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller!.forEach((element) {
      element.pause();
    });
  }
}

// design classes for like,share etc
class StackDesign extends StatelessWidget {
  final bottomMargin, leftMargin, ikon, onClick, counts, colors;

  StackDesign({
    required this.bottomMargin,
    required this.leftMargin,
    required this.ikon,
    required this.colors,
    required this.counts,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: bottomMargin,
        left: MediaQuery.of(context).size.width - leftMargin,
        child: InsideStacks(
          icons: ikon,
          color: colors,
          onPress: onClick,
          count: counts,
        ));
  }
}

class InsideStacks extends StatelessWidget {
  final onPress, icons, count, color;

  const InsideStacks({
    required this.icons,
    required this.count,
    required this.color,
    required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          child: IconButton(
              onPressed: onPress,
              icon: FaIcon(
                icons,
                color: color,
                size: 30,
              )),
        ),
        Container(
          child: Text(
            '${NumberFormat.compact().format(count)}',
            style: TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.w700,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
