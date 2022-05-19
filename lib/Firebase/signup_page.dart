import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:topi/Firebase/login_page.dart';
import 'package:topi/Firebase/login_signup_widget.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  CollectionReference uData =
  FirebaseFirestore.instance.collection('usersData');

  Future<void> addUser() {
    // Call the user's CollectionReference to add a new user
    return uData
        .add({
      'FirstName': firstName.text,
      'LastName': lastName.text,
      'Email': email.text,
      'Password': password.text,
      'Role': 'user',
    })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  RegisterUser() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
          email: email.text, password: password.text);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
     addUser();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => logInScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
        backgroundColor: Color(0xfff9fcf2),
        body: Container(
          margin: EdgeInsets.only(top: 50),
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
                  margin: EdgeInsets.only(left: 40, top: 15),
                  child: Text(
                    'SignUp',
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
                              CustumController: firstName,
                              cIcon: FontAwesomeIcons.user,
                              HintText: 'First Name',
                            )),
                        Container(
                            width: 320,
                            padding: EdgeInsets.all(10.0),
                            child: customeTextField(
                              CustumController: lastName,
                              cIcon: FontAwesomeIcons.user,
                              HintText: 'Last Name',
                            )),
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
                          text: 'SignUp',
                          OnPressed: () {
                             RegisterUser();
                            print('Button pressed');
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