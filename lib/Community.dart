import 'dart:io';

import 'package:better_player/better_player.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
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
  List<bool> isLiked = [];
  List<bool> isDescClick = [];
  List<int> isLikedCount = [];
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
  PreloadPageController _pageController= PreloadPageController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoading = true;
    _loadInterstitialAd();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      getCommunity();
    });

    indexes = List<int>.filled(values.length, 0);
    listing = List<int>.filled(values.length, 0);
    isLikedCount = List<int>.filled(values.length, 0);
    isLiked = List<bool>.filled(values.length, false);
    isDescClick = List<bool>.filled(values.length, false);
  }

  void testingVideoLink() async {
    String uriPrefix = 'https://wasisoft.page.link'; // https://topi.ai
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: uriPrefix,
      androidParameters: AndroidParameters(packageName: 'com.topi.ai', minimumVersion: 0),
      link: Uri.parse(uriPrefix + '/community'),
    );

    //final ShortDynamicLink shortDynamicLink = await FirebaseDynamicLinks.instance.buildShortLink(parameters);
    Uri uri =await FirebaseDynamicLinks.instance.buildLink(parameters);
    //shortDynamicLink.shortUrl;
    Share.share(uri.toString(), subject: 'Topi.Ai Songs');
  }

  getCommunity() async {
    HttpRequest request = HttpRequest();
    var result = await request.getCommunity(context);
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
                    interAd();
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
                            counts: 6,
                            ikon: CupertinoIcons.heart_solid,
                            onClick: () {},
                          ),
                          StackDesign(
                            bottomMargin: 290.0,
                            leftMargin: 55,
                            counts: 35,
                            ikon: FontAwesomeIcons.commentDots,
                            onClick: () {},
                          ),
                          StackDesign(
                            bottomMargin: 220.0,
                            leftMargin: 55,
                            counts: 40,
                            ikon: CupertinoIcons.arrowshape_turn_up_right_fill,
                            onClick: () {
                             testingVideoLink();
                            },
                          ),
                          StackDesign(
                            bottomMargin: 150.0,
                            leftMargin: 60,
                            counts: 15,
                            ikon: FontAwesomeIcons.download,
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

  void _loadInterstitialAd() {
    InterstitialAd.load(
        adUnitId: SharedPref.getInterstitialAd(),
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

  interAd() {
    if (isInterstitialAdReady) {
      _interstitialAd?.show();
      _loadInterstitialAd();
    } else {
      toastShow('Ad not work');
      _loadInterstitialAd();
    }
  }

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

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller!.forEach((element) {
      element.pause();
    });
  }
}

class StackDesign extends StatelessWidget {
  final bottomMargin, leftMargin, ikon, onClick,counts;

  StackDesign({
    required this.bottomMargin,
    required this.leftMargin,
    required this.ikon,
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
          onPress: onClick, count: counts,
        ));
  }
}

class InsideStacks extends StatelessWidget {
  final onPress, icons,count;

  const InsideStacks({
    required this.icons,
    required this.count,
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
                color: Colors.white,
                size: 30,
              )),
        ),
        Container(
          child: Text('${NumberFormat.compact().format(count)}',
            style: TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),),
        ),
      ],
    );
  }
}
