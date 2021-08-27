import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lottie/lottie.dart';
import 'package:share_plus/share_plus.dart';
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
  List<String> imagePaths=[];

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
        isLoading = true;
      });
      imageFile = croppedFile;
      HttpRequest request = HttpRequest();
      var result = await request.postImage(context, imageFile);
      if (result != null) {
        setState(() {
          isLoading = false;
          _onWillPop();
        });
      } else {
        setState(() {
          toastShow('Unable to Load!Check Internet Connectivity');
          isLoading = false;
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

  Future<bool> _onWillPop() async {
    if (Platform.isIOS) {
      return await showDialog(
              context: context,
              builder: (context) => CupertinoAlertDialog(
                    title: Text('Are you sure?'),
                    content: Container(
                      child: Image.file(imageFile!),
                    ),
                    actions: <Widget>[
                      CupertinoDialogAction(
                        child: Text('No'),
                        onPressed: () => Navigator.of(context).pop(false),
                      ),
                      CupertinoDialogAction(
                        child: Text('Yes'),
                        onPressed: () => Navigator.of(context).pop(true),
                      ),
                    ],
                  )) ??
          false;
    } else {
      return (await showDialog(
            context: context,
            builder: (context) => AlertDialog(
              backgroundColor: Color(0xffe8f6fa),
              actionsPadding:EdgeInsets.symmetric(horizontal:  24.0),
              content: Container(
                child: Image.file(imageFile!),
              ),
              actions: <Widget>[
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: new Text('Play'),
                  style: ButtonStyle(backgroundColor:MaterialStateProperty.all(Colors.red) ),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: new Text('Save'),
                  style: ButtonStyle(backgroundColor:MaterialStateProperty.all(Colors.red) ),
                ),
                ElevatedButton(
                  onPressed: () => _onShare(context),
                  child: new Text('Share'),
                  style: ButtonStyle(backgroundColor:MaterialStateProperty.all(Colors.red) ),
                ),
              ],
            ),
          )) ??
          false;
    }
  }

  void _onShare(BuildContext context) async {
    // A builder is used to retrieve the context immediately
    // surrounding the ElevatedButton.
    //
    // The context's `findRenderObject` returns the first
    // RenderObject in its descendent tree when it's not
    // a RenderObjectWidget. The ElevatedButton's RenderObject
    // has its position and size after it's built.
    final box = context.findRenderObject() as RenderBox?;

    if (imagePaths.isNotEmpty) {
      await Share.shareFiles(imagePaths,
          sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
    } else {
      await Share.share(imageFile.toString(),
          sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
    }
  }

}
