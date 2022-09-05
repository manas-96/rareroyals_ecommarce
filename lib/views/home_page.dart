import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rare_royals_in_corporated/data/api_response.dart';
import 'package:rare_royals_in_corporated/data/models/product_model.dart';
import 'package:rare_royals_in_corporated/logic/product_controller.dart';
import 'package:rare_royals_in_corporated/views/all_products.dart';
import 'package:rare_royals_in_corporated/views/components/app_bar_widget.dart';
import 'package:rare_royals_in_corporated/views/components/category.dart';
import 'package:rare_royals_in_corporated/views/components/home_product.dart';
import 'package:rare_royals_in_corporated/views/components/loader.dart';
import 'package:rare_royals_in_corporated/views/components/product_not_found.dart';

import '../helper.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ProductController productController = Get.put(ProductController());
  @override
  void initState() {
    allCollection();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color1,
      appBar: appBarWidget(),
      drawer: Drawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Popular Category",style: textStyle2,),
              SizedBox(height: 10,),
              Container(
                height: 130,
                width: MediaQuery.of(context).size.width,
                child: CategoryWidget(),
              ),
              SizedBox(height: 10,),
              banners.isEmpty?Container():Container(
                height: 150.0,
                width: MediaQuery.of(context).size.width,
                child: Carousel(
                  boxFit: BoxFit.cover,
                  autoplay: false,
                  animationCurve: Curves.fastOutSlowIn,
                  animationDuration: Duration(milliseconds: 1000),
                  dotSize: 6.0,
                  dotIncreasedColor: Colors.blueGrey,
                  dotBgColor: Colors.transparent,
                  //dotPosition: DotPosition.topRight,
                  dotVerticalPadding: 10.0,
                  showIndicator: true,
                  indicatorBgPadding: 7.0,
                  images: [
                    NetworkImage(banners[0]["image"]),
                    NetworkImage(banners[1]["image"]),
                    NetworkImage(banners[2]["image"]),
                    NetworkImage(banners[3]["image"]),
                    NetworkImage(banners[4]["image"]),
                    NetworkImage(banners[5]["image"]),
                  ],
                ),
              ),
              SizedBox(height: 10,),
              allProduct()

            ],
          ),
        ),
      ),
    );
  }
  List banners=[];
  List<ProductModel> all=[];
  List<ProductModel> gold=[];
  List<ProductModel> bestSeller=[];
  RxBool dataNotFound=false.obs;
  RxBool isLoading=false.obs;
  allCollection()async{
    isLoading.value=true;
    final result = await ApiResponse().postFunction({}, "home");
    if(result!="failed" && result["data"].isNotEmpty){
      setState(() {
        for(int i=0; i<result["data"]["banners"].length;i++){
          banners.add(result["data"]["banners"][i]);
        }
        for(int i=0; i<result["data"]["all_collection"].length;i++){
          all.add(ProductModel.fromJson(result["data"]["all_collection"][i]));
        }
        for(int i=0; i<result["data"]["gold_collection_product"].length;i++){
          gold.add(ProductModel.fromJson(result["data"]["gold_collection_product"][i]));
        }
        for(int i=0; i<result["data"]["best_seller"].length;i++){
          bestSeller.add(ProductModel.fromJson(result["data"]["best_seller"][i]));
        }
      });
      isLoading.value=false;
      return result;
    }
    else{
      dataNotFound.value=true;
      isLoading.value=false;
    }
  }
  allProduct(){
    if(dataNotFound.value){
      return productNotFound();
    }
    if(isLoading.value){
      return loader();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20,),
        Container(width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("All Collections",style: textStyle2,),
              InkWell(
                onTap: (){
                  Get.to(AllProducts(
                    title: "All Collections",
                    products: all,
                  ));
                },
                child: Text("View all",style: textStyle1,),
              )
            ],
          ),
        ),
        SizedBox(height: 20,),
        HomeProduct(products: all, allProduct: false,),
        SizedBox(height: 20,),
        Container(width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Best Sellers",style: textStyle2,),
              InkWell(
                onTap: (){
                  Get.to(AllProducts(
                    title: "Best Sellers",
                    products: bestSeller,
                  ));
                },
                child: Text("View all",style: textStyle1,),
              )
            ],
          ),
        ),
        SizedBox(height: 20,),
        HomeProduct(products: bestSeller,allProduct: false,),
        SizedBox(height: 20,),
        Container(width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Gold Collections",style: textStyle2,),
              InkWell(
                onTap: (){
                  Get.to(AllProducts(
                    title: "Gold Collections",
                    products: gold,
                  ));
                },
                child: Text("View all",style: textStyle1,),
              )
            ],
          ),
        ),
        SizedBox(height: 20,),
        HomeProduct(products: gold, allProduct: false,),
        SizedBox(height: 20,),
      ],
    );
  }
}
