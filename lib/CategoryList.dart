import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:topi/Gradient.dart';
import 'package:topi/constants.dart';

class CategoryList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        systemOverlayStyle:
            SystemUiOverlayStyle(statusBarColor: Colors.transparent),
        title: Text(
          'Topi',
          style: TextStyle(
              color: Color(0xffFCCC44),
              fontSize: 30,
              fontWeight: FontWeight.bold),
        ),
        flexibleSpace: kStatusGradient,
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
                    print('solo card click');
                    Navigator.pushNamed(context, '/songs_list');
                  },
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    margin:
                        EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Container(
                          width: double.maxFinite,
                          height: 200,
                          child: Image.asset(
                            'assets/solo_file.gif',
                            fit: BoxFit.fill,
                          ),
                        ),
                        ListView(
                          shrinkWrap: true,
                          children: [
                            Container(
                              height: 20,
                              width: double.maxFinite,
                              color: Colors.white24,
                              child: Text(
                                'solo'.toUpperCase(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Container(
                              height: 20,
                              width: double.maxFinite,
                              color: Colors.white24,
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
                    Navigator.pushNamed(context, '/songs_list');
                  },
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    margin:
                        EdgeInsets.symmetric(vertical: 4.0, horizontal: 12.0),
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Container(
                          width: double.maxFinite,
                          height: 200,
                          child: Image.asset(
                            'assets/combo.gif',
                            fit: BoxFit.fill,
                          ),
                        ),
                        ListView(
                          shrinkWrap: true,
                          children: [
                            Container(
                              height: 20,
                              width: double.maxFinite,
                              color: Colors.white24,
                              child: Text(
                                'combo'.toUpperCase(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Container(
                              height: 20,
                              width: double.maxFinite,
                              color: Colors.white24,
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
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Container(
                          width: double.maxFinite,
                          height: 200,
                          child: Image.asset(
                            'assets/squad.gif',
                            fit: BoxFit.fill,
                          ),
                        ),
                        ListView(
                          shrinkWrap: true,
                          children: [
                            Container(
                              height: 20,
                              width: double.maxFinite,
                              color: Colors.white24,
                              child: Text(
                                'Group'.toUpperCase(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Container(
                              height: 20,
                              width: double.maxFinite,
                              color: Colors.white24,
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
                    Navigator.pushNamed(context, '/songs_list');
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
