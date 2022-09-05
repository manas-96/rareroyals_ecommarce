import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rare_royals_in_corporated/data/api_response.dart';
import 'package:rare_royals_in_corporated/logic/cart_controller.dart';
import 'package:rare_royals_in_corporated/views/order_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OrderController extends GetxController{
  CartController cartController=Get.put(CartController());
  RxBool isLoading=false.obs;
  RxString address="".obs;
  RxString pincode="".obs;
  generateRandom(){
    var rng = new Random();
    var l = new List.generate(3, (_) => rng.nextInt(90)+10);
    String rand="RRORDER";
    for(int i=0;i<l.length;i++){
      rand = rand+l[i].toString();
    }
    return rand;
  }
  Future<String>getUser()async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString("id");
  }
  getOrder()async{
    final userId = await getUser();
    final body={
      "user":userId
    };
    final result = await ApiResponse().postFunction(json.encode(body), "order");
    if(result["response_code"]=="200"){
      return result["data"];
    }
    else return "failed";
  }
  createOrder(String qty, String size, String amount, String productId)async{
    final id=await getUser();
    if(id==null){
      Get.snackbar("Unauthenticated ", "Please Login to continue.",colorText: Colors.red,);
      return;
    }
    String orderId= generateRandom().toString();
    String userId=await getUser();
    final body={
      "order_id" : orderId,
      "user" : userId,
      "product" : productId,
      "qty" : qty,
      "size" : size,
      "amount" : amount,
      "payment_method" : "STRIPE",
      "payment_by" : "CARD",
      "transaction_id" : orderId,
      "status" : 1,
      "shipping_address" : address.value,
      "pincode" : pincode.value
    };
    isLoading.value=true;
    final result = await ApiResponse().postFunction(jsonEncode(body), "order/create");
    isLoading.value=false;
    if(result!="failed"&& result["response_code"]=="200"){
      Get.snackbar("Congratulation", result["message"].toString(),colorText: Colors.green);
      Future.delayed(
        Duration(seconds: 2),
          (){
            Get.to(()=>OrderList());
          }
      );
      return;
    }
    Get.snackbar("Order failed ", "Please try after sometime.",colorText: Colors.red);
  }
  orderTotal(String qty, String price){
    var total= double.parse(qty)*double.parse(price);
    total=total+total*8.5/100;
    return total.toString();
  }
  multiBuy()async{
    if(address.value==""){
      Get.snackbar("Empty field", "Please enter your full address",colorText: Colors.red);
      return;
    }
    if(pincode.value==""){
      Get.snackbar("Empty field", "Please enter your Pincode",colorText: Colors.red);
      return;
    }
    String product="";
    String size="";
    String qty=""; double price=0;
    for(int i=0; i<cartController.cartList.length;i++){
      price = price+double.parse(cartController.cartList[i].price)*double.parse(cartController.cartList[i].qty);
      if(i==cartController.cartList.length-1){
        product=product+cartController.cartList[i].id;
        size=size+cartController.cartList[i].size;
        qty=qty+cartController.cartList[i].qty;
      }
      else{
        product=product+cartController.cartList[i].id+",";
        size=size+cartController.cartList[i].size+",";
        qty=qty+cartController.cartList[i].qty+",";
      }
    }
    String orderId= generateRandom().toString();
    String userId=await getUser();
    price=price+(price*8.5/100);
    final body={
    "order_id" : orderId,
    "user" : userId,
    "product" : product,
    "qty" : qty,
    "size" : size,
    "amount" : price.toString(),
    "payment_method" : "STRIPE",
    "payment_by" : "CARD",
    "transaction_id" : orderId,
    "status" : 1,
    "shipping_address" : address.value,
    "pincode" : pincode.value
    };
    isLoading.value=true;
    final result = await ApiResponse().postFunction(jsonEncode(body), "order/create");
    isLoading.value=false;
    if(result!="failed"&& result["response_code"]=="200"){
      Get.snackbar("Congratulation", result["message"].toString(),colorText: Colors.green);
      Future.delayed(
          Duration(seconds: 2),
              (){
            Get.to(()=>OrderList());
          }
      );
      return;
    }
    Get.snackbar("Order failed ", "Please try after sometime.",colorText: Colors.red);

  }
}