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
  bool isVisible = true,isDownloaded=false;
  bool isLoading = false;
  var activeIndex = 0;
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoading = true;

    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      getCommunity();
    });

    indexes = List<int>.filled(values.length, 0);
    listing = List<int>.filled(values.length, 0);
    isLikedCount = List<int>.filled(values.length, 0);
    isLiked = List<bool>.filled(values.length, false);
    isDescClick = List<bool>.filled(values.length, false);

    testingVideoLink();
  }
  void testingVideoLink() async {
    String uriPrefix = 'https://wasisoft.page.link';
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: uriPrefix,
      link: Uri.parse('https://www.youtube.com/watch?v=_SB7h2kB6Eg'),
    );

    final ShortDynamicLink shortDynamicLink = await FirebaseDynamicLinks.instance.buildShortLink(parameters);
    Uri uri = shortDynamicLink.shortUrl;
    Share.share(uri.toString(), subject: '...');
  }

  getCommunity() async {
    HttpRequest request = HttpRequest();
    var result = await request.getCommunity(context);
    for (int i = 0; i < result.length; i++) {
      controller?.insert(i, BetterPlayerListVideoPlayerController());
    }
    setState(() {
      data = result;

      isLoading = false;
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
                onPageChanged: (index) {
                  controller!.forEach((controllers) => controllers.pause());
                  controller![index].play();
                  if(data.length-1==index){
                    print('last and equal');
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
                          Positioned(
                              bottom: 420,
                              left: MediaQuery.of(context).size.width - 55,
                              child: Container(
                               child:CircleAvatar(
                                 radius: 26,
                                 backgroundColor:Colors.deepOrange,
                                 child: CircleAvatar(
                                   radius: 25.0,
                                   child: Image.asset('assets/topi.png',
                                   ),
                                 ),
                               ),
                              )),
                          StackDesign(bottomMargin: 360.0,leftMargin: 55,ikon:CupertinoIcons.heart_solid,onClick: (){},),

                          StackDesign(bottomMargin: 290.0,leftMargin: 55,ikon:FontAwesomeIcons.commentDots,onClick: (){},),

                          StackDesign(bottomMargin: 220.0,leftMargin: 55,ikon:CupertinoIcons
                              .arrowshape_turn_up_right_fill,onClick: (){
                            _onShare(context, data[index]['video']);

                          },),

                          StackDesign(bottomMargin: 150.0,leftMargin: 60,ikon:FontAwesomeIcons.download,onClick: (){
                            _onSave(context, data[index]['video']);
                          },),

                          Positioned(
                              bottom: 50,
                              left: MediaQuery.of(context).size.width - 85,
                              child: InkWell(
                                onTap: ()async{
                                  await SharedPref.setSongId(data[index]['modal_id'].toString());
                                  await SharedPref.setSongPremium(data[index]['premium'].toString());
                                  Navigator.pushNamed(context, '/image_pickers');
                                },
                                child: Container(
                                  height: 100,
                                  child: Lottie.asset('assets/cd_animation.json',
                                      repeat: true, animate: true),
                                ),
                              )),
                          Positioned(
                              bottom: 100,
                              right: MediaQuery.of(context).size.width - 85,
                              child: Container(
                                child: Text('@Topi.Ai official',style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.bold
                                ),),
                              ),
                          ),
                          Positioned(
                            bottom: 80,
                            right: MediaQuery.of(context).size.width - 20,
                            child: Container(
                              child: Icon(CupertinoIcons.music_note_2,color: Colors.white,size: 14,),
                            ),
                          ),
                          Positioned(
                            bottom: 80,
                            right: MediaQuery.of(context).size.width - 100,
                            left: MediaQuery.of(context).padding.left+22,
                            child: Container(
                              height: 15,
                              child: Marquee(
                                text: '${data[index]['video_name']}',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w700
                              ),
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

  /*    SizedBox(
                        height: 4.0,
                      ),
                      Container(
                        alignment: Alignment.topCenter,
                        child: AnimatedSmoothIndicator(
                          count: 1,
                          activeIndex:
                              1 */
  /*int.parse(data[index]['media'][activeIndex])*/
  /*,
                          effect: WormEffect(
                              offset: 8.0,
                              spacing: 4.0,
                              radius: 8.0,
                              dotWidth: 8.0,
                              dotHeight: 8.0,
                              paintStyle: PaintingStyle.fill,
                              strokeWidth: 1.0,
                              dotColor: Colors.grey,
                              activeDotColor: Colors.indigo),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isLiked[index] == true
                                        ? isLiked[index] = false
                                        : isLiked[index] = true;
                                    isLiked[index] == true
                                        ? isLikedCount[index]++
                                        : isLikedCount[index]--;
                                  });
                                },
                                icon: isLiked[index] == true
                                    ? Icon(
                                        CupertinoIcons.heart_fill,
                                        color: Color(0xffd80000),
                                      )
                                    : Icon(CupertinoIcons.heart)),
                          ),
                          Expanded(
                              child: IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.send))),
                          Expanded(
                              flex: 5,
                              child: Padding(
                                padding: EdgeInsets.only(right: 8.0),
                                child: Text(
                                  '${data[index]['likes']} likes',
                                  textAlign: TextAlign.end,
                                ),
                              )),
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            right: 8.0, left: 8.0, bottom: 8.0),
                        child: InkWell(
                          child: RichText(
                              maxLines:
                                  isDescClick[index] == true ? null : 2,
                              overflow: isDescClick[index] == true
                                  ? TextOverflow.visible
                                  : TextOverflow.ellipsis,
                              text: TextSpan(
                                  children: [
                                TextSpan(
                                    text: 'Topi ',
                                    style: TextStyle(
                                        fontSize: 12.0,
                                        color: Color(0xff262626),
                                        fontWeight: FontWeight.bold)),
                                TextSpan(
                                    text: '${data[index]['desc']}',
                                    style: TextStyle(
                                      fontSize: 10.0,
                                      color: Color(0xff262626),
                                    )),
                              ]),),
                          onTap: () {
                            setState(() {
                              isDescClick[index] == true
                                  ? isDescClick[index] = false
                                  : isDescClick[index] = true;
                            });
                          },
                        ),
                      ),*/

  /*  Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: titleIcon('assets/topi.png', 16.0),
                            ),
                            Expanded(
                              flex: 8,
                              child: Text(
                                'Topi',
                                textAlign: TextAlign.start,
                                maxLines: 2,
                                style: TextStyle(
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff262626)),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTapDown: (TapDownDetails details) async {
                                  await showMenuDialog(
                                      context, details.globalPosition);
                                  setState(() {
                                    // isLoading = true;
                                    // postApplicationStatus(listValue[index]['id'], value);
                                  });
                                },
                                child: Icon(
                                  Icons.more_vert_sharp,
                                  color: Color(0xff262626),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 4.0,
                        ),*/
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
      var paths=  await GallerySaver.saveVideo(value.path);
      if (paths.toString().isNotEmpty) {
        toastShow('Video Saved in gallery!');
        isDownloaded=true;
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

      await Share.share(image,
       /*   sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size*/);
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
  final bottomMargin,leftMargin,ikon,onClick;
   StackDesign({
    required this.bottomMargin,
    required this.leftMargin,
    required this.ikon,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: bottomMargin,
        left: MediaQuery.of(context).size.width - leftMargin,
        child: InsideStacks(icons: ikon,onPress: onClick,));
  }
}

class InsideStacks extends StatelessWidget {
  final onPress,icons;
  const InsideStacks({
  required this.icons,
  required this.onPress,
  }) ;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: IconButton(
          onPressed: onPress,
          icon: FaIcon(
            icons,
            color: Colors.white,
            size: 30,
          )),
    );
  }
}
