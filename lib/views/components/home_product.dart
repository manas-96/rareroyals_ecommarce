import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rare_royals_in_corporated/data/models/product_model.dart';
import 'package:rare_royals_in_corporated/views/product_details.dart';


class HomeProduct extends StatefulWidget {
  final bool allProduct;
  final List<ProductModel>products;
  const HomeProduct({Key key, this.products, this.allProduct}) : super(key: key);

  @override
  _HomeProductState createState() => _HomeProductState();
}

class _HomeProductState extends State<HomeProduct> {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 3/4
      ),
      itemCount: widget.allProduct? widget.products.length:6,
      itemBuilder: (context,index){
        return InkWell(
          onTap: (){
            Get.to(ProductDetails(
              product: widget.products[index],
            ));
          },
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      blurRadius: 1,
                      color: Colors.grey
                  )
                ]
            ),
            child: Stack(

              children: [
                Positioned(
                  top: 0,
                  bottom: 50,
                  left: 0,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            topLeft: Radius.circular(10)
                        ),
                        color: Colors.white,
                        image: DecorationImage(
                            image: NetworkImage(widget.products[index].image),fit: BoxFit.cover
                        )
                    ),),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
                        ),
                        color: Colors.grey.withOpacity(0.5)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width/3,
                            child: Text(widget.products[index].name,
                                style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(height: 5,),
                          Text("\$ ${widget.products[index].price}",style: TextStyle(color: Colors.green,fontWeight: FontWeight.w500,fontSize: 14),),

                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
