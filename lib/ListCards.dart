import 'package:flutter/material.dart';


class ListCards extends StatelessWidget {

  final String text;
  final images;
  final onClicks;

  ListCards(
      {required this.text, required this.images, required this.onClicks});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onClicks,
          child: Card(
            elevation: 4.0,
            clipBehavior: Clip.antiAlias,
            shape: CircleBorder(),
            child: images,
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 6.0,right: 8),
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 11.0,
              color:  Color(0xffFC9425),
            ),
          ),
        ),
      ],
    );
  }
}
