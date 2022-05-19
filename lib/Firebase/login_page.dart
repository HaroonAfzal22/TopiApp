
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:topi/Firebase/login_signup_widget.dart';

class logInScreen extends StatefulWidget {
  @override
  State<logInScreen> createState() => _logInScreenState();
}

class _logInScreenState extends State<logInScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  signInUser() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
          email: email.text, password: password.text);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      } else {
        print('user login sucseefully');
      }
    }
    Navigator.pushNamed(context, '/PremiumFeature');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xfff9fcf2),
        body: Container(
          margin: EdgeInsets.only(top: 70),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 120, top: 5),
                  child: Card(
                    elevation: 20,
                    child: Icon(
                      FontAwesomeIcons.userPlus,
                      color: Color(0xffe0eaf3),
                      size: 150,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 40, top: 30),
                  child: Text(
                    'LogIn',
                    style: TextStyle(
                        fontSize: 50,
                        color: Colors.green,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 40, top: 5),
                  child: Card(
                    color: Color(0xffe0eaf3),
                    elevation: 20,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            width: 320,
                            padding: EdgeInsets.all(10.0),
                            child: customeTextField(
                              CustumController: email,
                              cIcon: FontAwesomeIcons.envelope,
                              HintText: 'Enter Your Email Here...',
                            )),
                        Container(
                            width: 320,
                            padding: EdgeInsets.all(10.0),
                            child: customeTextField(
                              CustumController: password,
                              cIcon: FontAwesomeIcons.lock,
                              HintText: 'Enter Your Password Here...',
                            )),
                        customButton(
                          Height: 50,
                          Widht: 150,
                          text: 'LogIn',
                          OnPressed: () {
                            // signInUser();
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}