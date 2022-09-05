


import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ErrorController{
  static errorToast(String msg) {
    return SnackBar(
      content: Text(msg, style: TextStyle(color: Colors.white),),
      backgroundColor: Colors.red,
      duration: Duration(seconds:2),
    );
  }
  static successToast(String msg) {
    return SnackBar(
      content: Text(msg, style: TextStyle(color: Colors.white),),
      duration: Duration(seconds:2),
    );
  }
}