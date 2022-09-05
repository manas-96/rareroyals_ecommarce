class ProductModel{
  final String id;
  final String itemNo;
  final String category;
  final String subcategory;
  final String brand;
  final String name;
  final String description;
  final String quantity;
  final String price;
  final String discount;
  final String attribute;
  final String country;
  final String for_man_or_woman;
  final String size;
  final String is_hot;
  final String is_trending;
  final String is_new;
  final String orders;
  final String image;
  final String created_at;
  final String updated_at;

  ProductModel(this.id, this.itemNo, this.category, this.subcategory, this.brand, this.name, this.description, this.quantity, this.price, this.discount, this.attribute, this.country, this.for_man_or_woman, this.size, this.is_hot, this.is_trending, this.is_new, this.orders, this.image, this.created_at, this.updated_at);

  ProductModel.fromJson(Map<String,dynamic>json):
        id=json["id"],
        itemNo=json["item_no"],
        name=json["name"],
        category=json["category"],
        image=json["image"],
        subcategory=json["subcategory"],
        brand=json["brand"],
        description=json["description"],
        quantity=json["quantity"],
        price=json["price"],
        discount=json["discount"],
        attribute=json["attribute"],
        country=json["country"],
        for_man_or_woman=json["for_man_or_woman"],
        size=json["size"],
        is_hot=json["is_hot"],
        is_trending=json["is_trending"],
        is_new=json["is_new"],
        orders=json["orders"],
        created_at=json["created_at"],
        updated_at=json["updated_at"];
  Map<String,dynamic>toJson()=>{
    "id":id,
    "item_no":itemNo,
    "name":name,
    "category":category,
    "image":image,
    "subcategory":subcategory,
    "brand":brand,
    "description":description,
    "quantity":quantity,
    "price":price,
    "discount":discount,
    "attribute":attribute,
    "country":country,
    "for_man_or_woman":for_man_or_woman,
    "size":size,
    "is_hot":is_hot,
    "is_trending":is_trending,
    "is_new":is_new,
    "orders":orders,
    "created_at":created_at,
    "updated_at":updated_at,
  };
}