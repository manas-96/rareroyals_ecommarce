import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rare_royals_in_corporated/data/models/category_model.dart';
import 'package:rare_royals_in_corporated/logic/category_controller.dart';
import 'package:rare_royals_in_corporated/views/category_product.dart';

import '../../helper.dart';


class CategoryWidget extends StatefulWidget {
  const CategoryWidget({Key key}) : super(key: key);

  @override
  _CategoryWidgetState createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  final CategoryController controller = Get.put(CategoryController());
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: FutureBuilder(
        future: controller.getCategory(),
        builder: (context,snap){
          if(snap.data==null){
            return Container();
          }
          final List<CategoryModel> category = snap.data;
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: category.length,
            itemBuilder: (context,index){
              return Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: InkWell(
                  onTap: (){
                    Get.to(CategoryProduct(
                      id: category[index].id,
                      name: category[index].name,
                    ));
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 70,height: 70,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            image: DecorationImage(
                                image: category[index].image==null?
                                AssetImage("images/logo.png")
                                :NetworkImage(category[index].image),fit: BoxFit.cover
                            )
                        ),
                      ),
                      SizedBox(height: 8,),
                      Container(
                        width: 100,
                        child: Text(category[index].name,style: textStyle8,overflow: TextOverflow.clip,textAlign: TextAlign.center,),
                      )
                    ],
                  )
                ),
              );
            },
          );
        },
      )
    );
  }
}
