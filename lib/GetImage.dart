import 'dart:async';
import 'dart:io';
import 'package:chewie/chewie.dart';
import 'package:external_path/external_path.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:topi/ChewiePlayer.dart';
import 'package:topi/Gradient.dart';
import 'package:topi/HttpRequest.dart';
import 'package:topi/constants.dart';
import 'package:video_player/video_player.dart';

class ImagePickers extends StatefulWidget {
  @override
  _ImagePickersState createState() => _ImagePickersState();
}

enum AppState {
  free,
  picked,
  cropped,
}

class _ImagePickersState extends State<ImagePickers> {
  late AppState state;
  File? imageFile;
  bool isLoading = false;
  bool isPlaying = false;
  bool isAdLoaded = false;
  var imagePaths;
  final AdSize adSize = AdSize(width: 320, height: 250);
  BannerAd? myBanner;
  int pos = 0;
  List userAnswer = [
    'Now Image is Processing to do some Magic...',
    'Where you can see a lot of new features...',
    'Downloading your magical image to video creation...',
  ];
  late Timer _timer, timer;
  var songs;
  NativeAd? myNative;
  InterstitialAd? _interstitialAd;
  RewardedAd? _rewardedAd;
  bool isInterstitialAdReady = false;
  bool isRewardedAdReady = false;

  @override
  void initState() {
    super.initState();
    state = AppState.free;
    /* myBanner= BannerAd(
        size: adSize, adUnitId: 'ca-app-pub-3940256099942544/6300978111', listener: BannerAdListener(), request: AdRequest());*/
    myNative = NativeAd(
      adUnitId: 'ca-app-pub-3940256099942544/2247696110',
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
    myNative!.load();
    // myBanner!.load();
    // _loadInterstitialAd();
    _loadRewardedAd();
    setTimer();
  }

  void _loadInterstitialAd() {
    InterstitialAd.load(
        adUnitId: 'ca-app-pub-3940256099942544/8691691433',
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

  void _loadRewardedAd() {
    RewardedAd.load(
        adUnitId: 'ca-app-pub-3940256099942544/5224354917',
        request: AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(onAdLoaded: (ad) {
          this._rewardedAd = ad;
          ad.fullScreenContentCallback =
              FullScreenContentCallback(onAdDismissedFullScreenContent: (ad) {
            //back screen call
            setState(() {
              isRewardedAdReady = false;
            });
            _loadRewardedAd();
          });
          setState(() {
            isRewardedAdReady = true;
          });
        }, onAdFailedToLoad: (err) {
          print('Load Failed ${err.message}');
          isRewardedAdReady = false;
        }));
  }

  setTimer() {
    _timer = Timer.periodic(Duration(seconds: 3), (_) {
      setState(() {
        if (pos < 2) {
          pos++;
        } else {
          pos = 0;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    if (args != null) {
      setState(() {
        songs = args['song_name'];
      });
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
      body: BackgroundGradient(
        childView: Center(
          child: imageFile != null
              ? isLoading
                  ? Container(
                      margin: EdgeInsets.only(top: 60.0),
                      child: Center(
                        child: Column(
                          children: [
                            Container(
                              child: Lottie.asset('assets/waiting.json',
                                  repeat: true, reverse: true, animate: true),
                            ),
                            AnimatedSwitcher(
                              duration: Duration(milliseconds: 900),
                              transitionBuilder:
                                  (Widget child, Animation<double> animation) {
                                return ScaleTransition(
                                    scale: animation, child: child);
                              },
                              child: Text(
                                '${userAnswer[pos]}',
                                key: ValueKey<String>(userAnswer[pos]),
                                style: TextStyle(
                                    fontSize: 14, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Container(
                      child: Lottie.asset('assets/upload_file.json',
                          repeat: true, reverse: true, animate: true),
                    )
              : Column(
                  children: [
                    Container(
                      child: Lottie.asset('assets/upload_file.json',
                          repeat: true, reverse: true, animate: true),
                    ),
                    isAdLoaded
                        ? Container(
                            color: Colors.white,
                            width: MediaQuery.of(context).size.width,
                            height: 100,
                            child: AdWidget(
                              ad: myNative!,
                            ),
                          )
                        : Text('loading...'),
                  ],
                ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrange,
        onPressed: () {
          _pickImage();
        },
        child: _buildButtonIcon(),
      ),
    );
  }

  Widget _buildButtonIcon() {
    return Icon(Icons.add);
  }

  Future<Null> _pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    imageFile = pickedImage != null ? File(pickedImage.path) : null;
    if (imageFile != null) {
      setState(() {
        state = AppState.picked;
        _cropImage();
      });
    }
  }

  Future<Null> _cropImage() async {
    File? croppedFile = await ImageCropper.cropImage(
      sourcePath: imageFile!.path,
      aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
    );
    if (croppedFile != null) {
      setState(() {
        isLoading = true;
        if (isRewardedAdReady) {
                _rewardedAd?.show(onUserEarnedReward: (RewardedAd ad,RewardItem item){});

        } else {
          toastShow('Ad not work');
        }
      });
      imageFile = croppedFile;
      if (songs == 'bamboleo') {
        print('0 is $songs');
        predictSong();
      } else if (songs == 'munda_lahori') {
        print('1 is $songs');
        oneNpSong();
      } else if (songs == 'patla_lak') {
        print('2 is $songs');
        twoNpSong();
      } else if (songs == 'pani_pani') {
        print('3 is $songs');
        threeNpSong();
      } else if (songs == 'athra_style') {
        print('4 is $songs');
        fourNpSong();
      } else if (songs == 'eid_mubarak') {
        print('5 is $songs');
        fiveNpSong();
      } else if (songs == 'tera_suit') {
        print('6 is $songs');
        sixNpSong();
      }
    }
  }

  predictSong() async {
    HttpRequest request = HttpRequest();
    var result = await request.predictNp(context, imageFile);
    if (result != null) {
      if (result == 504) {
        snackShow(context, '$result Server Error ');
        setState(() {
          isLoading = false;
        });
      } else {
        timer = Timer.periodic(Duration(seconds: 1), (_) async {
          var dir = await getExternalStorageDirectory();
          List values = await dir!.list().toList();
          for (int i = 0; i < values.length; i++) {
            if (values[i].toString().contains(result.path.toString())) {
              timer.cancel();
              Future.delayed(Duration(seconds: 10), () {
                Navigator.pushNamed(context, '/video_players', arguments: {
                  'file': '${result.path}',
                });
                isLoading = false;
              });
            }
          }
        });
      }
    } else {
      setState(() {
        toastShow('Unable to Load!Check Internet Connectivity');
        isLoading = false;
        _clearImage();
      });
    }
  }

  oneNpSong() async {
    HttpRequest request = HttpRequest();
    var result = await request.oneNp(context, imageFile);
    if (result != null) {
      if (result == 504) {
        snackShow(context, '$result Server Error ');
        setState(() {
          isLoading = false;
        });
      } else {
        timer = Timer.periodic(Duration(seconds: 1), (_) async {
          var dir = await getExternalStorageDirectory();
          List values = await dir!.list().toList();
          for (int i = 0; i < values.length; i++) {
            if (values[i].toString().contains(result.path.toString())) {
              timer.cancel();
              Future.delayed(Duration(seconds: 10), () {
                Navigator.pushNamed(context, '/video_players', arguments: {
                  'file': '${result.path}',
                });
                isLoading = false;
              });
            }
          }
        });
      }
    } else {
      setState(() {
        toastShow('Unable to Load!Check Internet Connectivity');
        isLoading = false;
        _clearImage();
      });
    }
  }

  twoNpSong() async {
    HttpRequest request = HttpRequest();
    var result = await request.twoNp(context, imageFile);
    if (result != null) {
      if (result == 504) {
        snackShow(context, '$result Server Error ');
        setState(() {
          isLoading = false;
        });
      } else {
        timer = Timer.periodic(Duration(seconds: 1), (_) async {
          var dir = await getExternalStorageDirectory();
          List values = await dir!.list().toList();
          for (int i = 0; i < values.length; i++) {
            if (values[i].toString().contains(result.path.toString())) {
              timer.cancel();
              Future.delayed(Duration(seconds: 10), () {
                Navigator.pushNamed(context, '/video_players', arguments: {
                  'file': '${result.path}',
                });
                isLoading = false;
              });
            }
          }
        });
      }
    } else {
      setState(() {
        toastShow('Unable to Load!Check Internet Connectivity');
        isLoading = false;
        _clearImage();
      });
    }
  }

  threeNpSong() async {
    HttpRequest request = HttpRequest();
    var result = await request.threeNp(context, imageFile);
    if (result != null) {
      if (result == 504) {
        snackShow(context, '$result Server Error ');
        setState(() {
          isLoading = false;
        });
      } else {
        timer = Timer.periodic(Duration(seconds: 1), (_) async {
          var dir = await getExternalStorageDirectory();
          List values = await dir!.list().toList();
          for (int i = 0; i < values.length; i++) {
            if (values[i].toString().contains(result.path.toString())) {
              timer.cancel();
              Future.delayed(Duration(seconds: 10), () {
                Navigator.pushNamed(context, '/video_players', arguments: {
                  'file': '${result.path}',
                });
                isLoading = false;
              });
            }
          }
        });
      }
    } else {
      setState(() {
        toastShow('Unable to Load!Check Internet Connectivity');
        isLoading = false;
        _clearImage();
      });
    }
  }

  fourNpSong() async {
    HttpRequest request = HttpRequest();
    var result = await request.fourNp(context, imageFile);
    if (result != null) {
      if (result == 504) {
        snackShow(context, '$result Server Error ');
        setState(() {
          isLoading = false;
        });
      } else {
        timer = Timer.periodic(Duration(seconds: 1), (_) async {
          var dir = await getExternalStorageDirectory();
          List values = await dir!.list().toList();
          for (int i = 0; i < values.length; i++) {
            if (values[i].toString().contains(result.path.toString())) {
              timer.cancel();
              Future.delayed(Duration(seconds: 10), () {
                Navigator.pushNamed(context, '/video_players', arguments: {
                  'file': '${result.path}',
                });
                isLoading = false;
              });
            }
          }
        });
      }
    } else {
      setState(() {
        toastShow('Unable to Load!Check Internet Connectivity');
        isLoading = false;
        _clearImage();
      });
    }
  }

  fiveNpSong() async {
    HttpRequest request = HttpRequest();
    var result = await request.fiveNp(context, imageFile);
    if (result != null) {
      if (result == 504) {
        snackShow(context, '$result Server Error ');
        setState(() {
          isLoading = false;
        });
      } else {
        timer = Timer.periodic(Duration(seconds: 1), (_) async {
          var dir = await getExternalStorageDirectory();
          List values = await dir!.list().toList();
          for (int i = 0; i < values.length; i++) {
            if (values[i].toString().contains(result.path.toString())) {
              timer.cancel();
              Future.delayed(Duration(seconds: 10), () {
                Navigator.pushNamed(context, '/video_players', arguments: {
                  'file': '${result.path}',
                });
                isLoading = false;
              });
            }
          }
        });
      }
    } else {
      setState(() {
        toastShow('Unable to Load!Check Internet Connectivity');
        isLoading = false;
        _clearImage();
      });
    }
  }

  sixNpSong() async {
    HttpRequest request = HttpRequest();
    var result = await request.sixNp(context, imageFile);
    if (result != null) {
      if (result == 504) {
        snackShow(context, '$result Server Error ');
        setState(() {
          isLoading = false;
        });
      } else {
        timer = Timer.periodic(Duration(seconds: 1), (_) async {
          var dir = await getExternalStorageDirectory();
          List values = await dir!.list().toList();
          for (int i = 0; i < values.length; i++) {
            if (values[i].toString().contains(result.path.toString())) {
              timer.cancel();
              Future.delayed(Duration(seconds: 10), () {
                Navigator.pushNamed(context, '/video_players', arguments: {
                  'file': '${result.path}',
                });
                isLoading = false;
              });
            }
          }
        });
      }
    } else {
      setState(() {
        toastShow('Unable to Load!Check Internet Connectivity');
        isLoading = false;
        _clearImage();
      });
    }
  }

  void _clearImage() {
    imageFile = null;
    setState(() {
      state = AppState.free;
    });
  }

  Future<bool> _onWillPop(image) async {
    if (Platform.isIOS) {
      return await showDialog(
              context: context,
              builder: (context) => CupertinoAlertDialog(
                    title: Text('Are you sure?'),
                    content: Container(
                      child: Image.file(image),
                    ),
                    actions: <Widget>[
                      CupertinoDialogAction(
                        child: Text('No'),
                        onPressed: () => Navigator.of(context).pop(false),
                      ),
                      CupertinoDialogAction(
                        child: Text('Yes'),
                        onPressed: () => Navigator.of(context).pop(true),
                      ),
                    ],
                  )) ??
          false;
    } else {
      return (await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              backgroundColor: Color(0xffe8f6fa),
              actionsPadding: EdgeInsets.symmetric(horizontal: 24.0),
              content: Container(
                height: 150,
                child: _onPlay(context, File(image)),
              ),
              actions: <Widget>[
                ElevatedButton(
                  onPressed: () => _onSave(context),
                  child: new Text('Save'),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.red)),
                ),
                ElevatedButton(
                  onPressed: () => _onShare(context),
                  child: new Text('Share'),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.red)),
                ),
              ],
            ),
          )) ??
          false;
    }
  }

  _onPlay(BuildContext context, file) {
    /* chewiePlayer(
      videoPlayerController: VideoPlayerController.file(file),
    );*/
    print('isCalled $file');
  }

  void _onShare(BuildContext context) async {
    final box = context.findRenderObject() as RenderBox?;
    if (imagePaths != null) {
      await Share.shareFiles(['$imagePaths'],
          sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
    } else {
      await Share.share(imageFile.toString(),
          sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
    }
  }

  void _onSave(BuildContext context) async {
    var dir = await ExternalPath.getExternalStoragePublicDirectory(
        ExternalPath.DIRECTORY_DOWNLOADS);
    /* var path = await File(
      imagePaths.toString().substring(0, imagePaths.toString().length - 9),
    ).rename('/storage/emulated/0/Downloads/');*/
    //print('new path is $path');
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer.cancel();
    _timer.cancel();
  }
}
