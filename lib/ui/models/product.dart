class ProductModel {
  late String id;
  late String name;
  late int code;
  late String imageUrl;
  late int quantity;
  late int unitPrice;
  late int totalPrice;


  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'] ?? '';
    name = json['ProductName'] ?? '';
    code = json['ProductCode'] ?? 0;
    quantity = json['Qty'] ?? 0;
    unitPrice = json['UnitPrice'] ?? 0;
    totalPrice = json['TotalPrice'] ?? 0;
    imageUrl = json['Img'] ?? '';
  }
}
