import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rare_royals_in_corporated/logic/profile_controller.dart';

import '../helper.dart';
import 'components/app_bar_widget.dart';



class UpdateProfile extends StatefulWidget {
  const UpdateProfile({Key key}) : super(key: key);

  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  ProfileController profileController = Get.put(ProfileController());
  String name="";
  String email="",mobile="",location="",pincode="";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color1,
      appBar: appBarWidget(
          leading: true,
          title: Text("Update profile",style: textStyle1,)
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text(
                "Update your account here.",
                style: textStyle2,
              ),
              SizedBox(height: 30,),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white),
                child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8),
                    child: TextField(
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (val) {
                        name=val;
                      },
                      decoration: InputDecoration(
                          hintText: "Name",
                          hintStyle: textStyle1,
                          border: InputBorder.none),
                    ),
                ),
              ),
              SizedBox(height: 15,),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8),
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (val) {
                      email=val;
                    },
                    decoration: InputDecoration(
                        hintText: "Email",
                        hintStyle: textStyle1,
                        border: InputBorder.none),
                  ),
                ),
              ),
              SizedBox(height: 15,),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8),
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (val) {
                      mobile=val;
                    },
                    decoration: InputDecoration(
                        hintText: "Mobile",
                        hintStyle: textStyle1,
                        border: InputBorder.none),
                  ),
                ),
              ),
              SizedBox(height: 15,),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8),
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (val) {
                      location=val;
                    },
                    decoration: InputDecoration(
                        hintText: "Location",
                        hintStyle: textStyle1,
                        border: InputBorder.none),
                  ),
                ),
              ),
              SizedBox(height: 15,),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8),
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (val) {
                      pincode=val;
                    },
                    decoration: InputDecoration(
                        hintText: "Pincode",
                        hintStyle: textStyle1,
                        border: InputBorder.none),
                  ),
                ),
              ),
              SizedBox(height: 15,),
              SizedBox(
                height: 30,
              ),

              InkWell(
                onTap: () {
                  profileController.updateProfile(name, email, mobile, location, pincode);
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
                      child:profileController.isLoading.value?
                      CircularProgressIndicator(backgroundColor: Colors.white,)
                          : Text("UPDATE",style: textStyle5,),
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
