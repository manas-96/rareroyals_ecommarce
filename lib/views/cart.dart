import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rare_royals_in_corporated/logic/auth_controller.dart';
import 'package:rare_royals_in_corporated/logic/cart_controller.dart';
import 'package:rare_royals_in_corporated/logic/order_controller.dart';
import 'package:rare_royals_in_corporated/views/components/fake_cart.dart';
import 'package:rare_royals_in_corporated/views/components/loader.dart';
import 'package:rare_royals_in_corporated/views/components/product_not_found.dart';
import 'package:rare_royals_in_corporated/views/log_in.dart';

import '../helper.dart';
import 'components/app_bar_widget.dart';
import 'components/buttons.dart';


class Cart extends StatefulWidget {
  const Cart({Key key}) : super(key: key);

  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  String getPrice(double price,double qty){
    int p= price~/qty;
    return p.toString();
  }
  CartController cartController = Get.put(CartController());
  AuthController authController = Get.put(AuthController());
  OrderController controller = Get.put(OrderController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color1,
      appBar: appBarWidget(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: FutureBuilder(
            future: authController.checkLogin(),
            builder: (context,snapshot){
              if(snapshot.data==null){
                return loader();
              }
              if(!snapshot.data){
                return FakeCart();
              }
              return FutureBuilder(
                future: cartController.getCartList(),
                builder: (context,snap){
                  if(snap.data=="empty"){
                    return productNotFound();
                  }
                  if(snap.data==null){
                    return loader();
                  }
                  return getCartItems();
                },
              );
            },
          )
        ),
      ),
    );
  }
  getCartItems(){
    return Column(
      children: [
        Obx(()=>ListView.builder(
          itemCount: cartController.cartList.length,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context,index){

            return Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)
                ),
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width*0.3 ,
                        height: 80,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                image: NetworkImage(cartController.cartList[index].image),
                                fit: BoxFit.cover
                            )
                        ),
                      ),
                      SizedBox(width: 10,),
                      Column(crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width*0.5,
                            child: Text(cartController.cartList[index].name,style: textStyle6,overflow: TextOverflow.clip,),
                          ),
                          SizedBox(height: 6,),
                          Text("\$ ${
                              cartController.cartList[index].price
                          // getPrice(double.parse(cartController.cartList[index].price),double.parse(cartController.cartList[index].qty))
                          }",
                            style: TextStyle(fontWeight: FontWeight.bold,color: Colors.green),),
                          SizedBox(height: 6,),
                          Container(
                            width: MediaQuery.of(context).size.width/2-20,
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap:(){
                                    cartController.updateCart(
                                        cartController.cartList[index].id,
                                        cartController.cartList[index].size,
                                        (double.parse(cartController.cartList[index].qty).toInt()+1).toString(),
                                        cartController.cartList[index].price
                                    );
                                    cartController.getPrice();
                                  },
                                  child: CircleAvatar(radius: 15,
                                    backgroundColor: color3,
                                    child: Icon(Icons.add,color: Colors.white,),
                                  ),
                                ),
                                SizedBox(width: 10,),
                                Text(cartController.cartList[index].qty,style: TextStyle(color: Colors.green,fontWeight: FontWeight.w500),),
                                SizedBox(width: 10,),
                                GestureDetector(
                                  onTap:(){
                                    if(double.parse(cartController.cartList[index].qty).toInt()>1){
                                      cartController.updateCart(
                                          cartController.cartList[index].id,
                                          cartController.cartList[index].size,
                                          (double.parse(cartController.cartList[index].qty).toInt()-1).toString(),
                                          cartController.cartList[index].price
                                      );

                                    }
                                    cartController.getPrice();
                                  },
                                  child: CircleAvatar(radius: 15,
                                    backgroundColor: color3,
                                    child: Icon(Icons.remove,color: Colors.white,),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 5,),
                          Row(
                            children: [
                              InkWell(
                                onTap: (){
                                  cartController.deleteCart(cartController.cartList[index].id,index);
                                  cartController.getPrice();
                                },
                                child: Text("Remove",
                                  style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red),
                                ),
                              ),
                              SizedBox(width: 20,),
                              Text("Size : ${cartController.cartList[index].size}(US)",style: textStyle6,)
                            ],
                          ),
                          SizedBox(height: 5,),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            );
          },
        ),),

        SizedBox(height: 25,),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white),
          child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: TextField(
                onChanged: (val) {
                  controller.address.value=val;
                },
                decoration: InputDecoration(
                    hintText: "Full Address",
                    hintStyle: textStyle1,
                    border: InputBorder.none),
              )
          ),
        ),
        SizedBox(height: 15,),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white),
          child: Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8),
              child: TextField(
                keyboardType: TextInputType.number,
                onChanged: (val) {
                  controller.pincode.value=val;
                },
                decoration: InputDecoration(
                    hintText: "Pincode",
                    hintStyle: textStyle1,
                    border: InputBorder.none),
              )
          ),
        ),

        SizedBox(height: 25,),
        Container(
          width: Get.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white
          ),
          child: Obx(()=>Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Cart total : \$${cartController.price.value.toString()}"),
                SizedBox(height: 5,),
                Text("Shipping & taxes : \$${cartController.shippingCost.value.toString()}"),
                SizedBox(height: 5,),
                Text("Order total : \$${cartController.totalPrice.value.toString()}"),
              ],
            ),
          ),),
        ),
        SizedBox(height: 25,),
        InkWell(
          onTap: () {
            controller.multiBuy();
          },
          child: Container(
              height: 45,
              width: MediaQuery.of(context).size.width/2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                color: color3,

              ),
              alignment: Alignment.center,
              child: Obx(()=>Padding(
                padding: const EdgeInsets.all(5.0),
                child:controller.isLoading.value?
                CircularProgressIndicator(backgroundColor: Colors.white,)
                    : Text("BUY",style: textStyle5,),
              ),)
          ),
        ),
      ],
    );
  }

}
