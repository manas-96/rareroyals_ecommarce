import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:rare_royals_in_corporated/logic/auth_controller.dart';
import 'package:rare_royals_in_corporated/views/forgot_password.dart';
import 'package:rare_royals_in_corporated/views/sign_up.dart';
import 'package:rare_royals_in_corporated/views/tab_screen.dart';

import '../helper.dart';
import 'components/buttons.dart';


class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final AuthController authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
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
                  "Welcome back",
                  style: textStyle4,
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  "Enter your credential to sign in",
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
                          SizedBox(width: 5,),
                          Expanded(
                            child: TextField(
                              keyboardType: TextInputType.emailAddress,
                              onChanged: (val) {
                                authController.lEmail.value=val;
                              },
                              decoration: InputDecoration(
                                  hintText: "Email/Username",
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
                                authController.lPass.value=val;
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
                SizedBox(
                  height: 30,
                ),

                InkWell(
                  onTap: () {
                    authController.signIn();
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
                          : Text("LOGIN",style: textStyle5,),
                    ),)
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: (){
                    Get.to(ForgotPassword());
                  },
                  child: Text("Forgot password?",style: textStyle1,),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account?   ",style: textStyle3,),
                    InkWell(
                      onTap: (){
                        Get.to(SignUp());
                      },
                      child: Text("Sign up",style: textStyle1,),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _onBackPressed() {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Exit application?'),
            actions: <Widget>[
              FlatButton(
                child: Text('NO'),
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
              ),
              FlatButton(
                child: Text('YES'),
                onPressed: () {
                  SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                },
              ),
            ],
          );
        });
  }
}
