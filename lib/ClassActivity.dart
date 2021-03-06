import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:topi/constants.dart';
import 'package:topi/Shared_Pref.dart';

class ClassActivity extends StatefulWidget {
  @override
  _ClassActivityState createState() => _ClassActivityState();
}

class _ClassActivityState extends State<ClassActivity> {
  var log = 'images/background.png';

  int value = 0;

  /*setLogo() {
    if (logos != null) {
      return '$logos';
    } else
      return '$log';
  }
*/
  var activeIndex = 0;
  List<bool> isLiked = [];
  List<bool> isDescClick = [];
  List<int> isLikedCount = [];
  var indexes = [],
      listing = [],
      values = [1, 2, 3, 4, 5],
      pos = [
        'https://cdn.pixabay.com/photo/2016/11/19/14/28/bed-1839564__340.jpg',
        'https://cdn.pixabay.com/photo/2015/02/04/08/03/baby-623417__340.jpg',
        'https://cdn.pixabay.com/photo/2015/06/23/09/13/music-818459__340.jpg',
        'https://cdn.pixabay.com/photo/2019/10/15/08/02/fly-4551002_960_720.jpg',
        'https://cdn.pixabay.com/photo/2020/06/22/08/27/cat-5328304__340.jpg',
        'https://cdn.pixabay.com/photo/2019/04/10/04/43/baby-4116187__340.jpg',
        'https://cdn.pixabay.com/photo/2016/06/06/21/53/child-1440526__340.jpg',
      ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    indexes = List<int>.filled(values.length, 0);
    listing = List<int>.filled(values.length, 0);
    isLikedCount = List<int>.filled(values.length, 0);
    isLiked = List<bool>.filled(values.length, false);
    isDescClick = List<bool>.filled(values.length, false);
  }

  Future<bool> _loadMore() async {
    print("onLoadMore");
    await Future.delayed(Duration(seconds: 0, milliseconds: 2000));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: SafeArea(
        bottom: false,
      /*  child: LoadMore(
          textBuilder: DefaultLoadMoreTextBuilder.english,
          onLoadMore: _loadMore,*/
          child: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              if (!indexes.contains('0')) {
                indexes[index] = index;
              } else {
                indexes[index] = index;
              }
              return Container(
                padding: EdgeInsets.only(bottom: 13.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: titleIcon('assets/topi.png', 12.0),
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
                    ),
                    Container(
                      child: CarouselSlider.builder(
                        itemCount: pos.length,
                        itemBuilder: (BuildContext context, int itemIndex,
                            int pageViewIndex) {
                          if (!listing.contains('0')) {
                            listing[index] = (itemIndex);
                          } else {
                            listing[index] = (itemIndex);

                            indexes.indexOf(index);
                          }
                          return Column(
                            children: [
                              Container(
                                child: CachedNetworkImage(
                                    fit: BoxFit.fill,
                                    filterQuality: FilterQuality.medium,
                                    height:
                                        MediaQuery.of(context).size.height / 2,
                                    imageUrl: pos[itemIndex],
                                    progressIndicatorBuilder: (context, url,
                                            downloadProgress) =>
                                        Container(
                                            margin: EdgeInsets.only(
                                                top: 180, bottom: 180),
                                            child: CircularProgressIndicator(
                                                value:
                                                    downloadProgress.progress,
                                                color: Colors.black12))),
                              ),
                              /*   Container(
                                child: AnimatedSmoothIndicator(
                                  count: 5,
                                  activeIndex: itemIndex,
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
                              ),*/
                            ],
                          );
                        },
                        options: CarouselOptions(
                          enableInfiniteScroll: false,
                          viewportFraction: 1.0,
                          height: MediaQuery.of(context).size.height / 2,
                          onPageChanged: (i, reason) => setState(() {
                            activeIndex = i;
                          }),
                        ),
                      ),
                    ),
                    /*  SizedBox(
                      height: 4.0,
                    ),
                  */ /*   Container(
                      child: AnimatedSmoothIndicator(
                        count: listing.length,
                        activeIndex: int.parse(indexes.indexOf(activeIndex).toString()),
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
                    ),*/
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
                                onPressed: () {}, icon: Icon(Icons.send))),
                        Expanded(
                            flex: 5,
                            child: Padding(
                              padding: EdgeInsets.only(right: 8.0),
                              child: Text(
                                '${isLikedCount[index]} likes',
                                textAlign: TextAlign.end,
                              ),
                            )),
                      ],
                    ),
                    Container(
                      padding:
                          EdgeInsets.only(right: 8.0, left: 8.0, bottom: 8.0),
                      child: InkWell(
                        child: RichText(
                            maxLines: isDescClick[index] == true ? null : 2,
                            overflow: isDescClick[index] == true
                                ? TextOverflow.visible
                                : TextOverflow.ellipsis,
                            text: TextSpan(children: [
                              TextSpan(
                                  text: 'Topi ',
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      color: Color(0xff262626),
                                      fontWeight: FontWeight.bold)),
                              TextSpan(
                                  text:
                                      '${isLikedCount[index]} likes loriuemnbahj hjadagbdas dkdajdsa iadashdk kjahd akjs khad kad kahd akdhad kj  jd d jkas djka djksa da dka d  jad ak dkaj dk  djka s d jd skd ka da d da d ajkak',
                                  style: TextStyle(
                                    fontSize: 10.0,
                                    color: Color(0xff262626),
                                  )),
                            ])),
                        onTap: () {
                          setState(() {
                            isDescClick[index] == true
                                ? isDescClick[index] = false
                                : isDescClick[index] = true;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
            itemCount: 5,
          ),
        ),
      //),
    );
  }

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
}
