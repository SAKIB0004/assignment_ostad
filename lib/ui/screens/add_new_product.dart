import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../widgets/snackbar_message.dart';

class AddNewProduct extends StatefulWidget {
  const AddNewProduct({super.key});

  static const String routeName = '/add-new-product';

  @override
  State<AddNewProduct> createState() => _AddNewProductState();
}

class _AddNewProductState extends State<AddNewProduct> {
  bool _addProductInProgress = false;

  final TextEditingController _nameTEC = TextEditingController();
  final TextEditingController _priceTEC = TextEditingController();
  final TextEditingController _totalPriceTEC = TextEditingController();
  final TextEditingController _quantityTEC = TextEditingController();
  final TextEditingController _imageTEC = TextEditingController();
  final TextEditingController _codeTEC = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add New Product')),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _buildProductForm(),
      ),
    );
  }

  Widget _buildProductForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _nameTEC,
            decoration: InputDecoration(
              labelText: 'Product Name',
              border: OutlineInputBorder(),
              hintText: 'Enter Product Name',
            ),
            validator: (String? value) {
              if (value?.trim().isEmpty ?? true) {
                return 'Please enter product name';
              }
              return null;
            },
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: _codeTEC,
            decoration: InputDecoration(
              labelText: 'Product Code',
              border: OutlineInputBorder(),
              hintText: 'Enter Product code',
            ),
            validator: (String? value) {
              if (value?.trim().isEmpty ?? true) {
                return 'Please enter product Code';
              }
              return null;
            },
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: _priceTEC,
            decoration: InputDecoration(
              labelText: 'Product Price',
              border: OutlineInputBorder(),
              hintText: 'Enter Product Price',
            ),
            validator: (String? value) {
              if (value?.trim().isEmpty ?? true) {
                return 'Please enter product Price';
              }
              return null;
            },
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: _quantityTEC,
            decoration: InputDecoration(
              labelText: 'Product Quantity',
              border: OutlineInputBorder(),
              hintText: 'Enter Product Quantity',
            ),
            validator: (String? value) {
              if (value?.trim().isEmpty ?? true) {
                return 'Please enter product Quantity';
              }
              return null;
            },
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: _totalPriceTEC,
            decoration: InputDecoration(
              labelText: 'Product Total Price',
              border: OutlineInputBorder(),
              hintText: 'Enter Product Total Price',
            ),
            validator: (String? value) {
              if (value?.trim().isEmpty ?? true) {
                return 'Please enter product Total Price';
              }
              return null;
            },
          ),
          SizedBox(height: 16),
          TextFormField(
            controller: _imageTEC,
            decoration: InputDecoration(
              labelText: 'Product Image URL',
              border: OutlineInputBorder(),
              hintText: 'Enter Product Image URL',
            ),
            validator: (String? value) {
              if (value?.trim().isEmpty ?? true) {
                return 'Please enter product image URL';
              }
              return null;
            },
          ),
          SizedBox(height: 16),

          //ElevatedButton(onPressed: () {}, child: Text("Add Product")),
          Visibility(
            visible: _addProductInProgress == false,
            replacement: Center(child: CircularProgressIndicator()),
            child: FilledButton(
              onPressed: _addProduct,
              child: Text("Add Product"),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _addProduct() async {
    if(_formKey.currentState?.validate() != true) {
      return;
    }

    setState(() {
      _addProductInProgress = true;
    });
    //Prepare URI to req
    Uri uri = Uri.parse("http://35.73.30.144:2008/api/v1/CreateProduct");

    //prepare data
    int totalPrice = int.parse(_priceTEC.text) * int.parse(_quantityTEC.text);
    Map<String, dynamic> requestBody = {
      "ProductName": _nameTEC.text.trim(),
      "ProductCode": _codeTEC.text.trim(),
      "Img": _imageTEC.text.trim(),
      "Qty": int.parse(_quantityTEC.text.trim()),
      "UnitPrice": int.parse(_priceTEC.text.trim()),
      "TotalPrice": totalPrice,
    };
    //request with data
    Response response = await post(
      uri,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(requestBody),
    );
    print("Response status: ${response.statusCode}");
    print("Response body: ${response.body}");

    final decodedJson = jsonDecode(response.body);
    if (response.statusCode == 200) {
      final decodedJson = jsonDecode(response.body);
      if (decodedJson['status'] == 'success') {
        _clearForm();
        showSnackBarMessage(context, "Product added successfully");
      } else {
        String errorMessage = decodedJson['data'];
        showSnackBarMessage(context, errorMessage);
      }
    }

    setState(() {
      _addProductInProgress = false;
    });
  }

  void _clearForm() {
    _nameTEC.clear();
    _priceTEC.clear();
    _totalPriceTEC.clear();
    _quantityTEC.clear();
    _imageTEC.clear();
    _codeTEC.clear();
  }

  @override
  void dispose() {
    _nameTEC.dispose();
    _priceTEC.dispose();
    _totalPriceTEC.dispose();
    _quantityTEC.dispose();
    _imageTEC.dispose();
    _codeTEC.dispose();
    super.dispose();
  }
}
