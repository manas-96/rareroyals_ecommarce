import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rare_royals_in_corporated/logic/cart_controller.dart';

import '../../helper.dart';
import 'loader.dart';
import 'product_not_found.dart';



class FakeCart extends StatefulWidget {
  const FakeCart({Key key}) : super(key: key);

  @override
  _FakeCartState createState() => _FakeCartState();
}

class _FakeCartState extends State<FakeCart> {
  CartController cartController = Get.put(CartController());
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: cartController.getFakeCart(),
      builder: (context,snap){
        if(snap.data=="empty"){
          return productNotFound();
        }
        if(cartController.fakeCartList.isEmpty){
          return productNotFound();
        }
        if(snap.data==null){
          return loader();
        }
        return getCartItems();
      },
    );
  }
  getCartItems(){
    return Column(
      children: [
       Obx(()=> ListView.builder(
         itemCount: cartController.fakeCartList.length,
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
                               image: NetworkImage(cartController.fakeCartList[index].image),
                               fit: BoxFit.cover
                           )
                       ),
                     ),
                     SizedBox(width: 10,),
                     Column(crossAxisAlignment: CrossAxisAlignment.start,

                       children: [
                         Container(
                           width: MediaQuery.of(context).size.width*0.5,
                           child: Text(cartController.fakeCartList[index].name,style: textStyle6,overflow: TextOverflow.clip,),
                         ),
                         SizedBox(height: 6,),
                         Text("\$ ${
                             cartController.fakeCartList[index].price
                         // getPrice(double.parse(cartController.fakeCartList[index].price),double.parse(cartController.fakeCartList[index].qty))
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
                                       cartController.fakeCartList[index].id,
                                       cartController.fakeCartList[index].size,
                                       (double.parse(cartController.fakeCartList[index].qty).toInt()+1).toString(),
                                       cartController.fakeCartList[index].price
                                   );
                                 },
                                 child: CircleAvatar(radius: 15,
                                   backgroundColor: color3,
                                   child: Icon(Icons.add,color: Colors.white,),
                                 ),
                               ),
                               SizedBox(width: 10,),
                               Text(cartController.fakeCartList[index].qty,style: TextStyle(color: Colors.green,fontWeight: FontWeight.w500),),
                               SizedBox(width: 10,),
                               GestureDetector(
                                 onTap:(){
                                   if(double.parse(cartController.fakeCartList[index].qty).toInt()>1){
                                     cartController.updateCart(
                                         cartController.fakeCartList[index].id,
                                         cartController.fakeCartList[index].size,
                                         (double.parse(cartController.fakeCartList[index].qty).toInt()-1).toString(),
                                         cartController.fakeCartList[index].price
                                     );

                                   }
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
                                 cartController.deleteFakeCart(index);
                               },
                               child: Text("Remove",
                                 style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red),
                               ),
                             ),
                             SizedBox(width: 20,),
                             Text("Size : ${cartController.fakeCartList[index].size}(US)",style: textStyle6,)
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
       ))

      ],
    );
  }
}
