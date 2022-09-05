import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rare_royals_in_corporated/logic/auth_controller.dart';

import '../helper.dart';


class ForgotPasswordChange extends StatefulWidget {
  const ForgotPasswordChange({Key key}) : super(key: key);

  @override
  _ForgotPasswordChangeState createState() => _ForgotPasswordChangeState();
}

class _ForgotPasswordChangeState extends State<ForgotPasswordChange> {
  final AuthController authController = Get.put(AuthController());
  String password="";
  String confirm="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: color1,
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
                "Change your password here.",
                style: textStyle4,
              ),

              SizedBox(
                height: 40,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white),
                child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8),
                    child: Row(
                      children: [
                        Icon(Icons.lock_outline,color: color3,),
                        SizedBox(width: 5,),
                        Expanded(
                          child: TextField(
                            obscureText: true,
                            onChanged: (val) {
                              password=val;
                            },
                            decoration: InputDecoration(
                                hintText: "Password",
                                hintStyle: textStyle1,
                                border: InputBorder.none),
                          ),
                        ),
                      ],
                    )
                ),
              ),
              SizedBox(height: 20,),

              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: Colors.white),
                child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8),
                    child: Row(
                      children: [
                        Icon(Icons.lock_outline,color: color3,),
                        SizedBox(width: 5,),
                        Expanded(
                          child: TextField(
                            obscureText: true,
                            onChanged: (val) {
                              confirm=val;
                            },
                            decoration: InputDecoration(
                                hintText: "Confirm Password",
                                hintStyle: textStyle1,
                                border: InputBorder.none),
                          ),
                        ),
                      ],
                    )
                ),
              ),
              SizedBox(
                height: 30,
              ),

              InkWell(
                onTap: () {
                  authController.forgotPasswordChange(password,confirm);
                },
                child: Container(
                    height: 45,
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
