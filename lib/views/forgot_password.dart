import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rare_royals_in_corporated/logic/auth_controller.dart';

import '../helper.dart';


class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController textEditingController=TextEditingController();
  final AuthController authController = Get.put(AuthController());
  RxBool displayOtp=false.obs;
  String email="";
  String otp;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color1,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.15,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Image.asset(
                  "images/logo.png",
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "Forgot your password!",
                style: textStyle4,
              ),
              SizedBox(
                height: 8,
              ),
              Obx(()=>
              displayOtp.value?Text(
                "Enter your otp to verify.",
                style: textStyle3,
              ):Text(
                "Don't worry, enter your email to proceed.",
                style: textStyle3,
              ),),
              SizedBox(
                height: 40,
              ),
              Obx(()=>
              displayOtp.value?Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white),
                child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8),
                    child: Row(
                      children: [
                        Icon(Icons.verified_outlined,color: color3,),
                        SizedBox(width: 5,),
                        Expanded(
                          child: TextField(
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (val) {
                              otp=val;
                            },
                            decoration: InputDecoration(
                                hintText: "OTP",
                                hintStyle: textStyle1,
                                border: InputBorder.none),
                          ),
                        ),
                      ],
                    )
                ),
              ):Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white),
                child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8),
                    child: Row(
                      children: [
                        Icon(Icons.person_outline,color: color3,),
                        SizedBox(width: 5,),
                        Expanded(
                          child: TextField(
                            keyboardType: TextInputType.emailAddress,
                            controller: textEditingController,
                            onChanged: (val) {
                              email=val;
                            },
                            decoration: InputDecoration(
                                hintText: "Email",
                                hintStyle: textStyle1,
                                border: InputBorder.none),
                          ),
                        ),
                      ],
                    )
                ),
              ),),

              SizedBox(
                height: 30,
              ),

              InkWell(
                onTap: () {
                  if(!displayOtp.value){
                    if(email==""){
                      Get.snackbar("Empty field", "Please enter email",colorText: Colors.red);
                      return;
                    }
                    authController.forgotPassword(email);
                    displayOtp.value=true;
                    textEditingController.clear();
                    return;
                  }
                  authController.verifyOtp(email, otp);
                },
                child: Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width,
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
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
