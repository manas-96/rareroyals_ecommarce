import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;


class ApiResponse{
  final baseUrl = "https://rareroyalsincorporated.com/api/";
  _buildHeader(){
    return {
      'accept' : 'application/json',
      'cache-control' : 'no-cache',
    };
  }
   postFunction(body,url)async{
     final header = _buildHeader();
     final response = await http.post(baseUrl+url,body: body,headers: header);
     print(json.decode(response.body));
     if(response.statusCode==200){
       return json.decode(response.body);
     }
     return "failed";
   }
  getFunction(body,url)async{
    final header = _buildHeader();
    final response = await http.get(baseUrl+url,headers: header);
    if(response.statusCode==200){
      return json.decode(response.body);
    }
    return "failed";
  }
  getCategory()async{
    final header = _buildHeader();
    final response = await http.post(baseUrl+"category",headers: header);
    print(response.body);
    if(response.statusCode==200){
      return json.decode(response.body);
    }
    return "failed";
  }
  getProduct()async{
    final header = _buildHeader();
    final response = await http.post(baseUrl+"product",headers: header);
    print(response.body);
    if(response.statusCode==200){
      return json.decode(response.body);
    }
    return "failed";
  }
  categoryWiseProduct(String id)async{
    final body={
      "category" : id
    };
    final header = _buildHeader();
    final response = await http.post(baseUrl+"product/categoryWiseProduct",headers: header,body: jsonEncode(body));
    print(response.body);
    if(response.statusCode==200){
      return json.decode(response.body);
    }
    return "failed";
  }
  subCategoryWiseProduct(String id)async{
    final body={
      "subcategory" : id
    };
    final header = _buildHeader();
    final response = await http.post(baseUrl+"product/subcategoryWiseProduct",headers: header,body: jsonEncode(body));
    print(response.body);
    if(response.statusCode==200){
      return json.decode(response.body);
    }
    return "failed";
  }

}