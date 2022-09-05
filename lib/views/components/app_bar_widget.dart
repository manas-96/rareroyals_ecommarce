import 'package:flutter/material.dart';

import '../../helper.dart';

Widget appBarWidget({bool leading, Widget title}) {
  return AppBar(
    iconTheme: IconThemeData(
      color: color3, //change your color here
    ),
    automaticallyImplyLeading: leading==null?false:leading,
    elevation: 0,
    backgroundColor: color1,
    title:title==null? Image.asset(
      "images/logo.png",
      fit: BoxFit.cover,
      height: 50,
      width: 60,
    ):title,
    actions: [

    ],
  );
}
