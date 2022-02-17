import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:topi/Gradient.dart';
import 'package:topi/google_sign_in.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: SafeArea(
        bottom: false,
        child: BackgroundGradient(
          childView: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(),
                Container(
                  child: CircleAvatar(
                    radius: 101,
                    backgroundColor: Colors.deepOrange,
                    child: CircleAvatar(
                      radius: 100.0,
                      child: Image.asset(
                        'assets/topi.png',
                      ),
                    ),
                  ),
                ),
                Spacer(),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Hey There,\nWelcome Back',
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Login to your account to continue',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.normal),
                  ),
                ),
                Spacer(),
                ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      onPrimary: Colors.black,
                      minimumSize: Size(double.infinity, 50),
                    ),
                    onPressed: ()async {
                       /* final providers= Provider.of<GoogleSignInProvider>(context,listen: false);
                        providers.googleLogin();*/
                    GoogleSignInProvider provider= GoogleSignInProvider();
                               var response=await provider.googleLogin();
                               if(response!=null){
                                Navigator.pushReplacementNamed(context, '/profile');
                               }
                      print('response ${response}');
                    },
                    icon: FaIcon(
                      FontAwesomeIcons.google,
                      color: Colors.red,
                    ),
                    label: Text('Sign up with Google')),
                SizedBox(
                  height: 40,
                ),
               /* RichText(
                  text: TextSpan(text: 'Already have an account? ', children: [
                    TextSpan(
                      text: 'Log in',
                      style: TextStyle(decoration: TextDecoration.underline),
                    ),
                  ]),
                ),*/
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
