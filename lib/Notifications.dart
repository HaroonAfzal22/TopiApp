
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lottie/lottie.dart';
import 'package:topi/Gradient.dart';
import 'package:topi/HttpRequest.dart';
import 'package:topi/Shared_Pref.dart';
import 'package:topi/SongsLists.dart';
import 'package:topi/constants.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {

  bool isLoading=false,isListEmpty=false;
  List songsList = [];
  BannerAd? myBanner = BannerAd(
      size: AdSize.banner,
      adUnitId: SharedPref.getBannerAd()??"",
      listener: BannerAdListener(),
      request: AdRequest());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myBanner!.load();
    getNotificationList();
  }


  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      extendBody: true,
      body: isLoading
          ? Center(
        child: spinkit,
      ) : SafeArea(
        bottom: false,
        child: BackgroundGradient(
          childView: isLoading
              ? Center(
            child: spinkit,
          )
              :isListEmpty? Center(
            child: Lottie.asset('assets/empty.json',
                repeat: true, reverse: true, animate: true),
          ):Stack(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 110.0),
                child: RefreshIndicator(
                  onRefresh: getNotificationList,
                  child: ListView(
                    physics: AlwaysScrollableScrollPhysics(),
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height,
                        child: Container(
                          child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: songsList.length,
                            itemBuilder: (context, index) {
                              return NotificationsLists(
                                songsList: songsList,
                                selected: ()async{
                                  print('clicck select');
                                  await SharedPref.setSongId(
                                      songsList[index]['id'].toString());
                                  await SharedPref.setSongPremium(
                                      songsList[index]['premium'].toString());
                                  Navigator.pushNamed(context, '/image_pickers');

                                }, index: index,);
                            },
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ),
              Positioned(
                bottom: 55.0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  child: AdWidget(
                    ad: myBanner!,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
 /* */
 Future<void> getNotificationList() async {
    HttpRequest request = HttpRequest();
    var songs = await request.getNotifications(context);

    setState(() {
      if (songs ==null ||songs.isEmpty) {
        toastShow('Data List is Empty ..');
        isLoading = false;
        isListEmpty=true;
      } else if(songs.toString().contains('Error')){
        toastShow('${songs.toString()}');
        isLoading = false;
      }else{
        songsList = songs;
        isLoading = false;
        isListEmpty=false;
      }
    });

  }
}


class NotificationsLists extends StatelessWidget {

  final index, selected,songsList;
  @override

  NotificationsLists({this.index, this.selected, this.songsList});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      child: Card(
        shape: new RoundedRectangleBorder(
            side: new BorderSide(width: 1.0),
            borderRadius: BorderRadius.circular(20.0)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            gradient: LinearGradient(
              colors: [
                Color(int.parse(
                    '0xff${songsList[index]['color'].toString().split(',').elementAt(0).substring(1, songsList[index]['color'].toString().split(',').elementAt(0).length)}')),
                Color(int.parse(
                    '0xff${songsList[index]['color'].toString().split(',').elementAt(1).substring(1, songsList[index]['color'].toString().split(',').elementAt(0).length)}')),
                Color(int.parse(
                    '0xff${songsList[index]['color'].toString().split(',').elementAt(2).substring(1, songsList[index]['color'].toString().split(',').elementAt(0).length)}')),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child:ListTile(
            title: Text('${songsList[index]['video_name']}',textAlign: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 18.0,fontWeight: FontWeight.bold)),
            subtitle: Text('${songsList[index]['message']}',textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white,fontSize: 12.0,fontWeight: FontWeight.w500),),
            onTap: selected,
          ),



          /* Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Icon(
                      clickIcon(widget.index),
                      size: 40.0,
                      color: Colors.white,
                      *//* onPressed: () {
                                                          setState(() {
                                                            if (isClick.contains(true)) {
                                                              if (isClick[widget.index] == true) {
                                                                isClick[index] = false;
                                                                print('stop');
                                                                stop();
                                                              } else {
                                                                isClick = List.filled(widget.songsList.length, false);
                                                                isClick[index] = true;
                                                                print('play isclick false');                                                                                       play(widget.songsList[index]['audio']);
                                                              }
                                                            } else {
                                                              isClick[index] = true;
                                                              print('play isClick not contain');
                                                              play(widget.songsList[index]['audio']);
                                                            }
                                                          });
                                                        },*//*
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 12.0),
                          child: Text(
                            'Title: ${widget.songsList[widget.index]['video_name']}',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 18.0),
                          ),
                        ),
                        *//*  Container(
                                                      child: Center(
                                                        child: Text(
                                                          singersList[index],
                                                          style: TextStyle(
                                                              fontSize: 12.0,
                                                              color: Colors.white),
                                                        ),
                                                      ),
                                                    ),*//*
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),*/
        ),
      ),
    );
  }
}

