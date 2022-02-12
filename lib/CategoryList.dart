import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:topi/Gradient.dart';
import 'package:topi/constants.dart';


// card category list solo,combo,group
class CategoryList extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        elevation: 0.0,
        title: Image.asset('assets/topi.png',
          fit: BoxFit.contain,
          width: 80,
          height: 80,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: BackgroundGradient(
          childView: ListView(
            children: [
              SizedBox(
                height: 15,
              ),
              Container(
                height: 200,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/songs_list');
                  },
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    margin:
                        EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: double.maxFinite,
                          height: 140,
                          child: Image.asset(
                            'assets/solo.gif',
                            fit: BoxFit.fill,
                          ),
                        ),
                        ListView(
                          shrinkWrap: true,
                          children: [
                            Container(
                              height: 27,
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xffFCCC44),
                                    Color(0xffDC3843),
                                    Color(0xffFC9425),
                                  ],
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 6.0),
                                child: Text(
                                  'solo'.toUpperCase(),
                                  style: TextStyle(
                                      color: Color(0xffFCCC44),
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            Container(
                              height: 25,
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xffFCCC44),
                                    Color(0xffDC3843),
                                    Color(0xffFC9425),
                                  ],
                                ),
                              ),
                              child: Text(
                                'now you can sing independently',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                height: 200,
                child: GestureDetector(
                  onTap: () {
                    print('combo card click');
                    //Navigator.pushNamed(context, '/songs_list');
                    snackShow(context, 'Coming Soon..');
                  },
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    margin:
                        EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: double.maxFinite,
                          height: 140,
                          child: Image.asset(
                            'assets/combo.gif',
                            fit: BoxFit.fill,
                          ),
                        ),
                        ListView(
                          shrinkWrap: true,
                          children: [
                            Container(
                              height: 27,
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xffFCCC44),
                                    Color(0xffDC3843),
                                    Color(0xffFC9425),
                                  ],
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 6.0),
                                child: Text(
                                  'combo'.toUpperCase(),
                                  style: TextStyle(
                                      color: Colors.orangeAccent,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            Container(
                              height: 25,
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xffFCCC44),
                                    Color(0xffDC3843),
                                    Color(0xffFC9425),
                                  ],
                                ),
                              ),
                              child: Text(
                                'now you can sing with love ',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                height: 200,
                child: GestureDetector(
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    margin:
                        EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: double.maxFinite,
                          height: 140,
                          child: Image.asset(
                            'assets/squad.gif',
                            fit: BoxFit.fill,
                          ),
                        ),
                        ListView(
                          shrinkWrap: true,
                          children: [
                            Container(
                              height: 27,
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xffFCCC44),
                                    Color(0xffDC3843),
                                    Color(0xffFC9425),
                                  ],
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(top: 6.0),
                                child: Text(
                                  'Group'.toUpperCase(),
                                  style: TextStyle(
                                      color: Colors.orangeAccent,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                            Container(
                              height: 25,
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Color(0xffFCCC44),
                                    Color(0xffDC3843),
                                    Color(0xffFC9425),
                                  ],
                                ),
                              ),
                              child: Text(
                                'now you can sing with groups',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    print('group card click');
                    snackShow(context, 'Coming Soon..');
                    // Navigator.pushNamed(context, '/songs_list');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
