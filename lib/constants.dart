import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

var kTestMargin =EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0);
var kTestPadding =EdgeInsets.symmetric(horizontal: 12.0);



var kBoxDecorate = BoxDecoration(
  borderRadius: BorderRadius.circular(8.0),
  border: Border.all(color: Color(0xffFC9425)),
  color: Color(0xffFC9425),
);

var kStatusGradient =Container(
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
toastShow(text){
  Fluttertoast.showToast(
      msg: text,
      toastLength:
      Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor:
      Color(0xff18726a),
      textColor: Colors.white,
      fontSize: 12.0);
}