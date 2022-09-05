
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rare_royals_in_corporated/logic/auth_controller.dart';

import '../helper.dart';
import 'components/buttons.dart';


class SignUp extends StatefulWidget {
  const SignUp({Key key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final AuthController authController = Get.put(AuthController());
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
                height: MediaQuery.of(context).size.height * 0.1,
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
                "Hi!",
                style: textStyle4,
              ),
              SizedBox(
                height: 8,
              ),
              Text(
                "Input the form to crate an account",
                style: textStyle3,
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
                        Icon(Icons.person_outline,color: color3,),
                        Expanded(
                          child: TextField(
                            onChanged: (val) {
                              authController.name.value=val;
                            },
                            decoration: InputDecoration(
                                hintText: "  Name",
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
                        Icon(Icons.email_outlined,color: color3,),
                        Expanded(
                          child: TextField(
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (val) {
                              authController.email.value=val;
                            },
                            decoration: InputDecoration(
                                hintText: "  Email",
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
                        Expanded(
                          child: TextField(
                            obscureText: true,
                            onChanged: (val) {
                              authController.pass.value=val;
                            },
                            decoration: InputDecoration(
                                hintText: "  Password",
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
                        Expanded(
                          child: TextField(
                            obscureText: true,
                            onChanged: (val) {
                              authController.confirmPass.value=val;
                            },
                            decoration: InputDecoration(
                                hintText: "  Confirm password",
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
                  authController.validation();
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
                          : Text("SIGN UP",style: textStyle5,),
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
