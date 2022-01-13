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

  Future predictNp(BuildContext context, var image) async {
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
      print('response $request');
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
  Future oneNp(BuildContext context, var image) async {
    try {
      Uri uri = Uri.parse(HttpLinks.oneUrl);
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
  Future twoNp(BuildContext context, var image) async {
    try {
      Uri uri = Uri.parse(HttpLinks.twoUrl);
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
  Future threeNp(BuildContext context, var image) async {
    try {
      Uri uri = Uri.parse(HttpLinks.threeUrl);
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
  Future fourNp(BuildContext context, var image) async {
    try {
      Uri uri = Uri.parse(HttpLinks.fourUrl);
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
  Future fiveNp(BuildContext context, var image) async {
    try {
      Uri uri = Uri.parse(HttpLinks.fiveUrl);
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
  Future sixNp(BuildContext context, var image) async {
    try {
      Uri uri = Uri.parse(HttpLinks.sixUrl);
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
