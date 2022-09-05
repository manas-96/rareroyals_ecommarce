class CategoryModel{
  final String id;
  final String parent;
  final String name;
  final String status;
  final String image;
  final String date;

  CategoryModel(this.id, this.parent, this.name, this.status, this.image, this.date,);

  CategoryModel.fromJson(Map<String,dynamic>json):
        id=json["id"],
        parent=json["parent"],
        name=json["name"],
        status=json["status"],
        image=json["image"],
        date=json["date"];
  Map<String,dynamic>toJson()=>{
    "id":id,
    "parent":parent,
    "name":name,
    "status":status,
    "image":image,
    "date":date,
  };
}