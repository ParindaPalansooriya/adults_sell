
class Product {
  String? id;
  String? title;
  String? description;
  double? price;
  double? r_price;
  int? amountProduct;
  String? createAt;
  bool? isLike;
  List<String?>? urlImage;
  String? category;
  String? categoryId;
  int? currentStock;

  Product(
      {this.id,
      this.title,
      this.description,
      this.price,
      this.amountProduct,
      this.createAt,
      this.isLike,
      this.urlImage,
      this.category,
      this.r_price,
      this.currentStock,
      this.categoryId});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['productId'].toString();
    title = json['name'];
    description = json['Description']??"";
    price = double.tryParse(json['SellingPrice'].toString())??0;
    r_price = double.tryParse(json['RegularPrice'].toString())??0;
    amountProduct = json['MaxQtyPurchase'];
    createAt = json['CreatedDate'];
    isLike = false;
    urlImage = [json['ImageUrl']];
    categoryId = json['ProductCategoryId'].toString();
    currentStock = json['CurrentStock']??0;
    category = "";
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productId'] = int.tryParse(id.toString());
    data['name'] = title;
    data['description'] = description;
    data['SellingPrice'] = price;
    data['RegularPrice'] = r_price;
    data['MaxQtyPurchase'] = amountProduct;
    data['CreatedDate'] = this.createAt;
    data['isLike'] = this.isLike;
    data['ImageUrl'] = this.urlImage;
    data['ProductCategoryId'] = int.tryParse(this.categoryId.toString());
    data['CurrentStock'] = this.currentStock;
    return data;
  }
}
