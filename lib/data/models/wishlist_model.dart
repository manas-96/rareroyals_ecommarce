class WishlistModel{
  String id;
  String name;
  String image;
  String price;
  WishlistModel(this.id,this.name, this.image, this.price);
  WishlistModel.fromJson(Map<String,dynamic>json):
        id=json["id"],
        name=json["name"],
        image=json["image"],
        price=json["price"];
  Map<String,dynamic>toJson()=>{
    "id":id,
    "name":name,
    "image":image,
    "price":price
  };
}