

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:topi/AppCategory.dart';
import 'package:topi/Gradient.dart';
import 'package:topi/constants.dart';
import 'package:topi/sign_in.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: SafeArea(
        child: BackgroundGradient(
          childView: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if(snapshot.connectionState==ConnectionState.waiting){
                return Center(child: spinkit,);
              }else if(snapshot.hasError){
                return Center(child: Text('Something went wrong!'),);
              }else if(snapshot.hasData){
                return AppCategory();
              }else{
                return SignIn();
              }

            },
          ),
        ),
      ),
    );
  }
}
