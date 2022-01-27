import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:path/path.dart' as path;
import 'package:chewie/chewie.dart';
import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:topi/Gradient.dart';
import 'package:topi/Shared_Pref.dart';
import 'package:topi/constants.dart';
import 'package:video_player/video_player.dart';

class chewiePlayer extends StatefulWidget {
  late final VideoPlayerController videoPlayerController;
  late final childView;

  chewiePlayer({required this.videoPlayerController, required this.childView});

  @override
  _chewiePlayerState createState() => _chewiePlayerState();
}

class _chewiePlayerState extends State<chewiePlayer> {
  late final ChewieController _chewieController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setData();
  }

  setData() async {
    _chewieController = ChewieController(
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
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            child: Text(
              'Became a Star',
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
                borderRadius: BorderRadius.all(Radius.circular(20)),
              border: Border.all(color: Colors.white)
            ),
            child: Chewie(
              controller: _chewieController,
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
    widget.videoPlayerController.dispose();
    _chewieController.dispose();
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myNative = NativeAd(
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

    });
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
                  child: chewiePlayer(
                    videoPlayerController:
                        VideoPlayerController.file(File(imagePaths)),
                    childView: Container(
                      child: Column(
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Container(
                                    margin: EdgeInsets.symmetric(horizontal: 8.0),
                                    child: OutlinedButton(
                                      style: OutlinedButton.styleFrom(
                                        side: BorderSide(
                                            width: 1.0, color: Colors.redAccent),
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
                                            width: 1.0, color: Colors.redAccent),
                                      ),
                                      onPressed: () {
                                        _onShare(context, imagePaths.toString());
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

                          isAdLoaded
                              ?Container(
                            color: Colors.white,
                            height: 60,
                            width: MediaQuery.of(context).size.width,
                            child: AdWidget(
                              ad:myNative!,
                            ),
                          ) : Text('loading...')
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
    //getPath();

    //var newString = image.split('files');
    if (await Permission.storage.request().isGranted &&
        await Permission.accessMediaLocation.request().isGranted) {
    //  var dir = await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOWNLOADS);
      //var paths = await File(image).rename('$dir${newString[1]}');
      File value = File('$image');
    var paths=  await GallerySaver.saveVideo(value.path);
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
