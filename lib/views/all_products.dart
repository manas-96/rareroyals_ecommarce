import 'package:flutter/material.dart';
import 'package:rare_royals_in_corporated/data/models/product_model.dart';
import 'package:rare_royals_in_corporated/views/components/app_bar_widget.dart';
import 'package:rare_royals_in_corporated/views/components/home_product.dart';

import '../helper.dart';

class AllProducts extends StatefulWidget {
  final title;
  final List<ProductModel> products;
  const AllProducts({Key key, this.title, this.products}) : super(key: key);

  @override
  _AllProductsState createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: color1,
      appBar: appBarWidget(
        leading: true,
        title: Text(widget.title,style: textStyle7,)
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: [
            HomeProduct(allProduct: true,products: widget.products,)
          ],
        ),
      ),
    );
  }
}
