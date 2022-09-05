import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rare_royals_in_corporated/logic/auth_controller.dart';

import '../../helper.dart';


buttons({context, title, onTap, width, isloading}){
  AuthController authController = Get.put(AuthController());
  return InkWell(
    onTap: onTap,
    child: Container(
      height: 45,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: color3,

      ),
      alignment: Alignment.center,
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child:authController.isLoading.value?
            CircularProgressIndicator(backgroundColor: Colors.white,)
            : Text(title,style: textStyle5,),
      ),
    ),
  );
}