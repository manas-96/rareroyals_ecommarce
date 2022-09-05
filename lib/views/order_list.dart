import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rare_royals_in_corporated/logic/order_controller.dart';
import 'package:rare_royals_in_corporated/views/components/app_bar_widget.dart';
import 'package:rare_royals_in_corporated/views/components/loader.dart';
import 'package:rare_royals_in_corporated/views/components/product_not_found.dart';
import 'package:rare_royals_in_corporated/views/order_details.dart';

import '../helper.dart';


class OrderList extends StatefulWidget {
  const OrderList({Key key}) : super(key: key);

  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  OrderController orderController = Get.put(OrderController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color1,
      appBar: appBarWidget(
        leading: true,
        title: Text("Orders",style: textStyle1,)
      ),
      body: FutureBuilder(
        future: orderController.getOrder(),
        builder: (context,snap){
          if(snap.data==null){
            return loader();
          }
          if(snap.data=="failed" || snap.data.length==0){
            return productNotFound();
          }
          return orderList(snap.data);
        },
      )
    );
  }
  orderList(data){
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context,index){
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: InkWell(
            onTap: (){
              if(data[index]["product"][0]!=null){
                Get.to(OrderDetails(data: data[index],));
              }
            },
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
                          image: data[index]["product"][0]==null?AssetImage("images/logo.png"):
                          NetworkImage(data[index]["product"][0]["image"]),
                          fit: BoxFit.fill,
                        )
                    ),
                  ),
                  SizedBox(width: 10,),
                  Column(crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      SizedBox(height: 6,),
                      Row(
                        children: [
                          Text("Order id : ",style:textStyle6 ,),
                          Text(data[index]["order_id"],style: TextStyle(fontWeight: FontWeight.bold,color: Colors.green,fontSize: 15),)
                        ],
                      ),
                      SizedBox(height: 6,),
                      Row(
                        children: [
                          Text("Order date : ",style:textStyle6 ,),
                          Text(data[index]["order_date"].toString().split(" ").first,
                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),)
                        ],
                      ),
                      SizedBox(height: 6,),
                      Row(
                        children: [
                          Text("Order total : ",style:textStyle6 ,),
                          SizedBox(width: 5,),
                          Text(data[index]["amount"].toString(),style: TextStyle(fontWeight: FontWeight.bold,color: Colors.green,fontSize: 15),)
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
