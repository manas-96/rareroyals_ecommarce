import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rare_royals_in_corporated/logic/auth_controller.dart';
import 'package:rare_royals_in_corporated/views/home_page.dart';
import 'package:rare_royals_in_corporated/views/log_in.dart';
import 'package:rare_royals_in_corporated/views/tab_screen.dart';

import '../helper.dart';



class Splash extends StatefulWidget {
  const Splash({Key key}) : super(key: key);
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {

 @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(
      Duration(seconds: 1), (){
        Get.to(TabScreen());
    }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color1,
      body: Center(
        child: Image.asset(
          "images/logo.png",
          height: 130,
          width: 140,
        ),
      ),
    );
  }
}
