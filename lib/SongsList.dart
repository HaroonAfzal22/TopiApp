import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:new_version/new_version.dart';
import 'package:topi/CategoryLists.dart';
import 'package:topi/Gradient.dart';
import 'package:topi/HttpRequest.dart';
import 'package:topi/ListCards.dart';
import 'package:topi/NavigationDrawer.dart';
import 'package:topi/Shared_Pref.dart';
import 'package:topi/SongsLists.dart';
import 'package:topi/constants.dart';

import 'package:audioplayers/audioplayers.dart';
import 'package:unique_identifier/unique_identifier.dart';
List cList = [];

class SongsList extends StatefulWidget {
  @override
  _SongsListState createState() => _SongsListState();
}

class _SongsListState extends State<SongsList> with WidgetsBindingObserver {
  List europeanCountries = [],songsList = [];
  int? categoryId,indexValue;
 /* final singersList = [
    'Artist: Gipsy Kings',
    'Artist: Naseebo Lal',
    'Artist: Naseebo Lal',
    'Artist: Yo Yo Honey Singh',
    'Artist: Sidhu Moosewala',
    'Artist: Aayat Arif',
    'Artist: Tony Kakkar',
  ];

  final europeanColors = [
    Color(0xffffc3a0),
    Color(0xff6dd5ed),
    Color(0xff753a88),
    Color(0xffdd2476),
    Color(0xff2c3e50),
    Color(0xffef629f),
    Color(0xfffaaca8),
  ];*/
  bool isEnabled = false,isLoading = false;
  AudioPlayer audioPlayer = AudioPlayer();

  List<bool> selected = [];

  fabColor() {
    if (isEnabled) {
      return Colors.white;
    } else {
      return Colors.grey;
    }
  }

  BannerAd? myBanner = BannerAd(
      size: AdSize.banner,
      adUnitId: SharedPref.getBannerAd()??"",
      listener: BannerAdListener(),
      request: AdRequest());

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance?.addObserver(this);
    super.initState();
    isLoading = true;
    Future.delayed(Duration(seconds: 4), () {
          postFcmToken();
    });
    myBanner!.load();
    getCategoryList();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      drawerScrimColor: Colors.transparent,
      floatingActionButton: isEnabled == true
          ? FloatingActionButton(
              backgroundColor: fabColor(),
              onPressed: () {
                setState(() {
                  stop();
                  selected = List.filled(songsList.length, false);
                  isClick = List.filled(songsList.length, false);
                  isEnabled = false;
                });// here i need to add some thing
                if(songsList[indexValue!]['premium']!='0' && cList.isEmpty){
                  print('IF Is Empty');
                  Navigator.pushNamed(context, '/PremiumFeature');
                } else if (songsList[indexValue!]['premium']!='0' && cList.isNotEmpty){
                  print('Else IF Is Empty');
                  Navigator.pushNamed(context, '/image_pickers');
                }
                else{
                  print('Else Is Empty');
                Navigator.pushNamed(context, '/image_pickers');}
              },
              child: FaIcon(FontAwesomeIcons.folderPlus,color: Colors.orange,),
              tooltip: 'Upload Image',
            )
          : Container(),
      bottomSheet: Padding(padding: EdgeInsets.only(bottom: 150.0)),
      body: SafeArea(
        bottom: false,
        child: BackgroundGradient(
          childView: isLoading
              ? Center(
                  child: spinkit,
                )
              : Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 110.0),
                      child: RefreshIndicator(
                        onRefresh: getCategoryList,
                        child: ListView(
                          physics: AlwaysScrollableScrollPhysics(),
                          children: [
                           CategoryLists(europeanCountries: europeanCountries, isLoading: isLoading, getSongsList: getSongsList),
                            SizedBox(
                              height: MediaQuery.of(context).size.height*0.60,
                              child: Container(
                                child: ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  itemCount: songsList.length,
                                  itemBuilder: (context, index) {
                                    // print ('Songs List printing ${songsList} ' + ' ${index}');
                                    return GestureDetector(
                                      onTap: () async {
                                        setState(() {
                                          if (selected.contains(true)) {
                                            if (selected[index] == true) {
                                              selected[index] = false;
                                              isEnabled = false;
                                              stop();
                                            } else {
                                              selected =
                                                  List.filled(songsList.length, false);
                                              selected[index] = true;
                                              isEnabled = true;
                                              play(songsList[index]['audio'],index);
                                            }
                                          } else {
                                            selected[index] = true;
                                            isEnabled = true;
                                           play(songsList[index]['audio'],index);
                                          }
                                          indexValue=index;
                                        });
                                        await SharedPref.setSongId(
                                            songsList[index]['id'].toString());
                                        await SharedPref.setSongPremium(
                                            songsList[index]['premium'].toString());
                                      },
                                      child: SongsLists(
                                        songsList: songsList,
                                        selected: selected,
                                        clickIcon: clickIcon,
                                        index: index,
                                        pClick: (){
                                        Navigator.pushNamed(context, '/PremiumFeature');
                                        },
                                        pVisible: songsList[index]['premium']=='1'?true:false,
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 50.0,
                      child: Container(
                        padding: EdgeInsets.only(bottom: 5.0),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height*0.10,
                        child: AdWidget(
                          ad:myBanner!,
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  play(index,pos) async {
    int result = await audioPlayer.play(index, volume: 10.0);
    if (result == 1) {
      audioPlayer.onPlayerCompletion.listen((event) {
        setState(() {
          if (selected.contains(true)) {
            if (selected[pos] == true) {
              selected[pos] = false;
              isEnabled = false;
              stop();
            } else {
              selected = List.filled(songsList.length, false);
              selected[pos] = true;
              isEnabled = true;
            }
          }
        });
      });
    }
  }

  stop() async {
    int result = await audioPlayer.stop();
    if (result == 1) {
    }
  }

  List<bool> isClick = [];

  clickIcon(index) {
    if (selected[index] == true) {
      return CupertinoIcons.pause;
    } else {
      return CupertinoIcons.play_fill;
    }
  }

  void postFcmToken() async {
    HttpRequest request = HttpRequest();
    String? identity= await UniqueIdentifier.serial;
    Map map ={
      'imei':identity.toString(),
      'token':SharedPref.getUserFcmToken().toString(),
    };
    var result = await request.postFcmToken(context,map);

  }
//b66bbba48c531a7a //b66bbba48c531a7a
  Future<void> getCategoryList() async {
    HttpRequest request = HttpRequest();
    var result = await request.getCategories(context);
    setState(() {
      if(result==null ||result.isEmpty){
        toastShow('Category List is Empty');
        isLoading=false;
      }else if(result.toString().contains('Error')) {
        toastShow('${result.toString()}');
         isLoading = false;
      }else{
        europeanCountries = result;
        categoryId = result[0]['id'];
      }
    });

    getSongsList(categoryId!);
  }

  void getSongsList(int id) async {
    HttpRequest request = HttpRequest();
    var songs = await request.getSongsList(context, id);

    setState(() {
      if (songs ==null ||songs.isEmpty) {
        toastShow('Songs List is Empty ..');
          isLoading = false;
      } else if(songs.toString().contains('Error')){
        toastShow('${songs.toString()}');
        isLoading = false;
      }else{
        songsList = songs;
        selected = List.filled(songs.length, false);
        isClick = List.filled(songs.length, false);
        isLoading = false;
      }
    });

  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    myBanner!.dispose();
    audioPlayer.stop();
  }



  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async{
    // TODO: implement didChangeAppLifecycleState
    switch (state) {
      case AppLifecycleState.resumed:
        print("app in resumed");
        //Play the Music
        break;
      case AppLifecycleState.inactive:
        print("app in inactive");
        //Stop the music
        break;
      case AppLifecycleState.paused:
        print("app in paused");
        await audioPlayer.stop();
        await  audioPlayer.dispose();
        break;
      case AppLifecycleState.detached:
        print("app in detached");
        await audioPlayer.stop();
        await  audioPlayer.dispose();
        //Stop the music
        break;
    }
  }


}