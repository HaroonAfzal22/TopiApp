import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:topi/starter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Color(0xffFCCC44),
    statusBarIconBrightness:
        Brightness.light, //or set color with: Color(0xFF0000FF)
  ));
  runApp(MyApp());
  // color used code  #FCCC44 as like yellow, #FC9425 like orange,#DC3843 like red
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/starter': (context) => StartScreen(),
      },
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  bool isClick=false;
  bool isVisible=false;
  var texts='not Click', iconsValue=Icons.keyboard_arrow_down;

  onClick(){
    setState(() {
      if(isClick){
        iconsValue =Icons.clear;
        texts = 'not Clicked';
        isClick=false;
        isVisible=false;
        print('click  $texts');
      }else{
        iconsValue =Icons.keyboard_arrow_down;
        texts = ' Clicked';
        isClick=true;
        isVisible=true;
        print('clicked at');
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Color(0xffFC9425),
          onPressed: () {  },
          child: Text('T', style: TextStyle(
            fontFamily: 'FredokaOne',
            fontSize: 40.0
          ),),
        ),
        body: Container(
          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.only(right: 12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 80.0),
                      child: Text(
                        'Topi'.toUpperCase(),
                        style: TextStyle(
                          fontSize: 24.0,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold,
                          color: Color(0xffFC9425),
                        ),
                      ),
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(
                            vertical: 0.0, horizontal: 20.0),
                        side: BorderSide(
                          color: Color(0xffFCCC44),
                          width: 0.5,
                        ),
                      ),
                      onPressed: () {},
                      child: Text(
                        'Premium',
                        style: TextStyle(
                          color: Color(0xffDC3843),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 40,
                  decoration: BoxDecoration(
                    color: Color(0xffFC9425),
                  border: Border.all(color: Color(0xffFC9425)),
                  borderRadius: BorderRadius.circular(8),
                ),
                margin: EdgeInsets.all(12.0),
                child: ListTile(
                  visualDensity: VisualDensity(vertical: -4),
                  leading: Text(texts,style: TextStyle(color: Colors.white),),
                  trailing:Icon(iconsValue,color: Colors.white,) ,
                  onTap:() {
                    setState(() {
                      onClick();
                    });
                  } ,
                )
              ),
              Visibility(
                visible: isClick,
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 15,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: <Widget>[
                          Container(
                              height: 40,
                              decoration: BoxDecoration(
                                color: Color(0xffFC9425),
                                border: Border.all(color: Color(0xffFC9425)),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              margin: EdgeInsets.only(top: 4.0,right: 12.0,left: 12.0),
                              child: ListTile(
                                visualDensity: VisualDensity(vertical: -4),
                                leading: Text('List of songs category',style: TextStyle(color: Colors.white),),
                                onTap:() {
                                  setState(() {
                                    isClick=false;
                                    texts='not clicked';
                                  });
                                } ,
                              )
                          ),
                            Divider(height: 8,indent: 14,endIndent: 14,)
                        ],
                      );
                    }),
              ),
              Visibility(
                visible: isVisible,
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: 15,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: <Widget>[
                          Container(
                              height: 40,
                              decoration: BoxDecoration(
                                color: Color(0xffFC9425),
                                border: Border.all(color: Color(0xffFC9425)),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              margin: EdgeInsets.only(top: 4.0,right: 12.0,left: 12.0),
                              child: ListTile(
                                visualDensity: VisualDensity(vertical: -4),
                                leading: Text('List of songs',style: TextStyle(color: Colors.white),),
                                onTap:() {
                                  setState(() {
                                    isVisible=false;
                                    texts='not clicked';
                                  });
                                } ,
                              )
                          ),
                          Divider(height: 8,indent: 14,endIndent: 14,)
                        ],
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
