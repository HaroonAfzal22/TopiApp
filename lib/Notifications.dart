
import 'package:flutter/cupertino.dart';
import 'package:lottie/lottie.dart';

class Notifications extends StatelessWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Lottie.asset('assets/construction.json',
          repeat: true, reverse: true, animate: true),
    );
  }
}
