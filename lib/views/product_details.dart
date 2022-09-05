import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:get/get.dart';
import 'package:rare_royals_in_corporated/logic/cart_controller.dart';
import 'package:rare_royals_in_corporated/logic/product_controller.dart';
import 'package:rare_royals_in_corporated/logic/wishlist_controller.dart';
import 'package:rare_royals_in_corporated/views/buy_product.dart';
import 'package:rare_royals_in_corporated/views/components/app_bar_widget.dart';

import '../helper.dart';



class ProductDetails extends StatefulWidget {
  final  product;
  const ProductDetails({Key key, this.product}) : super(key: key);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  RxInt qty=1.obs;
  RxBool loading = false.obs;
  RxString dropdownvalue="7".obs;
  ProductController productController = Get.put(ProductController());
  CartController cartController = Get.put(CartController());
  WishlistController wishlistController = Get.put(WishlistController());
  List<dynamic> productSize=[].obs;
  getSizeList(String s){
    var size = "[$s]";
    var sizeList = json.decode(size);
    for(int i=0;i<sizeList.length;i++){
      productSize.add(sizeList[i]);
    }
  }

  @override
  void initState() {
    getSizeList(widget.product.size);
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: color1,
      appBar: appBarWidget(leading: true, title: null),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              Container(
                height: MediaQuery.of(context).size.height*0.35,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(widget.product.image),
                        fit: BoxFit.fill
                    )
                ),
              ),
              SizedBox(height: 15,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.product.name,style: textStyle4,),
                    SizedBox(height: 10,),
                    Text("\$ ${widget.product.price}",style: textStyle4,),
                    SizedBox(height: 10,),
                    productSize.isEmpty?Container():
                    Obx(()=>Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                            color: Colors.grey, style: BorderStyle.solid, width: 0.80),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Select Size",style: textStyle5,),
                          DropdownButtonHideUnderline(
                            child: DropdownButton(
                                elevation: 0,
                                value: dropdownvalue.value,

                                icon: Icon(Icons.keyboard_arrow_down),

                                items:productSize.map((items) {
                                  return DropdownMenuItem(
                                      value: items.toString(),
                                      child: Text("$items(US)",style: textStyle6,)
                                  );
                                }
                                ).toList(),

                                onChanged: (val){
                                  dropdownvalue.value=val.toString();
                                }

                            ),
                          ),
                        ],
                      )
                    ),),
                    SizedBox(height: 10,),
                    Text("Add quantity",style: textStyle4,),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Container(
                          height: 40,width: 40,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5)
                          ),
                          alignment: Alignment.center,
                          child: IconButton(
                            icon: Icon(Icons.remove,color: Colors.black,),
                            onPressed: (){
                              if(qty.value>1){
                                qty.value--;
                              }
                            },
                          ),
                        ),
                        SizedBox(width: 10,),
                        Obx(()=>Text(qty.value.toString(),style: textStyle4,),),
                        SizedBox(width: 10,),
                        Container(
                          height: 40,width: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5)
                          ),
                          alignment: Alignment.center,
                          child: IconButton(
                            icon: Icon(Icons.add,color: Colors.black,),
                            onPressed: (){
                              qty.value++;
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: (){
                              Get.to(BuyProduct(
                                product: widget.product,
                                qty: qty.value,
                                size: dropdownvalue.value,
                              ));
                            },
                            child: Container(
                              height: 40,
                              decoration: BoxDecoration(
                                  color: color3,
                                  borderRadius: BorderRadius.circular(5)
                              ),
                              alignment: Alignment.center,
                              child: Text("BUY NOW",style: textStyle4,)
                            ),
                          ),
                        ),
                        SizedBox(width: 10,),
                        Container(
                          height: 40,width: 40,
                          decoration: BoxDecoration(
                              border: Border.all(color: color3),
                              borderRadius: BorderRadius.circular(5)
                          ),
                          alignment: Alignment.center,
                          child: IconButton(
                            icon: Icon(Icons.shopping_cart_sharp,color: color3,),
                            onPressed: (){
                              cartController.addToCart(
                                  widget.product.id, 
                                  dropdownvalue.value,
                                  qty.string, widget.product.price,
                                  widget.product.name, widget.product.image
                              );
                            },
                          ),
                        ),
                        SizedBox(width: 10,),
                        Container(
                          height: 40,width: 40,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.red),
                              borderRadius: BorderRadius.circular(5)
                          ),
                          alignment: Alignment.center,
                          child: IconButton(
                            icon: Icon(Icons.favorite,color: Colors.red),
                            onPressed: (){
                              wishlistController.addToWishlist(widget.product.id);
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Html(
                        data: widget.product.attribute,
                       style: {
                         "p": Style(
                             color: Colors.white,fontWeight: FontWeight.bold
                         ),
                       },
                    ),
                    Container(height: 100,)

                  ],
                ),
              )
            ],
          ),
        )
      )
    );
  }
}
