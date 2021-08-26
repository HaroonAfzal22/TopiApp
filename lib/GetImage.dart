import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:topi/Gradient.dart';
import 'package:topi/HttpRequest.dart';
import 'package:topi/constants.dart';

class ImagePickers extends StatefulWidget {
  @override
  _ImagePickersState createState() => _ImagePickersState();
}

enum AppState {
  free,
  picked,
  cropped,
}

class _ImagePickersState extends State<ImagePickers> {
  late AppState state;
  File? imageFile;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    state = AppState.free;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Pick & Crop'),
        flexibleSpace: kStatusGradient,
      ),
      body: BackgroundGradient(
        childView: Center(
          child: imageFile != null
              ? isLoading
                  ? Center(
                      child: Lottie.asset('assets/waiting.json',
                          repeat: true, reverse: true, animate: true),
                    )
                  : Image.file(imageFile!)
              : Container(
                  child: Lottie.asset('assets/upload_file.json',
                      repeat: true, reverse: true, animate: true),
                ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepOrange,
        onPressed: () {
          if (state == AppState.free)
            _pickImage();
          else if (state == AppState.picked)
            _cropImage();
          else if (state == AppState.cropped) _clearImage();
        },
        child: _buildButtonIcon(),
      ),
    );
  }

  Widget _buildButtonIcon() {
    if (state == AppState.free)
      return Icon(Icons.add);
    else if (state == AppState.picked)
      return Icon(Icons.crop);
    else if (state == AppState.cropped)
      return Icon(Icons.clear);
    else
      return Container();
  }

  Future<Null> _pickImage() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    imageFile = pickedImage != null ? File(pickedImage.path) : null;
    if (imageFile != null) {
      setState(() {
        state = AppState.picked;
        _cropImage();
      });
    }
  }

  Future<Null> _cropImage() async {
    File? croppedFile = await ImageCropper.cropImage(
      sourcePath: imageFile!.path,
      aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0),
    );
    if (croppedFile != null) {
      setState(() {
        isLoading=true;
      });
      imageFile = croppedFile;
      HttpRequest request = HttpRequest();
      var result = await request.postImage(context, imageFile);
      if(result!=null){
        setState(() {
          isLoading=false;
        });
      }
      print('response is ${result}');
      setState(() {
        state = AppState.cropped;
      });
    }
  }

  void _clearImage() {
    imageFile = null;
    setState(() {
      state = AppState.free;
    });
  }
}
