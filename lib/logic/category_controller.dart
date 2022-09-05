


import 'dart:convert';

import 'package:get/get.dart';
import 'package:rare_royals_in_corporated/data/api_response.dart';
import 'package:rare_royals_in_corporated/data/models/category_model.dart';

class CategoryController extends GetxController{
  getCategory()async{
    List<CategoryModel>category=[];
    final data = await ApiResponse().getCategory();
    if(data!="failed"){
      for(int i=0;i<data["data"].length;i++){
        category.add(CategoryModel.fromJson(data["data"][i]));
      }
    }
    return category;
  }
  subCategory(String id)async{
    List<CategoryModel>category=[];
    final data = await ApiResponse().postFunction(json.encode({"category":id}), "subcategory");
    if(data!="failed"){
      for(int i=0;i<data["data"].length;i++){
        category.add(CategoryModel.fromJson(data["data"][i]));
      }
    }
    return category;
  }
}