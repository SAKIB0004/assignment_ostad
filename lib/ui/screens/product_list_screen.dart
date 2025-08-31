import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../models/product.dart';
import '../utils/urls.dart';
import '../widgets/ProductItem.dart';
import 'add_new_product.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});
  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {

  final List<ProductModel> _productsList = [];
  bool _getProductInProgress = false;



  @override
  void initState() {
    super.initState();
    _getProductList();
  }


  Future<void> _getProductList() async{
    _productsList.clear();
    _getProductInProgress = true;
    setState(() {});
    Uri uri = Uri.parse(Urls.getProductUrl);
    Response response = await get(uri);

    debugPrint(response.statusCode.toString());
    debugPrint(response.body);

    if(response.statusCode == 200){
      final decodedJson = jsonDecode(response.body);
      for( Map<String, dynamic> productJson in decodedJson['data'] ){
        ProductModel productModel = ProductModel.fromJson(productJson);
        _productsList.add(productModel);
      }
      _getProductInProgress = false;
      setState(() {});
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Product List",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.redAccent.shade400,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              _getProductList();
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),

      body: Visibility(
        visible: _getProductInProgress == false,
        replacement: const Center(child: CircularProgressIndicator()),
        child: ListView.builder(
          itemCount: _productsList.length,
          itemBuilder: (context, index) {
            return ProductItem(
              product: _productsList[index],
              refreshProductList: () {
                _getProductList();
              },
            );
          },
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, AddNewProduct.routeName);
        },
        backgroundColor: Colors.redAccent.shade400,
        child: Icon(Icons.add, color: Colors.white, size: 30),
      ),
    );
  }
}
