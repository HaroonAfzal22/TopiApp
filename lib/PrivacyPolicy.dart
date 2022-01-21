import 'dart:io';
import 'package:http/http.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:topi/HttpRequest.dart';
import 'package:topi/constants.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    pdfResponse();
  }
String? filePath;
  void pdfResponse() async {
    HttpRequest request = HttpRequest();

    var value = await request.getPrivacyPolicy(context);
    Uri uri = Uri.parse(value['policy']);
    var response = await get(uri);
    var dir = await getTemporaryDirectory();
    File file = File(dir.path+'/policy.pdf');
    setState(() {
      filePath=file.path;
    });
    await file.writeAsBytes(response.bodyBytes,flush:true);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black87,
          systemOverlayStyle: SystemUiOverlayStyle.light,
          title: Text(
            'Privacy Policy',
            style: TextStyle(color: Colors.deepOrange),
          ),
        ),
        body: filePath!=null?Container(
          child: PDFView(
            filePath: filePath,
            autoSpacing: false,
            nightMode: true,
            onError: (error) {
              print(error.toString());
              setState(() {
                filePath='Data Not Found';
              });
            },
          ),
        ):Center(
          child: spinkit,
        ));
  }
}
