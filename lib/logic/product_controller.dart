

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rare_royals_in_corporated/data/api_response.dart';
import 'package:rare_royals_in_corporated/data/models/product_model.dart';
import 'package:rare_royals_in_corporated/helper.dart';

class ProductController extends GetxController{
  RxBool productLoaded = false.obs;
  RxList productSize = [].obs;
  getProduct()async{
    List<ProductModel>products=[];
    final data = await ApiResponse().getProduct();
    if(data["data"].length==0){
      productLoaded.value=true;
      return;
    }
    productLoaded.value=false;
    if(data!="failed" && data["response_code"]=="200"){
      for(int i=0;i<data["data"].length;i++){
        products.add(ProductModel.fromJson(data["data"][i]));
      }
    }
    else{
      Get.snackbar("Error", "Error while loading data",colorText: errorColor);
    }
    return products;
  }
  categoryWiseProduct(String id)async{
    print(id);
    productLoaded.value=false;
    List<ProductModel>products=[];
    final data = await ApiResponse().categoryWiseProduct(id);
    if(data["data"].length==0){
      productLoaded.value=true;
      return;
    }
    productLoaded.value=false;
    if(data!="failed" && data["response_code"]=="200"){
      for(int i=0;i<data["data"].length;i++){
        products.add(ProductModel.fromJson(data["data"][i]));
      }
    }
    else{
      Get.snackbar("Error", "Error while loading data",colorText: errorColor);
    }
    return products;
  }
  subCategoryWiseProduct(String id)async{
    print(id);
    productLoaded.value=false;
    List<ProductModel>products=[];
    final data = await ApiResponse().subCategoryWiseProduct(id);
    if(data["data"].length==0){
      productLoaded.value=true;
      return;
    }
    productLoaded.value=false;
    if(data!="failed" && data["response_code"]=="200"){
      for(int i=0;i<data["data"].length;i++){
        products.add(ProductModel.fromJson(data["data"][i]));
      }
    }
    else{
      Get.snackbar("Error", "Error while loading data",colorText: errorColor);
    }
    return products;
  }

}