import 'dart:async';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:chewie/chewie.dart';
import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:topi/Gradient.dart';
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
        autoInitialize: true,
        showControls: false,
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
          child: Chewie(
            controller: _chewieController,
          ),
        ),
        Expanded(
          flex: 1,
          child: widget.childView,
        ),
      ],
    );
  }

  @override
  void dispose() {
    widget.videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }
}

class VideoPlayers extends StatefulWidget {
  @override
  _VideoPlayersState createState() => _VideoPlayersState();
}

late var imagePaths;
bool isLoading = false;

class _VideoPlayersState extends State<VideoPlayers> {
/*
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPath();
  }

  getPath() async {
    var dir = await getExternalStorageDirectory();
    await dir!.list().toList().then((value) => print('value is $value'));
  }
*/

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;

    if (args['file'] != null) {
      imagePaths = args['file'];

    }

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
      body: SafeArea(
        child: BackgroundGradient(
          childView: isLoading
              ? Center(
                  child: spinkit,
                )
              : Container(
                  margin: EdgeInsets.symmetric(vertical: 26.0),
                  child: chewiePlayer(
                    videoPlayerController:
                        VideoPlayerController.file(File(imagePaths)),
                    childView: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.symmetric(horizontal: 8.0),
                              child: OutlinedButton(
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.0),
                                    ),
                                  ),
                                  backgroundColor: MaterialStateProperty.all(
                                      Colors.redAccent),
                                ),
                                onPressed: () {
                                  _onSave(context, imagePaths);
                                },
                                child: Text(
                                  'Save',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              child: OutlinedButton(
                                style: ButtonStyle(
                                    shape: MaterialStateProperty.all(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12.0))),
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.redAccent)),
                                onPressed: () {
                                  _onShare(context, imagePaths.toString());
                                },
                                child: Text(
                                  'Share',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.0,
                                  ),
                                ),
                              ),
                            ),
                          ),
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

    var newString = image.split('files');
    if (await Permission.storage.request().isGranted &&
        await Permission.accessMediaLocation.request().isGranted ) {
      var dir = await ExternalPath.getExternalStoragePublicDirectory(
          ExternalPath.DIRECTORY_DOWNLOADS);
      var paths = await File(image).rename('$dir${newString[1]}');
      print('new path is $paths ');
      if (paths.toString().isNotEmpty) {
        toastShow('Saved!');
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
    /*else {
      await Share.share(imageFile.toString(),
          sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
    }*/
  }
}
