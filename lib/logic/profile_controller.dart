

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rare_royals_in_corporated/data/api_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController{
  RxString name="".obs;
  RxString email="".obs;
  RxString id="".obs;
  RxBool isLogin=false.obs;
  RxBool isLoading=true.obs;
  getProfile()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if(preferences.get("id")==null) {
      isLogin.value=false;
      isLoading.value=false;
      return;
    }
    final body={
      "user":preferences.get("id")
    };
    final data = await ApiResponse().postFunction(json.encode(body), "profile");
    name.value= data["data"][0]["name"];
    email.value= data["data"][0]["email"];
    id.value=preferences.get("id");
    isLogin.value=true;
    isLoading.value=false;
  }

  updateProfile(String name, String email, String mobile, String location, String pin)async{
    if(name==""){
      Get.snackbar("Empty Field", "Please enter Name",colorText: Colors.red);
    }
    else if(email==""){
      Get.snackbar("Empty Field", "Please enter Email",colorText: Colors.red);
    }
    else if(mobile==""){
      Get.snackbar("Empty Field", "Please enter Mobile",colorText: Colors.red);
    }
    else if(location==""){
      Get.snackbar("Empty Field", "Please enter Location",colorText: Colors.red);
    }
    else if(pin==""){
      Get.snackbar("Empty Field", "Please enter Pincode",colorText: Colors.red);
    }
    else{
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      final body = {
        "user": sharedPreferences.getString("id"),
        "name": name,
        "email": email,
        "mobile": mobile,
        "location": location,
        "pincode": pin
      };
      isLoading.value=true;
      final result = await ApiResponse().postFunction(json.encode(body),"profile/edit");
      isLoading.value=false;
      if(result["response_code"]=="200"){
        Get.snackbar("Message", result["message"],colorText: Colors.green);
      }

    }
  }
}