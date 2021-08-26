
import 'package:flutter/material.dart';

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
              end: Alignment.topRight,
              colors: [Color(0xffDC3843),Color(0xffFC9425),  Color(0xffFCCC44)]),
        ),
        child:childView,
    );
  }
}

