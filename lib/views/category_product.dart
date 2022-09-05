import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rare_royals_in_corporated/data/models/category_model.dart';
import 'package:rare_royals_in_corporated/data/models/product_model.dart';
import 'package:rare_royals_in_corporated/logic/category_controller.dart';
import 'package:rare_royals_in_corporated/logic/product_controller.dart';
import 'package:rare_royals_in_corporated/views/components/app_bar_widget.dart';
import 'package:rare_royals_in_corporated/views/components/home_product.dart';
import 'package:rare_royals_in_corporated/views/components/loader.dart';
import 'package:rare_royals_in_corporated/views/components/product_not_found.dart';
import 'package:rare_royals_in_corporated/views/subcategory_product.dart';

import '../helper.dart';


class CategoryProduct extends StatefulWidget {
  final id;
  final name;
  CategoryProduct({Key key, this.id, this.name,}) : super(key: key);

  @override
  _CategoryProductState createState() => _CategoryProductState();
}

class _CategoryProductState extends State<CategoryProduct> {
  final ProductController productController = Get.put(ProductController());
  final CategoryController categoryController = Get.put(CategoryController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: color1,
      appBar: appBarWidget(leading: true,title: Text(widget.name,style: textStyle7,)),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 120,
                width: MediaQuery.of(context).size.width,
                child: FutureBuilder(
                  future: categoryController.subCategory(widget.id),
                  builder: (context,snap){
                    if(snap.data==null){
                      return Container();
                    }
                    final List<CategoryModel> category = snap.data;
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: category.length,
                      itemBuilder: (context,index){
                        return Padding(
                          padding: const EdgeInsets.only(right: 12.0),
                          child: InkWell(
                              onTap: (){
                                Get.to(SubcategoryProduct(
                                  id: category[index].id,
                                  name: category[index].name,
                                ));
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(height: 10,),
                                  Container(
                                    width: 70,height: 70,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.white,
                                        border: Border.all(color: color3),
                                        image: DecorationImage(
                                            image: category[index].image==null?
                                            AssetImage("images/logo.png")
                                                :NetworkImage(category[index].image),fit: BoxFit.cover
                                        )
                                    ),
                                  ),
                                  SizedBox(height: 8,),
                                  Text(category[index].name,style: TextStyle(color: color3,fontSize: 10,fontWeight: FontWeight.bold),)
                                ],
                              )
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              SizedBox(height: 12,),
              FutureBuilder(
                future: productController.categoryWiseProduct(widget.id),
                builder: (context,snap){
                  if(productController.productLoaded.value){
                    return productNotFound();
                  }
                  if(snap.data==null){
                    return loader();
                  }
                  return HomeProduct(
                    products: snap.data, allProduct: true,
                  );
                },
              ),
            ],
          )
        ),
      ),

    );
  }
}
