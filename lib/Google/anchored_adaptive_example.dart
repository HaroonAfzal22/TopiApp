import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

/// This example demonstrates anchored adaptive banner ads.
///
/// Loads an anchored adaptive banner ad and displays it at the bottom of the
/// screen. This also handles loading a new ad on orientation change.
class AnchoredAdaptiveExample extends StatefulWidget {
  @override
  _AnchoredAdaptiveExampleState createState() =>
      _AnchoredAdaptiveExampleState();
}

class _AnchoredAdaptiveExampleState extends State<AnchoredAdaptiveExample> {
  BannerAd? _anchoredAdaptiveAd;
  bool _isLoaded = false;
  late Orientation _currentOrientation;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _currentOrientation = MediaQuery.of(context).orientation;
    _loadAd();
  }

  /// Load another ad, disposing of the current ad if there is one.
  Future<void> _loadAd() async {
    await _anchoredAdaptiveAd?.dispose();
    setState(() {
      _anchoredAdaptiveAd = null;
      _isLoaded = false;
    });

    final AnchoredAdaptiveBannerAdSize? size =
    await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
        MediaQuery.of(context).size.width.truncate());

    if (size == null) {
      print('Unable to get height of anchored banner.');
      return;
    }

    _anchoredAdaptiveAd = BannerAd(
      adUnitId: Platform.isAndroid
          ? 'ca-app-pub-3940256099942544/6300978111'
          : 'ca-app-pub-3940256099942544/2934735716',
      size: size,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          print('$ad loaded: ${ad.responseInfo}');
          setState(() {
            // When the ad is loaded, get the ad size and use it to set
            // the height of the ad container.
            _anchoredAdaptiveAd = ad as BannerAd;
            _isLoaded = true;
          });
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('Anchored adaptive banner failedToLoad: $error');
          ad.dispose();
        },
      ),
    );
    return _anchoredAdaptiveAd!.load();
  }

  /// Gets a widget containing the ad, if one is loaded.
  ///
  /// Returns an empty container if no ad is loaded, or the orientation
  /// has changed. Also loads a new ad if the orientation changes.
  Widget _getAdWidget() {
    return OrientationBuilder(
      builder: (context, orientation) {
        if (_currentOrientation == orientation &&
            _anchoredAdaptiveAd != null &&
            _isLoaded) {
          return Container(
            color: Colors.green,
            width: _anchoredAdaptiveAd!.size.width.toDouble(),
            height: _anchoredAdaptiveAd!.size.height.toDouble(),
            child: AdWidget(ad: _anchoredAdaptiveAd!),
          );
        }
        // Reload the ad if the orientation changes.
        if (_currentOrientation != orientation) {
          _currentOrientation = orientation;
          _loadAd();
        }
        return Container();
      },
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text('Anchored adaptive banner example'),
    ),
    body: Center(
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: <Widget>[
          ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemBuilder: (context, index) {
                return Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod'
                      ' tempor incididunt ut labore et dolore magna aliqua. Faucibus purus in'
                      ' massa tempor. Quis enim lobortis scelerisque fermentum dui faucibus'
                      ' in. Nibh praesent tristique magna sit amet purus gravida quis.'
                      ' Magna sit amet purus gravida quis blandit turpis cursus in. Sed'
                      ' adipiscing diam donec adipiscing tristique. Urna porttitor rhoncus'
                      ' dolor purus non enim praesent. Pellentesque habitant morbi tristique'
                      ' senectus et netus. Risus ultricies tristique nulla aliquet enim tortor'
                      ' at.',
                  style: TextStyle(fontSize: 24),
                );
              },
              separatorBuilder: (context, index) {
                return Container(height: 40);
              },
              itemCount: 5),
          _getAdWidget(),
        ],
      ),
    ),
  );

  @override
  void dispose() {
    super.dispose();
    _anchoredAdaptiveAd?.dispose();
  }
}