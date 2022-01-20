import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:chewie/chewie.dart';
import 'package:external_path/external_path.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:topi/ChewiePlayer.dart';
import 'package:topi/Gradient.dart';
import 'package:topi/HttpRequest.dart';
import 'package:topi/Shared_Pref.dart';
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

class _ImagePickersState extends State<ImagePickers>
    with SingleTickerProviderStateMixin {
  late AppState state;
  File? imageFile;
  bool isLoading = false;
  bool isPlaying = false;
  bool isAdLoaded = false;
  var imagePaths;
  final AdSize adSize = AdSize(width: 320, height: 250);
  BannerAd? myBanner= BannerAd(
      size: AdSize.mediumRectangle,
      adUnitId: SharedPref.getBannerAd(),
      listener: BannerAdListener(),
      request: AdRequest());
  int pos = 0;
  List userAnswer = [
    'Now Image is Processing to do some Magic...',
    'Where you can see a lot of new features...',
    'Downloading your magical image to video creation...',
  ];
  Timer? _timer, timer;
  var songs;
  NativeAd? myNative;
  InterstitialAd? _interstitialAd;
  RewardedAd? _rewardedAd;
  bool isInterstitialAdReady = false;
  bool isRewardedAdReady = false;
  late AnimationController animationController;
      double? percentage;
  @override
  void initState() {
    super.initState();
    state = AppState.free;
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 60),
    );

    animationController.addListener(() => setState(() {}));

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
    myBanner!.load();
     _loadInterstitialAd();
    _loadRewardedAd();
    setTimer();
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

  void _loadRewardedAd() {
    RewardedAd.load(
        adUnitId:SharedPref.getRewardedAd(),
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
     percentage = animationController.value * 100;
    setState(() {
      if (percentage!.toStringAsFixed(0) == '100') {
        animationController.stop();
        if (isInterstitialAdReady) {
          _interstitialAd?.show();
        } else {
          toastShow('Ad not work');
          _loadInterstitialAd();
        }

      }
    });

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
                      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height/4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          percentage!.toStringAsFixed(0) == '100'?
                          Container(
                            height: 350,
                            child: Lottie.asset('assets/waiting.json',
                                repeat: true, reverse: true, animate: true),
                          ):Container(),
                          percentage!.toStringAsFixed(0) == '100'
                              ? Container(
                                  margin: EdgeInsets.only(top: 8.0),
                                  child: AnimatedSwitcher(
                                    duration: Duration(milliseconds: 900),
                                    transitionBuilder: (Widget child,
                                        Animation<double> animation) {
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
                                )
                              : Container(),
                          percentage!.toStringAsFixed(0) != '100'
                              ? Container(
                                  width: MediaQuery.of(context).size.width*0.7,
                                  height: MediaQuery.of(context).size.height*0.3,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 8.0),
                                  child: LiquidCircularProgressIndicator(
                                    value: double.parse('${animationController.value}'),
                                    valueColor: AlwaysStoppedAnimation(
                                        Color(0xffFC9425)),
                                    center: Text(
                                      '${percentage!.toStringAsFixed(0)}%',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    direction: Axis.vertical,
                                    backgroundColor: Colors.grey.shade300,
                                  ),
                                )
                              : Container(),
                          Expanded(child: Container()),
                          isAdLoaded
                              ? Container(
                                  alignment: Alignment.bottomCenter,
                                  color: Colors.white,
                                  width: MediaQuery.of(context).size.width,
                                  height: 50,
                                  child: AdWidget(
                                    ad: myNative!,
                                  ),
                                )
                              : Text('loading...')
                        ],
                      ),
                    )
                  : ListView(
                      children: [
                        Container(
                          height: 250,
                          width: MediaQuery.of(context).size.width,
                          child: AdWidget(
                            ad: myBanner!,
                          ),
                        ),
                        Container(
                          height: 300,
                          child: Lottie.asset('assets/upload.json',
                              repeat: true, reverse: true, animate: true),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 36.0, horizontal: 24.0),
                          child: ElevatedButton.icon(
                            style: ButtonStyle(
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(24.0))),
                                padding: MaterialStateProperty.all(
                                    EdgeInsets.symmetric(vertical: 12.0)),
                                backgroundColor: MaterialStateProperty.all(
                                  Colors.deepOrange,
                                )),
                            label: Text(
                              "Upload Image",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.0,
                              ),
                            ),
                            onPressed: () {
                              _pickImage();
                            },
                            icon: Icon(FontAwesomeIcons.upload),
                          ),
                        ),
                      ],
                    )
              : ListView(
                  children: [
                    Container(
                      height: 250,
                      width: MediaQuery.of(context).size.width,
                      child: AdWidget(
                        ad: myBanner!,
                      ),
                    ),
                    Container(
                      height: 300,
                      child: Lottie.asset('assets/upload.json',
                          repeat: true, reverse: true, animate: true),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          vertical: 36.0, horizontal: 24.0),
                      child: ElevatedButton.icon(
                        style: ButtonStyle(
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24.0))),
                            padding: MaterialStateProperty.all(
                                EdgeInsets.symmetric(vertical: 12.0)),
                            backgroundColor: MaterialStateProperty.all(
                              Colors.deepOrange,
                            )),
                        label: Text(
                          "Upload Image",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.0,
                          ),
                        ),
                        onPressed: () {
                          _pickImage();
                        },
                        icon: Icon(FontAwesomeIcons.upload),
                      ),
                    ),

                    /* isAdLoaded
                        ?*/
                    /* : Text('loading...')*/
                  ],
                ),
        ),
      ),
    );
  }


  static String getFileSizeString({required int bytes, int decimals = 0}) {
    if (bytes <= 0) return "0 Bytes";
    const suffixes = ["Bytes", "KB", "MB", "GB", "TB"];
    var i = (log(bytes) / log(1024)).floor();
    return ((bytes / pow(1024, i)).toStringAsFixed(decimals)) + suffixes[i];
  }

  Future<Null> _pickImage() async {
    final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    imageFile = pickedImage != null ? File(pickedImage.path) : null;
    if (imageFile != null) {
      var result = getFileSizeString(bytes: imageFile!.lengthSync());
      if (result.contains('KB')) {
        if (int.parse(result.substring(0, result.length - 2)) < 50) {
          _onWillPop('Image quality too low, kindly upload best quality image for better result...');
        } else {
          setState(() {
            isLoading = true;
            predictSong();
            if (isRewardedAdReady) {
              _rewardedAd?.show(
                  onUserEarnedReward: (RewardedAd ad, RewardItem item) {});
            } else {
              toastShow('Ad not work');
              _loadRewardedAd();
            }
            animationController.forward();
          });
        }
      } else {
        setState(() {
          isLoading = true;
          predictSong();
          if (isRewardedAdReady) {
            _rewardedAd?.show(
                onUserEarnedReward: (RewardedAd ad, RewardItem item) {});
          } else {
            toastShow('Ad not work');
            _loadRewardedAd();
          }
          animationController.forward();
        });
      }
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
          _rewardedAd?.show(
              onUserEarnedReward: (RewardedAd ad, RewardItem item) {});
        } else {
          toastShow('Ad not work');
          _loadRewardedAd();
        }
        animationController.repeat();
      });
      imageFile = croppedFile;
  /*    if (songs == 'bamboleo') {
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
      }*/
    }
  }

  predictSong() async {
    Map<String,String> bodyMap ={
      'id':SharedPref.getSongId(),
      'type':SharedPref.getSongPremium()
    };
    HttpRequest request = HttpRequest();
    var result = await request.predictNp(context,bodyMap, imageFile);
    if (result != null) {
      if (result == 504 ||result == 500) {
        snackShow(context, '$result Server Error try again later...');
        setState(() {
          isLoading = false;
          percentage = animationController.value * 0;
          animationController.value = 0;
        });

      }
      else {
        var dir = await getExternalStorageDirectory();
        List values = await dir!.list().toList();
        timer = Timer.periodic(Duration(seconds: 1), (_) {
          for (int i = 0; i < values.length; i++) {
            if (values[i].toString().contains(result.path.toString())) {
              timer!.cancel();
              Future.delayed(Duration(seconds: 10), () {
                Navigator.pushNamed(context, '/video_players', arguments: {
                  'file': '${result.path}',
                });
                setState(() {
                  isLoading = false;
                  print('percentage bf $percentage');
                  percentage = animationController.value * 0;
                   animationController.value = 0;
                  print('percentage af $percentage');
                });
              });
            }
          }
        });
      }
    }
    else {
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

  void _onWillPop(image) async {
    if (Platform.isIOS) {
      await showDialog(
          context: context,
          builder: (context) => CupertinoAlertDialog(
                title: Text('Warning!!!',style: TextStyle(fontSize: 16.0),),
                content: Container(
                  child: Text('$image'),
                ),
                actions: <Widget>[
                  CupertinoDialogAction(
                    child: Text('Ok'),
                    onPressed: () => Navigator.of(context).pop(false),
                  ),
                ],
              ));
    } else {
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Warning!!!',style: TextStyle(fontSize: 16.0),),

          backgroundColor: Color(0xffe8f6fa),
          actionsPadding: EdgeInsets.symmetric(horizontal: 24.0),
          content: Container(
            child: Text('$image'),
          ),
          actions: <Widget>[
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor:MaterialStateProperty.all(Colors.deepOrange)
              ),
              onPressed: () => Navigator.of(context).pop(false),
              child: new Text('Ok'),
            ),
          ],
        ),
      );
    }
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer?.cancel();
    _timer!.cancel();
    animationController.dispose();
  }
}
