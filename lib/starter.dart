import 'package:flutter/material.dart';

class DataValueProvider extends ChangeNotifier{

   String uName='';

  void updateName(String name){
    uName=name;

    notifyListeners();
  }

}