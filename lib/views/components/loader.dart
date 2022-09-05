import 'package:flutter/material.dart';

import '../../helper.dart';


loader(){
  return Center(
    child: Container(
      height: 60,width: 60,
      child: CircularProgressIndicator(
        backgroundColor: color3,
      ),
    ),
  );
}