import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rare_royals_in_corporated/logic/product_controller.dart';

import '../helper.dart';
import 'components/app_bar_widget.dart';
import 'components/home_product.dart';
import 'components/loader.dart';
import 'components/product_not_found.dart';


class SubcategoryProduct extends StatefulWidget {
  final id;
  final name;
  const SubcategoryProduct({Key key, this.id, this.name}) : super(key: key);

  @override
  _SubcategoryProductState createState() => _SubcategoryProductState();
}

class _SubcategoryProductState extends State<SubcategoryProduct> {
  final ProductController productController = Get.put(ProductController());
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
                FutureBuilder(
                  future: productController.subCategoryWiseProduct(widget.id),
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
