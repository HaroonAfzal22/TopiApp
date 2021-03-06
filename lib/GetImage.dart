import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:image/image.dart' as Im;
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
import 'package:permission_handler/permission_handler.dart';
import 'package:topi/Gradient.dart';
import 'package:topi/HttpRequest.dart';
import 'package:topi/Shared_Pref.dart';
import 'package:topi/constants.dart';

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
  bool isLoading = false, isAnimate = false;
  bool isPlaying = false;
  bool isAdLoaded = false;
  var imagePaths;
  final AdSize adSize = AdSize(width: 320, height: 250);
  BannerAd? myBanner = BannerAd(
      size: AdSize.mediumRectangle,
      adUnitId: SharedPref.getBannerAd(),
      listener: BannerAdListener(),
      request: AdRequest());
  BannerAd? myBanners = BannerAd(
      size: AdSize.mediumRectangle,
      adUnitId: SharedPref.getBannerAd(),
      listener: BannerAdListener(),
      request: AdRequest());
  int pos = 0;
  List userAnswer = [
    'Where you can see a lot of new features...',
    'Now Image is Processing to do some Magic...',
    'Creating your magical image into video...',
  ];
  List imageDownload = [
    'Downloading your magical image to video creation...',
    'Where you can see your singing selfie that\'s amazing ...',
    'Just wait a little bit for ...',
  ];
  Timer? _timer, timer;
  var songs;
  NativeAd? myNative, myNatives, nativeAd;
  InterstitialAd? _interstitialAd;
  RewardedAd? _rewardedAd;
  bool isInterstitialAdReady = false;
  bool isRewardedAdReady = false;
  late AnimationController animationController;
  double? percentage;
  String? responses;

  @override
  void initState() {
    super.initState();

    isPlaying = true;
    state = AppState.free;
    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 20),
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
          ad.dispose();
        },
      ),
    );
    nativeAd = NativeAd(
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
          ad.dispose();
        },
      ),
    );
    myNatives = NativeAd(
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
          ad.dispose();
        },
      ),
    );
    setState(() {
      myNative!.load();
      myNatives!.load();
      nativeAd!.load();
    });
    myBanner!.load();
    myBanners!.load();
    _loadInterstitialAd();
    _loadRewardedAd();
    setTimer();
    Future.delayed(Duration(seconds: 3), () {
      setState(() {
        isPlaying = false;
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
          child: isAnimate
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        height: MediaQuery.of(context).size.width * 0.5,
                        child: Lottie.asset('assets/uploading.json',
                            repeat: true, reverse: true, animate: true),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 60.0),
                        margin: EdgeInsets.only(top: 20.0),
                        child: Text(
                          'Your image is uploading please wait...',
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.deepOrange,
                            fontSize: 18.0,
                          ),
                        ),
                      ),
                    ),
                    isAdLoaded
                        ? Container(
                            alignment: Alignment.bottomCenter,
                            color: Colors.white,
                            width: MediaQuery.of(context).size.width,
                            height: 50,
                            child: AdWidget(
                              ad: myNatives!,
                            ),
                          )
                        : Text('loading...')
                  ],
                )
              : imageFile != null
                  ? isLoading
                      ? Container(
                          margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height / 5.5),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              percentage!.toStringAsFixed(0) == '100'
                                  ? Container(
                                      height: 350,
                                      child: Lottie.asset(
                                          'assets/downloading.json',
                                          repeat: true,
                                          animate: true),
                                    )
                                  : Container(),
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
                                          key:
                                              ValueKey<String>(userAnswer[pos]),
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.white),
                                        ),
                                      ),
                                    )
                                  : Container(),
                              percentage!.toStringAsFixed(0) != '100'
                                  ? Container(
                                      alignment: Alignment.center,
                                      /* width:
                                      MediaQuery.of(context).size.width * 0.7,
                                  height:
                                      MediaQuery.of(context).size.height * 0.3,*/
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 8.0,
                                      ),
                                      child: Container(
                                          child: Lottie.network(
                                              'https://assets5.lottiefiles.com/packages/lf20_mLnvYR.json',
                                              frameRate: FrameRate.max,
                                              repeat: true,
                                              animate: true)
                                          /* LiquidCircularProgressIndicator(
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
                                  ),*/
                                          ))
                                  : Container(),
                              percentage!.toStringAsFixed(0) != '100'
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
                                          '${imageDownload[pos]}',
                                          key: ValueKey<String>(
                                              imageDownload[pos]),
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.white),
                                        ),
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
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Visibility(
                                    visible: isPlaying,
                                    child: Center(child: spinkit),
                                  ),
                                  SizedBox(
                                    height: 8.0,
                                  ),
                                  ElevatedButton.icon(
                                    style: imageBtnStyle,
                                    label: Text(
                                      "Upload Image",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14.0,
                                      ),
                                    ),
                                    onPressed: !isPlaying
                                        ? () async {
                                            await _showChoiceDialog(context);
                                          }
                                        : () {},
                                    icon: Icon(FontAwesomeIcons.upload),
                                  ),
                                ],
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
                              repeat: true, animate: true),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 36.0, horizontal: 24.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Visibility(
                                visible: isPlaying,
                                child: Center(
                                  child: SizedBox(
                                      height: 25.0,
                                      width: 25.0,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2.0,
                                      )),
                                ),
                              ),
                              SizedBox(
                                height: 8.0,
                              ),
                              ElevatedButton.icon(
                                style: imageBtnStyle,
                                label: Text(
                                  "Upload Image",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14.0,
                                  ),
                                ),
                                onPressed: !isPlaying
                                    ? () async {
                                        await _showChoiceDialog(context);
                                      }
                                    : () {},
                                icon: Icon(
                                  FontAwesomeIcons.upload,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
        ),
      ),
    );
  }

  // initialize interstitial ad
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
          isInterstitialAdReady = false;
        }));
  }

  // initialize reward ad
  void _loadRewardedAd() {
    RewardedAd.load(
        adUnitId: SharedPref.getRewardedAd(),
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
          isRewardedAdReady = false;
        }));
  }

  // animation repeat process
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

  showAlertDialog() {
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierLabel: 'Dialog',
      transitionDuration: Duration(milliseconds: 400),
      pageBuilder: (_, __, ___) {
        return Scaffold(
          backgroundColor: Colors.black87,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 38.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                    flex: 4,
                    child: SizedBox.expand(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 60.0),
                        foregroundDecoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: CircleAvatar(
                          backgroundColor: Colors.deepOrange,
                          radius: 120,
                          child: CircleAvatar(
                            radius: 120 - 1,
                            backgroundImage: Image.file(
                              imageFile!,
                              fit: BoxFit.contain,
                            ).image,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                      child: Container(
                          alignment: Alignment.center,
                          child: FaIcon(
                            FontAwesomeIcons.checkCircle,
                            size: 50.0,
                            color: Colors.green,
                          ))),
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 60.0),
                      margin: EdgeInsets.only(top: 20.0),
                      child: Text(
                        'Image Upload Successfully...',
                        maxLines: 1,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.deepOrange,
                          fontSize: 18.0,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      padding: EdgeInsets.all(60.0),
                      margin: EdgeInsets.only(top: 20.0),
                      child: ElevatedButton.icon(
                        style: imageBtnStyle,
                        onPressed: () {
                          Navigator.pop(context);
                          setState(() {
                            isLoading = true;
                            if (isRewardedAdReady) {
                              _rewardedAd?.show(
                                  onUserEarnedReward:
                                      (RewardedAd ad, RewardItem item) {});
                            } else {
                              toastShow('Ad not work');
                              _loadRewardedAd();
                            }
                            animationController.forward();
                          });
                        },
                        label: Text(
                          'Create Video now',
                          style: TextStyle(fontSize: 14.0),
                        ),
                        icon: Center(child: Icon(FontAwesomeIcons.upload)),
                      ),
                    ),
                  ),
                  isAdLoaded
                      ? Container(
                          alignment: Alignment.bottomCenter,
                          color: Colors.white,
                          width: MediaQuery.of(context).size.width,
                          height: 50,
                          child: AdWidget(
                            ad: nativeAd!,
                          ),
                        )
                      : Text('loading...')
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  //pick image from camera or gallery
  _showChoiceDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              "Choose option",
              style: TextStyle(color: Colors.orangeAccent),
            ),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Divider(
                    height: 1,
                    color: Colors.orangeAccent,
                  ),
                  ListTile(
                    onTap: () {
                      _pickImage('gallery');
                    },
                    title: Text("Gallery"),
                    leading: Icon(
                      Icons.account_box,
                      color: Colors.orangeAccent,
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: Colors.orangeAccent,
                  ),
                  ListTile(
                    onTap: () {
                      _pickImage('camera');
                    },
                    title: Text("Camera"),
                    leading: Icon(
                      Icons.camera,
                      color: Colors.orangeAccent,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

// check file size
  static String getFileSizeString({required int bytes, int decimals = 0}) {
    if (bytes <= 0) return "0 Bytes";
    const suffixes = ["Bytes", "KB", "MB", "GB", "TB"];
    var i = (log(bytes) / log(1024)).floor();
    return ((bytes / pow(1024, i)).toStringAsFixed(decimals)) + suffixes[i];
  }

  // pick image from gallery and set for post
  Future<Null> _pickImage(String data) async {
    Navigator.pop(context);
    if (data == 'camera') {
      final pickedImage = await ImagePicker()
          .pickImage(source: ImageSource.camera, imageQuality: 50);
      imageFile = pickedImage != null ? File(pickedImage.path) : null;
      if (imageFile != null) {

        /*  var result = getFileSizeString(bytes: imageFile!.lengthSync());
      if (result.contains('KB')) {
        if (int.parse(result.substring(0, result.length - 2)) < 50) {
          _onWillPop('Image quality too low, kindly upload best quality image for better result...');
        }
        */
        /*else if(int.parse(result.substring(0, result.length - 2)) > 800){
          var tempDir = await getTemporaryDirectory();
          final path = tempDir.path;
          int rand = Random().nextInt(10000);

          Im.Image? image = Im.decodeImage(imageFile!.readAsBytesSync());
          var compressedImage = File('$path/img_r$rand.jpg')
          ..writeAsBytesSync(Im.encodeJpg(image!,quality: 50));

          print('compress image is kb  ${getFileSizeString(bytes: compressedImage.lengthSync())}');
          predictSong(compressedImage);
        }*/
        /*
        else {
          setState(() {
            isLoading = true;
            predictSong(imageFile);
            if (isRewardedAdReady) {
              _rewardedAd?.show(onUserEarnedReward: (RewardedAd ad, RewardItem item) {});
            } else {
              toastShow('Ad not work');
              _loadRewardedAd();
            }
            animationController.forward();
          });
        }
      } else {
        var tempDir = await getTemporaryDirectory();
        final path = tempDir.path;
        int rand = Random().nextInt(10000);

        Im.Image? image = Im.decodeImage(imageFile!.readAsBytesSync());
        var compressedImage = File('$path/img_r$rand.jpg')
          ..writeAsBytesSync(Im.encodeJpg(image!,quality: 50));

        print('compress image is mb  ${getFileSizeString(bytes: compressedImage.lengthSync())}');*/

        setState(() {
          isAnimate = true;
          predictSong(imageFile);
        });
        Future.delayed(Duration(seconds: 7), () {
          isAnimate = false;
          responses != '500' ? showAlertDialog() : null;
        });
      }

    } else {
      final pickedImage = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 50);
      imageFile = pickedImage != null ? File(pickedImage.path) : null;
      if (imageFile != null) {

        /*  var result = getFileSizeString(bytes: imageFile!.lengthSync());
      if (result.contains('KB')) {
        if (int.parse(result.substring(0, result.length - 2)) < 50) {
          _onWillPop('Image quality too low, kindly upload best quality image for better result...');
        }
        */
        /*else if(int.parse(result.substring(0, result.length - 2)) > 800){
          var tempDir = await getTemporaryDirectory();
          final path = tempDir.path;
          int rand = Random().nextInt(10000);

          Im.Image? image = Im.decodeImage(imageFile!.readAsBytesSync());
          var compressedImage = File('$path/img_r$rand.jpg')
          ..writeAsBytesSync(Im.encodeJpg(image!,quality: 50));

          print('compress image is kb  ${getFileSizeString(bytes: compressedImage.lengthSync())}');
          predictSong(compressedImage);
        }*/
        /*
        else {
          setState(() {
            isLoading = true;
            predictSong(imageFile);
            if (isRewardedAdReady) {
              _rewardedAd?.show(onUserEarnedReward: (RewardedAd ad, RewardItem item) {});
            } else {
              toastShow('Ad not work');
              _loadRewardedAd();
            }
            animationController.forward();
          });
        }
      } else {
        var tempDir = await getTemporaryDirectory();
        final path = tempDir.path;
        int rand = Random().nextInt(10000);

        Im.Image? image = Im.decodeImage(imageFile!.readAsBytesSync());
        var compressedImage = File('$path/img_r$rand.jpg')
          ..writeAsBytesSync(Im.encodeJpg(image!,quality: 50));

        print('compress image is mb  ${getFileSizeString(bytes: compressedImage.lengthSync())}');*/
        setState(() {
          isAnimate = true;
          predictSong(imageFile);
        });
        Future.delayed(Duration(seconds: 7), () {
          isAnimate = false;
          responses != '500' ? showAlertDialog() : null;
        });
      }
    }
  }

  // for crop image
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
    }
  }

  // for set image response after post
  predictSong(image) async {
    /*final bytes= File(imageFile!.path).readAsBytesSync();
    String base64Image = base64Encode(bytes);
    Uint8List base = base64Decode(base64Image);
    print('image decode ${Image.memory(base)}');*/
    Map<String, String> bodyMap = {
      'id': SharedPref.getSongId(),
      'type': SharedPref.getSongPremium(),
    };
    HttpRequest request = HttpRequest();
    var result = await request.predictNp(context, bodyMap, image);

    setState(() {
      responses = result.toString();
    });

    if (result == 504 || result == 500) {
      snackShow(context, '$result  try again later...');
      setState(() {
        isLoading = false;
        isAnimate = false;
        percentage = animationController.value * 0;
        animationController.value = 0;
      });
    } else {
      timer = Timer.periodic(Duration(seconds: 1), (_) async {
        var dir = await getExternalStorageDirectory();
        List values = await dir!.list().toList();
        for (int i = 0; i < values.length; i++) {
          if (values[i].toString().contains(result.path.toString())) {
            timer!.cancel();
            Future.delayed(Duration(seconds: 5), () {
              Navigator.pushNamed(context, '/video_players', arguments: {
                'file': '${result.path}',
              });
              setState(() {
                isLoading = false;
                percentage = animationController.value * 0;
                animationController.value = 0;
              });
            });
          }
        }
      });
    }
    /* if (result == null ||result.isEmpty) {
      print('response in $result');

      setState(() {
        toastShow('Data not Found...');
        isLoading=false;
        percentage = animationController.value * 0;
        animationController.value = 0;
        _clearImage();
      });

    }
    else if(result.toString().contains('Error')){
      setState(() {
        toastShow('$result...');
        isLoading=false;
        percentage = animationController.value * 0;
        animationController.value = 0;
        _clearImage();
      });
    }
    else {
      print('response at $result');

      var dir = await getExternalStorageDirectory();
      List values = await dir!.list().toList();
      print('values $values');
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
                percentage = animationController.value * 0;
                animationController.value = 0;
              });
            });
          }
        }
      });
    }*/
  }

  void _clearImage() {
    imageFile = null;
    setState(() {
      state = AppState.free;
    });
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer?.cancel();
    _timer!.cancel();
    animationController.dispose();
    myBanner!.dispose();
    myBanners!.dispose();
    myNative!.dispose();
    myNatives!.dispose();
    nativeAd!.dispose();
  }
}
