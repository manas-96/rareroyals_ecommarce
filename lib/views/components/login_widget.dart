import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rare_royals_in_corporated/logic/auth_controller.dart';

import '../../helper.dart';
import '../sign_up.dart';


class LoginWidget extends StatefulWidget {
  const LoginWidget({Key key}) : super(key: key);

  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final AuthController authController = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Enter your credential to Login",
              style: textStyle2,
            ),
            SizedBox(height: 30,),
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
                        : Text("LOGIN",style: textStyle5,),
                  ),)
              ),
            ),
            SizedBox(
              height: 20,
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
    );
  }
}
