class ProductModel {
  late String id;
  late String name;
  late int code;
  late String imageUrl;
  late int quantity;
  late int unitPrice;
  late int totalPrice;

  // Constructor that handles null values
  ProductModel.fromJson(Map<String, dynamic> json) {
    id = json['_id'] ?? '';  // Default empty string if null
    name = json['ProductName'] ?? '';  // Default empty string if null
    code = json['ProductCode'] ?? 0;  // Default to 0 if null
    quantity = json['Qty'] ?? 0;  // Default to 0 if null
    unitPrice = json['UnitPrice'] ?? 0;  // Default to 0 if null
    totalPrice = json['TotalPrice'] ?? 0;  // Default to 0 if null
    imageUrl = json['Img'] ?? '';  // Default empty string if null
  }
}
