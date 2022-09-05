import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rare_royals_in_corporated/logic/auth_controller.dart';
import 'package:rare_royals_in_corporated/logic/wishlist_controller.dart';

import '../helper.dart';
import 'components/app_bar_widget.dart';
import 'components/buttons.dart';
import 'components/loader.dart';
import 'components/login_widget.dart';
import 'components/product_not_found.dart';
import 'log_in.dart';


class WishList extends StatefulWidget {
  const WishList({Key key}) : super(key: key);

  @override
  _WishListState createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  AuthController authController = Get.put(AuthController());
  WishlistController wishlistController = Get.put(WishlistController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color1,
      appBar: appBarWidget(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            children: [
              FutureBuilder(
                future: authController.checkLogin(),
                builder: (context,snapshot){
                  if(snapshot.data==null){
                    return loader();
                  }
                  if(!snapshot.data){
                    return Container(
                      height: MediaQuery.of(context).size.height*0.8,
                      child: Center(
                        child: LoginWidget(),
                      )
                    );
                  }
                  return FutureBuilder(
                    future: wishlistController.getWishlist(),
                    builder: (context,snap){
                      if(snap.data=="empty"){
                        return Container(
                          height: MediaQuery.of(context).size.height*0.8,
                          alignment: Alignment.center,
                          child: productNotFound(),
                        );
                      }
                      if(snap.data==null){
                        return loader();
                      }
                      return ListView.builder(
                        itemCount: wishlistController.wishlist.length,
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
                                      height: 70,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          image: DecorationImage(
                                              image: NetworkImage(wishlistController.wishlist[index].image),
                                              fit: BoxFit.cover
                                          )
                                      ),
                                    ),
                                    SizedBox(width: 10,),
                                    Column(crossAxisAlignment: CrossAxisAlignment.start,

                                      children: [
                                        Container(
                                          width: MediaQuery.of(context).size.width*0.5,
                                          child: Text(wishlistController.wishlist[index].name,style: textStyle6,overflow: TextOverflow.clip,),
                                        ),
                                        SizedBox(height: 6,),
                                        Text("\$ ${wishlistController.wishlist[index].price}",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.green),),
                                        SizedBox(height: 6,),
                                        Container(
                                          width: MediaQuery.of(context).size.width/2-20,
                                          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              GestureDetector(
                                                onTap:(){

                                                },
                                                child: Text("Remove"
                                                  ,style: redText,),
                                              ),

                                              GestureDetector(
                                                onTap:(){

                                                },
                                                child: Text("Move to Cart"
                                                  ,style: textStyle1,),
                                              ),
                                            ],
                                          ),
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
                    },
                  );
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}
