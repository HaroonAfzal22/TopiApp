
import 'package:flutter/material.dart';


//universal background design for any class
class BackgroundGradient extends StatelessWidget {
  final childView;
  const BackgroundGradient({
    required this.childView
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight, colors:[Colors.black87,Colors.black87]),
        ),
        child:childView,
    );
  }
}
//  [Color(0xffDC3843),Color(0xffFC9425),  Color(0xffFCCC44)]
