import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:topi/constants.dart';
import 'package:http_parser/http_parser.dart';

import 'HttpLinks.dart';

class HttpRequest {
  List<File>value=[];
  //for login link
  Future postImage(BuildContext context, var image) async {
    try {
      Uri uri = Uri.parse(HttpLinks.localUrl);

      var stream = ByteStream(image.openRead());
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
          ),
        );
      var response = await request.send();
      if (response.statusCode == 200) {
        final directory = await getExternalStorageDirectory();
        final director = (await getApplicationDocumentsDirectory()).path;
        //var file = File('${directory!.path}/video.mp4');
        var files= File('${director}/video.mp4');
        //var files= File('/storage/emulated/0/Download/video$count.mp4');
        var bytes = <int>[];
        response.stream.listen((value) {
          bytes.addAll(value);
        }, onDone: () async {
          //await file.writeAsBytes(bytes);
          await files.writeAsBytes(bytes);
       //   value.add(file);
          value.add(files);
        });
      //  print('path is ${files.path}');
        return files;
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
  Future getProfile(BuildContext context, String token, String sId) async {
    try {
      Uri uri = Uri.parse('${HttpLinks.Url}$sId${HttpLinks.profileUrl}');
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

