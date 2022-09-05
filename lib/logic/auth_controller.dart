import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rare_royals_in_corporated/data/api_response.dart';
import 'package:rare_royals_in_corporated/helper.dart';
import 'package:rare_royals_in_corporated/logic/cart_controller.dart';
import 'package:rare_royals_in_corporated/views/forgot_password_change.dart';
import 'package:rare_royals_in_corporated/views/home_page.dart';
import 'package:rare_royals_in_corporated/views/log_in.dart';
import 'package:rare_royals_in_corporated/views/tab_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends GetxController{
  RxString email="".obs;
  RxString name="".obs;
  RxString pass="".obs;
  RxString confirmPass = "".obs;


  RxString lEmail="".obs;
  RxString lPass="".obs;

  RxBool isLoading=false.obs;
  CartController cartController= Get.put(CartController());

  validation(){
    if(email.value==""|| name.value==""|| pass.value=="" || confirmPass.value==""){
      Get.snackbar("Empty", "Field is empty",colorText: errorColor);
      return;
    }
    if(pass.value != confirmPass.value){
      Get.snackbar("Different password", "Password and confirm password are not same",colorText: errorColor);
      return;
    }
    signUp();
  }
  void signIn()async{
    if(lEmail.value==""||  lPass.value==""){
      Get.snackbar("Empty", "Field is empty",colorText: errorColor);
      return;
    }
    final body = {
      "email": lEmail.value,
      "password": lPass.value
    };
    isLoading.value=true;
    final result = await ApiResponse().postFunction(jsonEncode(body), "login");
    if(result!="failed"){
      if(result["response_code"]=="200"){
        await storeAuth(result["data"][0]);
        cartController.fakeToRealCart();
        Get.to(TabScreen());
      }
      else{
        Get.snackbar("Credential issue", "Please check your credential",colorText: errorColor);
      }
    }
    else{
      Get.snackbar("Hi", "Unexpected error, try after sometime",colorText: errorColor);
    }
    isLoading.value=false;
  }
  void signUp()async{
    isLoading.value=true;
    final body = {
      "name": name.value,
      "email": email.value,
      "password": pass.value
    };
    print(body);
    final result = await ApiResponse().postFunction(jsonEncode(body), "signup");
    isLoading.value=false;
    if(result!="failed"){
      if(result["response_code"]=="200"){

        Get.snackbar("Successful", "Your registration is successfully completed",colorText: successColor);
        Future.delayed(
          Duration(seconds: 2),
            (){Get.to(Login());}
        );
      }
      else{
        Get.snackbar("Credential issue", "User already exists",colorText: errorColor);
      }
    }
    else{
      Get.snackbar("Hi", "Unexpected error, try after sometime",colorText: errorColor);
    }
  }
  storeAuth(body)async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("id", body["id"]);
    sharedPreferences.setString("name", body["name"]);
    sharedPreferences.setString("email", body["email"]);
    sharedPreferences.setString("location", body["location"]);
  }
  checkLogin()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if(sharedPreferences.getString("id")!=null){
      return true;
    }
    return false;
  }
  changePassword(String pass, String newPass)async{
    isLoading.value=true;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if(preferences.get("id")==null) return;
    final body = {
      "user": preferences.get("id"),
      "oldpassword": pass,
      "newpassword": newPass,
    };
    final result = await ApiResponse().postFunction(json.encode(body), "/profile/changePassword");

    isLoading.value=false;
    Get.snackbar("Congratulation !", "Your password has changed successfully",colorText: Colors.green);
  }
  forgotPassword(String email)async{
    isLoading.value=true;
    final body={
      "email":email
    };
    final result = await ApiResponse().postFunction(json.encode(body), "forgetpassword");
    isLoading.value=false;
    if(result["response_code"]=="200"){
      Get.snackbar("Message", result["message"],colorText: Colors.green);
      return;
    }
    Get.snackbar("Message", result["message"],colorText: Colors.red);
  }
  verifyOtp(String email, String otp)async{
    isLoading.value=true;
    final body={
      "otp":otp,
      "email":email
    };
    final result = await ApiResponse().postFunction(json.encode(body), "forgetpassword/verify");
    isLoading.value=false;
    if(result["response_code"]=="200"){
      Get.snackbar("Message", result["message"],colorText: Colors.green);
      Get.to(ForgotPasswordChange());
      return;
    }
    Get.snackbar("Message", result["message"],colorText: Colors.red);
  }
  forgotPasswordChange(String password, String confirm)async{
    if(password==""){
      Get.snackbar("Empty field", "Enter password",colorText: Colors.red);
    }
    else if(password!=confirm){
      Get.snackbar("Message", "Password & Confirm password should be same.",colorText: Colors.red);
    }
    else{
      final body={
        "password":password
      };
      final result = await ApiResponse().postFunction(json.encode(body), "forgetpassword/changePassword");
      if(result["response_code"]=="200"){
        Get.snackbar("Message", result["message"],colorText: Colors.green);
        Get.to(Login());
      }
      else{
        Get.snackbar("Message", result["message"],colorText: Colors.red);
      }
    }
  }

}