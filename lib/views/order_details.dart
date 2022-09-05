import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../helper.dart';
import 'components/app_bar_widget.dart';

class OrderDetails extends StatefulWidget {
  final data;
  const OrderDetails({Key key, this.data}) : super(key: key);

  @override
  _OrderDetailsState createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  List size=[];
  List qty=[];
  @override
  void initState() {
    setState(() {
      String lastSize;
      int i=0;
      while( i<widget.data["size"].toString().length){
        lastSize=widget.data["size"].toString().split(",").last;
        i++;
      }
      i=0;String s=widget.data["size"].toString();
      while( i<widget.data["size"].toString().length){
        size.add(s.split(",").first);
        i++;
      }
      size.add(lastSize);

      String lastQty;
      i=0;
      while( i<widget.data["qty"].toString().length){
        lastQty=widget.data["qty"].toString().split(",").last;
        i++;
      }
      i=0;String q=widget.data["qty"].toString();
      while( i<widget.data["qty"].toString().length){
        qty.add(s.split(",").first);
        i++;
      }
      qty.add(lastQty);

    });
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: color1,
      appBar: appBarWidget(
          leading: true,
          title: Text("Order details",style: textStyle1,)
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: Get.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: color3)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Container(
                        width: Get.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("ORDER ID",style: textStyle1,),
                            Text(widget.data["order_id"],style: textStyle1,),
                          ],
                        ),
                      ),
                      SizedBox(height: 8,),
                      Container(
                        width: Get.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("ORDER DATE",style: textStyle1,),
                            Text(widget.data["order_date"].toString().split(" ").first,style: textStyle1,),
                          ],
                        ),
                      ),
                      SizedBox(height: 8,),
                      Container(
                        width: Get.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("DELIVERY STATUS",style: textStyle1,),
                            Text(widget.data["delivery_status"],style: textStyle1,),
                          ],
                        ),
                      ),
                      SizedBox(height: 8,),
                      Container(
                        width: Get.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("SHIPPING ADDRESS",style: textStyle1,),
                            Container(
                              alignment: Alignment.centerRight,
                              width: Get.width/2-30,
                              child: Text(widget.data["shipping_address"].toString().toUpperCase(),style: textStyle1,
                                overflow: TextOverflow.clip,
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 8,),
                      Container(
                        width: Get.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("ORDER TOTAL",style: textStyle1,),
                            Container(
                              alignment: Alignment.centerRight,
                              width: Get.width/2-30,
                              child: Text("\$${widget.data["amount"].toString()}",style: textStyle1,
                                overflow: TextOverflow.clip,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Text("PRODUCTS",style: textStyle1,),
              SizedBox(height: 16,),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: widget.data["product"].length,
                itemBuilder: (context,index){
                  return Padding(
                    padding: const EdgeInsets.only(bottom:8.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white
                      ),
                      child: Row(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width*0.3 ,
                            height: 90,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10)
                                ),
                                image: DecorationImage(
                                  image: NetworkImage(widget.data["product"][index]["image"]),
                                  fit: BoxFit.fill,
                                )
                            ),
                          ),
                          SizedBox(width: 10,),
                          Column(crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,

                            children: [
                              SizedBox(height: 6,),
                              Container(
                                width: Get.width*0.5,
                                child: Text(widget.data["product"][index]["name"],style:textStyle6 ,overflow: TextOverflow.clip,),
                              ),
                              SizedBox(height: 6,),
                              Text("SIZE : ${size[index]}(UK)",style:textStyle6 ,overflow: TextOverflow.clip,),
                              SizedBox(height: 6,),
                              Text("QTY : ${qty[index]}",style:textStyle6 ,overflow: TextOverflow.clip,),
                              SizedBox(height: 6,),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
