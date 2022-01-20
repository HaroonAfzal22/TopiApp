import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:topi/HttpRequest.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    pdfResponse();
  }

  void pdfResponse() async {
    HttpRequest request = HttpRequest();

    var value = await request.getAboutUs(context);
    if (await Permission.storage.isGranted) {

    } else {
      await Permission.storage.request();
      pdfResponse();
    }
    print('response $value');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black87,
          systemOverlayStyle: SystemUiOverlayStyle.light,
          title: Text(
            'Company Profile',
            style: TextStyle(color: Colors.deepOrange),
          ),
        ),
        body: Container());
  }
}
