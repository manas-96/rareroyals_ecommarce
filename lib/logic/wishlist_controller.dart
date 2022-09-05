import 'dart:convert';

import 'package:get/get.dart';
import 'package:rare_royals_in_corporated/data/api_response.dart';
import 'package:rare_royals_in_corporated/data/models/wishlist_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helper.dart';

class WishlistController extends GetxController{

  List<WishlistModel> wishlist = [];
  getWishlist()async{
    wishlist=[];
    String userId = await getUser();
    final body = {"user":userId};
    final result = await ApiResponse().postFunction(json.encode(body), "wishlist");
    if(result!="failed" && result["data"].isNotEmpty){
      for(int i=0; i<result["data"].length; i++){
        wishlist.add(WishlistModel.fromJson(result["data"][i]));
      }
      return wishlist;
    }
    return "empty";
  }

  addToWishlist(String id )async{
    String userId = await getUser();
    if(userId==null){
      Get.snackbar("Please Login", "Tap to login",colorText: errorColor, );
      return;
    }
    final body={
      "user":userId,
      "product":id,
    };
    final result = await ApiResponse().postFunction(json.encode(body), "wishlist/create");
    Get.snackbar("Wishlist Message", result["message"],colorText: successColor);
  }

  deleteWishlist(String productId)async{
    for(int i=0; i<wishlist.length; i++){
      if(wishlist[i].id==productId){
        wishlist.removeAt(i);
      }
    }
    String userId = await getUser();
    final body = {"user":userId, "product":productId};
    final result = await ApiResponse().postFunction(json.encode(body), "wishlist/deleteProduct");
    Get.snackbar("Wishlist message", result["message"],colorText: errorColor);
  }

  getUser()async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String userId = sharedPreferences.getString("id");
    return userId;
  }
}