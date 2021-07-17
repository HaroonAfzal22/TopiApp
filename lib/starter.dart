import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

File? _file ;

class StartScreen extends StatelessWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hello',
      home: StartedScreen(),
    );
  }
}

class StartedScreen extends StatelessWidget {
  const StartedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Permission'),
      ),
      body: CaptureImages(),
    );
  }
}

class CaptureImages extends StatefulWidget {
  const CaptureImages({Key? key}) : super(key: key);

  @override
  _CaptureImagesState createState() => _CaptureImagesState();
}

class _CaptureImagesState extends State<CaptureImages> {

  Future getImages(bool isCamera) async {
    try {
      File file = File('waiting...');
      if (!isCamera) {
        file = (await ImagePicker().getImage(source: ImageSource.camera)) as File;
      }
      setState(() {
        _file = file;

        print(file);
      });
    } catch (e, s) {
      print('error $s');
    }

  }
  @override
  void initState() {
    super.initState();
    getImages(false);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      // ignore: unnecessary_null_comparison
      child: _file==null?Container():Image.file(_file!,height: 300,width: 300,)
      
    );
  }
}
