import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:topi/constants.dart';
import 'package:http_parser/http_parser.dart';

import 'HttpLinks.dart';

int count = 1;

class HttpRequest {
  //for login link

  // render image into video model function
  Future predictNp(BuildContext context,Map<String,String>bodyMap, var image) async {
    try {
      Uri uri = Uri.parse(HttpLinks.localUrl);
      var stream = ByteStream(image.openRead());
      stream.cast();
      var length = await image.length();
      var request = MultipartRequest('POST', uri);
        request.files.add(
          MultipartFile(
            'file1',
            stream,
            length,
            filename: image.path,
            contentType: MediaType('Content-Type', "multipart/form-data"),
          ),);
      request.fields.addAll(bodyMap);
      var response = await request.send();
      if (response.statusCode == 200 ||response.statusCode==201) {
        final directory = await getExternalStorageDirectory();
        var file = File('${directory!.path}/video$count.mp4');
        var bytes = <int>[];
        response.stream.listen((value) {
          bytes.addAll(value);
        }, onDone: () async {
          count++;
          await file.writeAsBytes(bytes);
        });
        print('fiile is $file');
        return file;
      } else {
          return serverResponses(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }

  // get categories of type of songs
Future getCategories(BuildContext context)async{
    try{

      Uri uri = Uri.parse(HttpLinks.getCategory);
      Response response= await get(uri,headers: {
        HttpHeaders.contentTypeHeader:'application/json',
      });
      if(response.statusCode==200 ||response.statusCode==201){
        return jsonDecode(response.body);
      }else{
        return serverResponses(response.statusCode);
      }
    }catch(e){
      print('error $e');
  }

}

// get songs list according to  type
Future getSongsList(BuildContext context,int id)async{
    try{
      Uri uri = Uri.parse('${HttpLinks.getCategories}/$id${HttpLinks.getSongs}');
      Response response= await get(uri,headers: {
        HttpHeaders.contentTypeHeader:'application/json',
      });
      if(response.statusCode==200 ||response.statusCode==201){
        return jsonDecode(response.body);
      }else{
        return serverResponses(response.statusCode);
      }
    }catch(e){
      print('error $e');
  }
}

// company profile function
Future getAboutUs(BuildContext context)async{
    try{
      Uri uri = Uri.parse('${HttpLinks.aboutUs}');
      Response response= await get(uri);
      if(response.statusCode==200||response.statusCode==201){
        return jsonDecode(response.body);
      }else{
        return serverResponses(response.statusCode);
      }
    }catch(e){
      print('error $e');
    }
  }

  // company privacy policy function
Future getPrivacyPolicy(BuildContext context)async{
    try{
      Uri uri = Uri.parse('${HttpLinks.privacyPolicy}');
      Response response= await get(uri);
      if(response.statusCode==200||response.statusCode==201){
        return jsonDecode(response.body);
      }else{
        return serverResponses(response.statusCode);
      }
    }catch(e){
      print('error $e');
    }
  }

  // post fcm token to show notifications
Future postFcmToken(BuildContext context, Map tokenFcm) async {
    try {
      Uri uri = Uri.parse(HttpLinks.postFcmToken);
      Response response = await post(uri, body:tokenFcm);
      if (response.statusCode == 200||response.statusCode==201) {
        return jsonDecode(response.body);
      } else {
        print('status after post fcm ${response.statusCode}');
        return serverResponses( response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }

  // get admin videos url
Future getCommunity(BuildContext context) async {
    try {
      Uri uri = Uri.parse(HttpLinks.adminVideos);
      Response response = await get(
        uri,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
      );
      if (response.statusCode == 200||response.statusCode==201) {
        return jsonDecode(response.body);
      } else {
        return serverResponses(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }

  // get like count
Future getLikesCount(BuildContext context) async {
    try {
      Uri uri = Uri.parse('${HttpLinks.likeApi}');
      Response response = await get(
        uri,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
      );
      if (response.statusCode == 200||response.statusCode==201) {
        return jsonDecode(response.body);
      } else {
        return serverResponses(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }


Future postLikesCount(BuildContext context,Map bodyMap) async {
    try {
      Uri uri = Uri.parse('${HttpLinks.likeApi}');
      Response response = await post(
        uri,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: jsonEncode(bodyMap)
      );
      if (response.statusCode == 200||response.statusCode==201) {
        return jsonDecode(response.body);
      } else {
        return serverResponses(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }

  // get share count
  Future getSharesCount(BuildContext context) async {
    try {
      Uri uri = Uri.parse('${HttpLinks.shareApi}');
      Response response = await get(
        uri,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
      );
      if (response.statusCode == 200||response.statusCode==201) {
        return jsonDecode(response.body);
      } else {
        return serverResponses(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }

  // get ads id from url to set dynamic
Future getAds(BuildContext context) async {
    try {
      Uri uri = Uri.parse('${HttpLinks.AdsUrl}');
      Response response = await get(uri, headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      });
      if (response.statusCode == 200||response.statusCode==201) {
        return jsonDecode(response.body);
      } else {
        print(response.statusCode);
        return serverResponses(response.statusCode);
      }
    } catch (e) {
      print(e);
    }
  }

  // all notification list is set to be in url
  Future getNotifications(BuildContext context)async{
    try{

      Uri uri = Uri.parse(HttpLinks.notifications);
      Response response= await get(uri,headers: {
        HttpHeaders.contentTypeHeader:'application/json',
      });
      if(response.statusCode==200 ||response.statusCode==201){
        return jsonDecode(response.body);
      }else{
        return serverResponses(response.statusCode);
      }
    }catch(e){
      print('error $e');
    }

  }

}
