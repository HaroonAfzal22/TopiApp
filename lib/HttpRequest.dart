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

  Future predictNp(BuildContext context,Map<String,String>bodyMap, var image) async {
    try {
      Uri uri = Uri.parse(HttpLinks.localsUrl);
      var stream = ByteStream(image.openRead());
      print('uri $uri');

      stream.cast();
      var length = await image.length();
      var request = MultipartRequest('POST', uri);
        //  request.headers['content-length']='50000';
        request.files.add(
          MultipartFile(
            'file1',
            stream,
            length,
            filename: image.path,
            contentType: MediaType('Content-Type', "multipart/form-data"),
          ),);

      print('request file ${ MultipartFile(
        'file1',
        stream,
        length,
        filename: image.path,
        contentType: MediaType('Content-Type', "multipart/form-data"),
      ).length}');
      request.fields.addAll(bodyMap);
      var response = await request.send();

      if (response.statusCode == 200) {
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


      } else if (response.statusCode == 401) {
        // removeAccount(context);
        toastShow('Authorization Failure');
      } else {
        print(response.statusCode);
        return response.statusCode;
      }
    } catch (e) {
      print(e);
    }
  }


 /* Future predictNp(BuildContext context,Map<String,String>bodyMap, var image) async {
    try {
      Uri uri = Uri.parse(HttpLinks.localUrl);
     *//* var stream = ByteStream(image.openRead());
      print('uri $uri');

      stream.cast();
      var length = await image.length();
      var request = MultipartRequest('POST', uri)
        ..files.add(
          MultipartFile(
            'file1',
            stream,
            length,
            filename: image.path,
            contentType: MediaType('Content-Type', "multipart/form-data"),
          ),);

      request.fields.addAll(bodyMap);
      var response = await request.send();*//*
      Response response = await post(uri,
          headers: {
        HttpHeaders.contentTypeHeader:'application/x-www-form-urlencoded',
      },
          body:bodyMap);

      if (response.statusCode == 200) {
       *//* final directory = await getExternalStorageDirectory();
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

*//*
        print("response ${response.body}");
      } else if (response.statusCode == 401) {
        // removeAccount(context);
        toastShow('Authorization Failure');
      } else {
        print(response.statusCode);
        return response.statusCode;
      }
    } catch (e) {
      print(e);
    }
  }*/

Future getCategories(BuildContext context)async{
    try{

      Uri uri = Uri.parse(HttpLinks.getCategory);
      Response response= await get(uri,headers: {
        HttpHeaders.contentTypeHeader:'application/json',
      });
      if(response.statusCode==200){
        return jsonDecode(response.body);
      }else{
        return response.statusCode;
      }
    }catch(e){
      print('error $e');
  }

}
Future getSongsList(BuildContext context,int id)async{
    try{
      Uri uri = Uri.parse('${HttpLinks.getCategories}/$id${HttpLinks.getSongs}');
      Response response= await get(uri,headers: {
        HttpHeaders.contentTypeHeader:'application/json',
      });
      if(response.statusCode==200){
        return jsonDecode(response.body);
      }else{
        return response.statusCode;
      }
    }catch(e){
      print('error $e');
  }
}


  Future getAboutUs(BuildContext context)async{
    try{
      Uri uri = Uri.parse('${HttpLinks.aboutUs}');
      Response response= await get(uri);
      if(response.statusCode==200){
        return jsonDecode(response.body);
      }else{
        return response.statusCode;
      }
    }catch(e){
      print('error $e');
    }
  }

  Future getPrivacyPolicy(BuildContext context)async{
    try{
      Uri uri = Uri.parse('${HttpLinks.privacyPolicy}');
      Response response= await get(uri);
      if(response.statusCode==200){
        return jsonDecode(response.body);
      }else{
        return response.statusCode;
      }
    }catch(e){
      print('error $e');
    }
  }

  Future postFcmToken(BuildContext context, String? tokenFcm) async {
    try {
      Uri uri = Uri.parse(HttpLinks.postFcmToken);
      Response response = await post(uri, body: {
        'token': tokenFcm,
      });
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 401) {
        toastShow('Authorization Failure');
      } else {
        print(response.statusCode);
        return response.statusCode;
      }
    } catch (e) {
      print(e);
    }
  }

  Future getCommunity(BuildContext context) async {
    try {
      Uri uri = Uri.parse('https://wasisoft.com/dev/index.php');
      Response response = await get(
        uri,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 401) {
        toastShow('UnAuthorized Error');
      } else {
        print(response.statusCode);
        return response.statusCode;
      }
    } catch (e) {
      print(e);
    }
  }

  Future getAds(BuildContext context) async {
    try {
      Uri uri = Uri.parse('${HttpLinks.AdsUrl}');
      Response response = await get(uri, headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      });
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 401) {
        toastShow('Authorization Failure');
      } else {
        print(response.statusCode);
        return response.statusCode;
      }
    } catch (e) {
      print(e);
    }
  }

/*Future parentLogin(BuildContext context, String email, String password,
      String? tokenFcm) async {
    try {
      Uri uri = Uri.parse(HttpLinks.parentLoginUrl);
      Response response = await post(uri, body: {
        'username': email,
        'password': password,
        'fcm_token': tokenFcm,
      });
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 401) {
        removeAccount(context);
        toastShow('Authorization Failure');
      } else {
        print(response.statusCode);
        return response.statusCode;
      }
    } catch (e) {
      print(e);
    }
  }

  // for profile link


  Future getSubjectsList(BuildContext context, String token, String sId) async {
    try {
      Uri uri = Uri.parse('${HttpLinks.Url}$sId${HttpLinks.subjectListUrl}');
      Response response = await get(uri, headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      });
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 401) {
        removeAccount(context);
        toastShow('Authorization Failure');
      } else {
        print(response.statusCode);
        return response.statusCode;
      }
    } catch (e) {
      print(e);
    }
  }

  Future getTestResult(BuildContext context,String sId, String id, String token) async {
    try {
      Uri uri = Uri.parse(
          '${HttpLinks.Url}$sId${HttpLinks.subjectListUrl}/$id${HttpLinks.testResultUrl}');

      print(uri);
      Response response = await get(uri, headers: {
        HttpHeaders.authorizationHeader: 'Bearer $token',
        HttpHeaders.contentTypeHeader: 'application/json',
      });

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 401) {
        removeAccount(context);
        toastShow('Authorization Failure');
      } else {
        print(response.statusCode);
        return response.statusCode;
      }
    } catch (e) {
      print(e);
    }
  }

//for student Attendance
  Future studentAttendance(
      BuildContext context, String token, String sId) async {
    try {
      Uri uri = Uri.parse('${HttpLinks.Url}$sId${HttpLinks.AttendanceUrl}');

      Response response = await get(uri, headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      });
      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else if (response.statusCode == 401) {
        removeAccount(context);
        toastShow('Authorization Failure');
        return response.statusCode;
      } else {
        return response.statusCode;
      }
    } catch (e) {
      print(e);
    }
  }

//for student time table
  Future studentTimeTable(
      BuildContext context, String token, String sId) async {
    try {
      Uri uri = Uri.parse('${HttpLinks.Url}$sId${HttpLinks.timeTableUrl}');

      Response response = await get(uri, headers: {
        HttpHeaders.contentTypeHeader: 'text/html',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      });
      if (response.statusCode == 200) {
        return response.body;
      } else if (response.statusCode == 401) {
        removeAccount(context);
        toastShow('Authorization Failure');
        return response.statusCode;
      } else {
        return response.statusCode;
      }
    } catch (e) {
      print(e);
    }
  }

//for student monthly exam report
  Future studentMonthlyExamReport(
      BuildContext context, String token, String sId, var date) async {
    try {
      Uri uri = Uri.parse(
          '${HttpLinks.Url}$sId${HttpLinks.monthlyExamReportUrl}$date');
      print(uri);
      Response response = await get(uri, headers: {
        HttpHeaders.contentTypeHeader: 'text/html',
        HttpHeaders.authorizationHeader: 'Bearer $token',
      });
      if (response.statusCode == 200) {
        return response.body;
      } else if (response.statusCode == 401) {
        removeAccount(context);
        toastShow('Authorization Failure');
        return response.statusCode;
      } else {
        return response.statusCode;
      }
    } catch (e) {
      print(e);
    }
  }

//for remove shared_Pref error 401:
  void removeAccount(context) {
    SharedPref.removeData();
    Navigator.pushReplacementNamed(context, '/');
  }*/

}
