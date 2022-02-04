import 'dart:io';
import 'package:better_player/better_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:topi/Gradient.dart';
import 'package:topi/Shared_Pref.dart';
import 'package:topi/constants.dart';

class ChewiePlayer extends StatefulWidget {
  late final String url;
  late final childView;

  ChewiePlayer({required this.url, required this.childView});

  @override
  _ChewiePlayerState createState() => _ChewiePlayerState();
}

class _ChewiePlayerState extends State<ChewiePlayer> {
  late BetterPlayerListVideoPlayerController _controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = BetterPlayerListVideoPlayerController();
  }

  /* setData() async {
    _chewieController = ChewieController(
      aspectRatio: 9/9,
        videoPlayerController: widget.videoPlayerController,
        autoPlay: true,
        errorBuilder: (context, error) {
          return Center(
            child: Text(
              error,
              style: TextStyle(color: Colors.white),
            ),
          );
        });
  }*/

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 1,
          child: Container(
            child: Text(
              'Became a Star',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.orangeAccent,
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                border: Border.all(color: Colors.white)),
            child: BetterPlayerListVideoPlayer(
              BetterPlayerDataSource(
                  BetterPlayerDataSourceType.file, '${widget.url}'),
              playFraction: 0.8,
              betterPlayerListVideoPlayerController: _controller,
              configuration: BetterPlayerConfiguration(
                expandToFill: true,
                aspectRatio: 1.0,
                controlsConfiguration: BetterPlayerControlsConfiguration(
                    enableMute: false,
                    enableOverflowMenu: false,
                    enablePlayPause: false,
                    enableFullscreen: false,
                    enableSkips: false,
                    showControlsOnInitialize: false,
                    enableProgressText: false,
                    playIcon: CupertinoIcons.play_arrow_solid,
                    controlBarColor: Colors.transparent,
                    enableProgressBar: false),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: widget.childView,
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class VideoPlayers extends StatefulWidget {
  @override
  _VideoPlayersState createState() => _VideoPlayersState();
}

class _VideoPlayersState extends State<VideoPlayers> {
  late var imagePaths;
  bool isLoading = false;
  NativeAd? myNative;
  bool isAdLoaded = false;
  BannerAd? myBanner = BannerAd(
      size: AdSize.banner,
      adUnitId: SharedPref.getBannerAd()??"",
      listener: BannerAdListener(),
      request: AdRequest());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  /*  myNative = NativeAd(
      adUnitId: SharedPref.getNativeAd(),
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
          print('natty $NativeAd failedToLoad: $error');
          ad.dispose();
        },
      ),
    );
    setState(() {
      myNative!.load();
    });*/
    myBanner!.load();

  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    if (args['file'] != null) {
      imagePaths = args['file'];
    }
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
      body: SafeArea(
        child: BackgroundGradient(
          childView: isLoading
              ? Center(
                  child: spinkit,
                )
              : Container(
                  child: ChewiePlayer(
                    url: '$imagePaths',
                    /*videoPlayerController:
                        VideoPlayerController.file(File(imagePaths)),*/
                    childView: Container(
                      child: Column(
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 8.0),
                                    child: OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                        side: BorderSide(
                                            width: 1.0,
                                            color: Colors.redAccent),
                                      ),
                                      onPressed: () {
                                        _onSave(context, imagePaths);
                                      },
                                      child: Text(
                                        'Save',
                                        style: TextStyle(
                                          color: Colors.orange,
                                          fontSize: 18.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    child: OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                        side: BorderSide(
                                            width: 1.0,
                                            color: Colors.redAccent),
                                      ),
                                      onPressed: () {
                                        _onShare(
                                            context, imagePaths.toString());
                                      },
                                      child: Text(
                                        'Share',
                                        style: TextStyle(
                                          color: Colors.orange,
                                          fontSize: 18.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        /*  Container(
                            width: MediaQuery.of(context).size.width,
                            height: 60,
                            child: AdWidget(
                              ad: myBanner!,
                            ),
                          ),*/
                        ],
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  void _onSave(BuildContext context, image) async {
    if (await Permission.storage.request().isGranted &&
        await Permission.accessMediaLocation.request().isGranted) {
      File value = File('$image');
      var paths = await GallerySaver.saveVideo(value.path);
      if (paths.toString().isNotEmpty) {
        toastShow('Video Saved in gallery!');
      }
    } else {
      await [
        Permission.accessMediaLocation,
        Permission.storage,
      ].request();
    }
  }

  void _onShare(BuildContext context, image) async {
    final box = context.findRenderObject() as RenderBox?;
    if (image != null) {
      await Share.shareFiles(['$image'],
          sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
    }
  }
}
