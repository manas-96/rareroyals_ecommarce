import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rare_royals_in_corporated/logic/profile_controller.dart';
import 'package:rare_royals_in_corporated/views/change_password.dart';
import 'package:rare_royals_in_corporated/views/components/loader.dart';
import 'package:rare_royals_in_corporated/views/log_in.dart';
import 'package:rare_royals_in_corporated/views/order_list.dart';
import 'package:rare_royals_in_corporated/views/update_profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helper.dart';

class Profile extends StatefulWidget {
  const Profile({Key key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  ProfileController controller = Get.put(ProfileController());
  @override
  void initState() {
    controller.getProfile();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color1,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Obx(()=>controller.isLoading.value?loader():ListView(
          children: [
            SizedBox(height: 50,),
            Container(
              //height: MediaQuery.of(context).size.height-MediaQuery.of(context).size.height/3,
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                            border: Border.all(color: Theme.of(context).primaryColor,width: 1),
                            color: Colors.white,
                            shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: Icon(Icons.person,size: 40,color: color3,),
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  controller.isLogin.value?Text(controller.name.value,style: textStyle2,):Container(),
                  SizedBox(height: 5,),
                  controller.isLogin.value?Text(controller.email.value,style: textStyle2,):Container(),
                  controller.isLogin.value?SizedBox(height: 30,):Container(),
                  Container(width: MediaQuery.of(context).size.width*0.9,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                          InkWell(
                            onTap: (){
                              if(controller.isLogin.value){
                                Get.to(UpdateProfile());
                              }
                            },
                            child: ListTile(
                              title: Text("Update account",style: textStyle1),
                              trailing: Icon(Icons.arrow_forward_ios_sharp,color: color3,),
                            ),
                          ),

                          SizedBox(height: 5,),
                          InkWell(
                            onTap: (){
                              if(controller.isLogin.value){
                                Get.to(OrderList());
                              }
                            },
                            child: ListTile(
                              title: Text("Order history",style: textStyle1,),
                              trailing: Icon(Icons.arrow_forward_ios_sharp, color: color3,),
                            ),
                          ),

                          SizedBox(height: 5,),
                          InkWell(
                            onTap: (){
                              if(controller.isLogin.value){
                                Get.to(ChangePassword());
                              }
                            },
                            child: ListTile(
                              title: Text("Change password",style: textStyle1,),
                              trailing: Icon(Icons.arrow_forward_ios_sharp, color: color3,),
                            ),
                          ),
                          SizedBox(height: 5,),
                          InkWell(
                            onTap: (){
                              logOut();
                            },
                            child: ListTile(
                              title: Text(controller.isLogin.value?"Log Out":"Login",style: textStyle1,),
                              trailing: Icon(Icons.arrow_forward_ios_sharp, color: color3,),
                            ),
                          ),
                          Divider(thickness: 1,),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ))
      ),
    );
  }
  logOut()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if(preferences.getString("id")!=null)
      preferences.clear();
    Get.to(Login());
  }
}
