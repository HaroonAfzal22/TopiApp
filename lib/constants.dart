import 'package:cached_network_image/cached_network_image.dart';
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
 var imageBtnStyle= ButtonStyle(
     shape: MaterialStateProperty.all(
         RoundedRectangleBorder(
             borderRadius: BorderRadius.circular(24.0))),
     padding: MaterialStateProperty.all(
         EdgeInsets.symmetric(vertical: 12.0)),
     backgroundColor: MaterialStateProperty.all(
       Colors.deepOrange,
     ));
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
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
      ),
    ),
  );
}

var spinkit = SpinKitSpinningLines(
  color: Colors.orange,
  size: 50.0,
);

Container titleIcon(final setLogo, double d) {
  return Container(
    child: CircleAvatar(
      radius: d,
      backgroundColor: Colors.deepOrange,
      child: Image.asset(
        '$setLogo',
        fit: BoxFit.fill,
        /*  imageUrl: setLogo,
        imageBuilder: (context, imageProvider) => CircleAvatar(
          radius: d,
          backgroundImage: imageProvider,
        ),*/
      ),
    ),
  );
}
final Shader linearGradient = LinearGradient(
  colors: <Color>[
    Color(0xffFCCC44),
    Color(0xffDC3843),
    Color(0xffFC9425),],
).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

String serverResponses(value){
  if(value==400){
    return "$value Error: Bad Request";
  }else if(value==404){
    return "$value Error: Resource Not Found ";
  }else if(value==408){
    return "$value Error: Request Timeout";
  }else if(value==409){
    return "$value Error: Conflict Issue ";
  }else if(value==401){
    return "$value Error: UnAuthorized Access";
  }else if(value==500){
    return "$value Error: Internal Server Error";
  }else if(value==502){
    return "$value Error: Invalid Response ";
  }else if(value==504){
    return "$value Error: Server Timeout ";
  }else
    return '$value Unknown Error:';

}
