import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rare_royals_in_corporated/data/api_response.dart';
import 'package:rare_royals_in_corporated/data/models/cart_model.dart';
import 'package:rare_royals_in_corporated/views/log_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helper.dart';



class CartController extends GetxController{
  getUser()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String userId = sharedPreferences.getString("id");
    return userId;
  }
  gotoLogin(){
    Get.to(Login());
  }
  RxList fakeCartList=[].obs;
  addToFakeCart(String id, String name, String price, String qty, String size, String image)async{
    fakeCartList.clear();
    var myProduct={"id":id, "name":name, "price":price, "qty":qty, "size":size, "image":image};
    fakeCartList.add(CartModel.fromJson(myProduct));
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if(preferences.get("cart")!=null){
      final data = json.decode(preferences.get("cart"));
      for(int i=0; i<data.length; i++){
        fakeCartList.add(CartModel.fromJson(data[i]));
      }
    }
    preferences.setString("cart", json.encode(fakeCartList));
    Get.snackbar("Cart Message", "Product has added to cart",colorText: Colors.green);
  }
  getFakeCart()async{
    fakeCartList.clear();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if(preferences.get("cart")!=null){
      final data = json.decode(preferences.get("cart"));
      for(int i=0; i<data.length; i++){
        fakeCartList.add(CartModel.fromJson(data[i]));
      }
      return fakeCartList;
    }
    return "empty";
  }
  deleteFakeCart(int index)async{
    fakeCartList.clear();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if(preferences.get("cart")!=null){
      final data = json.decode(preferences.get("cart"));
      for(int i=0; i<data.length; i++){
        fakeCartList.add(CartModel.fromJson(data[i]));
      }
      fakeCartList.removeAt(index);
      preferences.setString("cart", json.encode(fakeCartList));
      Get.snackbar("Cart Message", "Product has deleted from cart",colorText: Colors.green);
    }
  }
  fakeToRealCart()async{
    fakeCartList.clear();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if(preferences.get("cart")!=null){
      final data = json.decode(preferences.get("cart"));
      for(int i=0; i<data.length; i++){
        fakeCartList.add(CartModel.fromJson(data[i]));
      }
      String product="";
      String size="";
      String qty=""; String price="";
      for(int i=0; i<fakeCartList.length;i++){
        if(i==fakeCartList.length-1){
          product=product+fakeCartList[i].id;
          size=size+fakeCartList[i].size;
          qty=qty+fakeCartList[i].qty;
          price = price+fakeCartList[i].price;
        }
        else{
          product=product+fakeCartList[i].id+",";
          size=size+fakeCartList[i].size+",";
          qty=qty+fakeCartList[i].qty+",";
          price = price+fakeCartList[i].price+",";
        }
      }
      final body={
        "user" : preferences.getString("id"),
        "product" : product,
        "qty" : qty,
        "size" : size,
        "price": price
      };
      try{
        final result = await ApiResponse().postFunction(json.encode(body), "cart/multiCreate");
      }catch(e){

      }

    }
  }
  addToCart(String id, String size, String qty, String price, String name, String image )async{
    String userId = await getUser();
    if(userId==null){
      addToFakeCart(id, name, price, qty, size, image);
      return;
    }
    final body={
      "user":userId,
      "product":id,
      "size":size,
      "qty":qty,
      "price": price
    };
    final result = await ApiResponse().postFunction(json.encode(body), "cart/create");
    Get.snackbar("Cart Message", result["message"],colorText: successColor);
  }
  RxList cartList = [].obs;
  getCartList()async{
    cartList.clear();
    String userId = await getUser();
    final body = {"user":userId};
    final result = await ApiResponse().postFunction(json.encode(body), "cart");
    if(result!="failed" && result["data"].isNotEmpty){
      for(int i=0; i<result["data"].length; i++){
        cartList.add(CartModel.fromJson(result["data"][i]));
      }
      getPrice();
      return cartList;
    }
    return "empty";
  }

  deleteCart(String productId,int index)async{
    cartList.removeAt(index);
    String userId = await getUser();
    final body = {"user":userId, "product":productId};
    final result = await ApiResponse().postFunction(json.encode(body), "cart/deleteProduct");
    getCartList();
    Get.snackbar("Cart message", result["message"],colorText: errorColor);
  }

  updateCart(String id, String size, String qty, String price )async{
    String userId = await getUser();
    final body={
      "user":userId,
      "product":id,
      "size":size,
      "qty":qty,
      "price": price
    };
    final result = await ApiResponse().postFunction(json.encode(body), "cart/edit");
    getCartList();
    Get.snackbar("Cart Message", result["message"],colorText: successColor);
  }

  RxDouble price=0.0.obs;
  RxDouble shippingCost=0.0.obs;
  RxDouble totalPrice=0.0.obs;
  getPrice(){
    price.value=0;
    shippingCost.value=0;
    totalPrice.value=0;
    for(int i=0; i<cartList.length; i++){
      price.value = price.value + double.parse(cartList[i].price)*double.parse(cartList[i].qty);
    }
    shippingCost.value=price.value*8.5/100;
    totalPrice.value=price.value+shippingCost.value;
  }


}