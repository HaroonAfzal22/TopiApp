
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:topi/Shared_Pref.dart';

class GoogleSignInProvider{

final googleSignIn = GoogleSignIn();

GoogleSignInAccount? _user;

GoogleSignInAccount get user=>_user!;

Future googleLogin()async{
  final googleUser=await googleSignIn.signIn();

  if(googleUser==null)return;
  _user=googleUser;

  final googleAuth= await googleUser.authentication;

  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth.accessToken,
    idToken: googleAuth.idToken,
  );

  var response = await FirebaseAuth.instance.signInWithCredential(credential);
 return  response.user;
 // notifyListeners();
}

Future logout()async{
  await SharedPref.removeData();
  await googleSignIn.disconnect();
  FirebaseAuth.instance.signOut();
}

}