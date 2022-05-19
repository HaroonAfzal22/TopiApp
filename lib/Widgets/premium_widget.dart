import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:topi/constants.dart';

import '../OutlineBtn.dart';

class CustomCardBoxWidget extends StatelessWidget {
  CustomCardBoxWidget({required this.boxText, required this.BoxColor,required this.boxAmount}) ;
  var BoxColor;
  String? boxText;
  String ? boxAmount;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8.0,
      margin: EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          gradient: LinearGradient(
            colors:BoxColor,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        height: 120,
        width: 110,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
                '$boxText',//1-Year
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold)),
            Text(
              '$boxAmount',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class cusomtCardWidget extends StatelessWidget {
  cusomtCardWidget( {required this.cTittle,required this.cSubtitle,required this.Conpressed,required this.buttonColor,required this.contaierColor}) ;
  String? cTittle;
  String? cSubtitle;
  VoidCallback Conpressed;
  var contaierColor;
  var buttonColor;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          side: BorderSide(
            width: 1,
          )),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.15,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors:contaierColor,

            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Center(
          child: ListTile(
            title: Text(
              '$cTittle',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w700),
            ),
            subtitle: Text(
              '$cSubtitle',
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                  fontWeight: FontWeight.w700),
            ),
            trailing: Container(

              child: UnicornOutlineButton(
                strokeWidth: 1,
                radius: 10,
                gradient: LinearGradient(
                  colors: buttonColor,
                  // [Colors.cyan, Colors.deepOrangeAccent]
                ),
                child: Text(
                  'Details',
                  style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.w700,
                      foreground: Paint()..shader = linearGradient),
                ),
                onPressed: Conpressed,
              ),
            ),
            leading: Icon(
              FontAwesomeIcons.gift,
              color: Colors.white,
              size: 34,
            ),
          ),
        ),
      ),
    );
  }
}