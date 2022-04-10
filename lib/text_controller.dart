import 'package:flutter/material.dart';

class TextController {
  static final TextController _this = TextController._internal();

  // passes the instantiation to the _instance object
  factory TextController() => _this;
  String _verifications = "";
  String _phone = "";

  TextController._internal() {
    //_myVariable has to be defined before
  }

  /// Allow for easy access to 'the Controller' throughout the application.
  static TextController get loginCon => _this;
  String get verifications => _verifications;
  String get phone => _phone;

  void setVeri(String verification) {
    _verifications = verification;
  }

  void setPhone(String phone) {
    _phone = phone;
  }
}
