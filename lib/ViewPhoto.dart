
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ViewPhoto extends StatelessWidget {
  const ViewPhoto({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    return Container(
      alignment: Alignment.center,
      color: Colors.black54,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height*0.5,
      child:args.containsValue('https')? Image.network(args['image'].toString()):Image.file(args['image']),
    );
  }
}
