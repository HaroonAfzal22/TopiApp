
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:topi/Gradient.dart';

class AddBio extends StatelessWidget {
  const AddBio({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        elevation: 0.0,
        title: Image.asset(
          'assets/topi.png',
          fit: BoxFit.contain,
          width: 80,
          height: 80,
        ),
        centerTitle: true,
      ),
      backgroundColor: Colors.black87,
        body:
        SafeArea(child: BackgroundGradient(
          childView:Container(
            margin: EdgeInsets.all(8.0),
            child: TextFormField(
              autofocus: true,
              autocorrect: true,
              onFieldSubmitted: (String value){

              },
              buildCounter: (),
              style: TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                focusColor: Colors.white70,
                floatingLabelStyle:TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: Colors.white70,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                    borderSide: const BorderSide(color: Colors.white, width: 2.0),
                ),
                labelText: "Add bio",
              ),
              maxLength: 80,
            ),
          )
        )),
    );
  }
}
