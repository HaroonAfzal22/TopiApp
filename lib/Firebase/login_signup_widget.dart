import 'package:flutter/material.dart';

class customeTextField extends StatelessWidget {
  customeTextField(
      {required this.cIcon,
        required this.HintText,
        required this.CustumController});
  String HintText;
  IconData cIcon;
  final CustumController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autocorrect: true,
      controller: CustumController,
      decoration: InputDecoration(
        // hintText: 'Enter Your Email Here...',
        hintText: HintText,
        //
        prefixIcon: Icon(cIcon),
        hintStyle: TextStyle(color: Colors.grey),
        filled: true,
        fillColor: Colors.white70,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),
          borderSide: BorderSide(color: Colors.green, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
          borderSide: BorderSide(color: Colors.green, width: 2),
        ),
      ),
    );
  }
}

class customButton extends StatelessWidget {
  customButton(
      {required this.Widht,
        required this.OnPressed,
        required this.Height,
        required this.text});
  double Height;
  double Widht;
  VoidCallback OnPressed;
  String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Height,
      width: Widht,
      child: ElevatedButton(
        onPressed: OnPressed,
        child: Text(text),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(width: 3, color: Color(0xfff9fcf2))))),
      ),
    );
  }
}