import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rare_royals_in_corporated/logic/order_controller.dart';

import '../helper.dart';
import 'components/app_bar_widget.dart';

class BuyProduct extends StatefulWidget {
  final size;
  final qty;
  final product;
  const BuyProduct({Key key, this.product, this.size, this.qty}) : super(key: key);

  @override
  _BuyProductState createState() => _BuyProductState();
}

class _BuyProductState extends State<BuyProduct> {
  String address="";
  String pincode="";
  OrderController controller = Get.put(OrderController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: color1,
      appBar: appBarWidget(
          leading: true,
          title: Text("Check Out",style: textStyle7,)
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20.0,bottom: 20),
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
                          height: 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  image: NetworkImage(widget.product.image),
                                  fit: BoxFit.cover
                              )
                          ),
                        ),
                        SizedBox(width: 10,),
                        Column(crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width*0.5,
                              child: Text(widget.product.name,style: textStyle6,overflow: TextOverflow.clip,),
                            ),
                            SizedBox(height: 6,),
                            Text("\$ ${
                                (double.parse(widget.product.price)*widget.qty).toInt()
                            }",
                              style: TextStyle(fontWeight: FontWeight.bold,color: Colors.green),),
                            SizedBox(height: 6,),
                            Text("Quantity ${
                                widget.qty.toString()
                            // getPrice(double.parse(widget.product.price),double.parse(widget.product.qty))
                            }",
                              style: textStyle6,),
                            SizedBox(height: 6,),
                            Text("Size ${
                                widget.size
                            // getPrice(double.parse(widget.product.price),double.parse(widget.product.qty))
                            } (US)",
                              style: textStyle6,),
                            SizedBox(height: 6,),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),

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

              InkWell(
                onTap: () {
                  if(controller.address.value==""){
                    Get.snackbar("Field Empty", "Please enter Address",colorText: Colors.red);
                  }
                  else if(controller.pincode.value==""){
                    Get.snackbar("Field Empty", "Please enter Pincode",colorText: Colors.red);
                  }
                  else{
                    controller.createOrder(
                        widget.qty.toString(),
                        widget.size,
                        (double.parse(widget.product.price)*widget.qty).toInt().toString(),
                        widget.product.id);
                  }
                },
                child: Container(
                    height: 42,
                    width: MediaQuery.of(context).size.width/2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      color: color3,

                    ),
                    alignment: Alignment.center,
                    child: Obx(()=>Padding(
                      padding: const EdgeInsets.all(5.0),
                      child:controller.isLoading.value?
                      CircularProgressIndicator(backgroundColor: Colors.white,)
                          : Text("BUY NOW",style: textStyle5,),
                    ),)
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
