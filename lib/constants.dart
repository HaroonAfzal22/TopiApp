import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';

var kTestMargin = EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0);
var kTestPadding = EdgeInsets.symmetric(horizontal: 12.0);

var kBoxDecorate = BoxDecoration(
  borderRadius: BorderRadius.circular(8.0),
  border: Border.all(color: Color(0xffFC9425)),
  color: Color(0xffFC9425),
);

var kStatusGradient = Container(
  decoration: BoxDecoration(
    gradient: LinearGradient(
      colors: [
        Color(0xffFCCC44),
        Color(0xffDC3843),
        Color(0xffFC9425),
      ],
    ),
  ),
);

toastShow(text) {
  Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.white,
      textColor: Color(0xffFC9425),
      fontSize: 12.0);
}

snackShow(context, text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.orangeAccent,
      duration: const Duration(milliseconds: 3000), // default 4s
      content: Text(
        '$text',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16.0
        ),
      ),
    ),
  );
}

var spinkit = SpinKitFadingCircle(
  color: Colors.orangeAccent,
  size: 50.0,
);