import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rare_royals_in_corporated/logic/auth_controller.dart';
import 'package:rare_royals_in_corporated/views/components/app_bar_widget.dart';

import '../helper.dart';


class ChangePassword extends StatefulWidget {
  const ChangePassword({Key key}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  String password="",newPass="",confirmPass="";
  AuthController authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: color1,
      appBar: appBarWidget(leading: true,title: Text("Change Password",style: textStyle7,)),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white),
                child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8),
                    child: TextField(
                      onChanged: (val) {
                        password=val;
                      },
                      decoration: InputDecoration(
                          hintText: "Old Password",
                          hintStyle: textStyle1,
                          border: InputBorder.none),
                    ),
                ),
              ),
              SizedBox(height: 20,),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white),
                child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8),
                    child: TextField(
                      onChanged: (val) {
                        newPass=val;
                      },
                      decoration: InputDecoration(
                          hintText: "New Password",
                          hintStyle: textStyle1,
                          border: InputBorder.none),
                    ),
                ),
              ),

              SizedBox(
                height: 30,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white),
                child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8),
                    child: TextField(
                      onChanged: (val) {
                        confirmPass=val;
                      },
                      decoration: InputDecoration(
                          hintText: "Confirm Password",
                          hintStyle: textStyle1,
                          border: InputBorder.none),
                    ),
                ),
              ),
              SizedBox(height: 30,),
              InkWell(
                onTap: () {
                  if(password==""){
                    Get.snackbar("Empty field", "Enter old password",colorText: Colors.red);
                  }
                  else if(newPass==""){
                  Get.snackbar("Empty field", "Enter new password",colorText: Colors.red);
                  }
                  else if(confirmPass!=newPass){
                  Get.snackbar("Validation error", "Confirm password & New password are not same",colorText: Colors.red);
                  }
                  else{
                    authController.changePassword(password, newPass);
                  }
                },
                child: Container(
                    height: 45,
                    width: MediaQuery.of(context).size.width/2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: color3,

                    ),
                    alignment: Alignment.center,
                    child: Obx(()=>Padding(
                      padding: const EdgeInsets.all(5.0),
                      child:authController.isLoading.value?
                      CircularProgressIndicator(backgroundColor: Colors.white,)
                          : Text("SUBMIT",style: textStyle5,),
                    ),)
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
