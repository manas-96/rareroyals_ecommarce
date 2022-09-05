class CartModel{
  String id;
  String name;
  String image;
  String price;
  String size;
  String qty;
  CartModel(this.id,this.name, this.image, this.price,this.size, this.qty);
  CartModel.fromJson(Map<String,dynamic>json):
        id=json["id"],
        name=json["name"],
        image=json["image"],
        price=json["price"],
        size=json["size"],
        qty=json["qty"];
  Map<String,dynamic>toJson()=>{
    "id":id,
    "name":name,
    "image":image,
    "price":price,
    "size":size,
    "qty": qty
  };
}