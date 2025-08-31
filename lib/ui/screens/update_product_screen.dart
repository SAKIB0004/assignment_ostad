import 'dart:convert';

import 'package:http/http.dart';

import '../models/product.dart';
import 'package:flutter/material.dart';
import '../utils/urls.dart';
import '../widgets/snackbar_message.dart';

class UpdateProductScreen extends StatefulWidget {
  const UpdateProductScreen({super.key, required this.product});

  static const String routeName = '/update-product';

  final ProductModel product;

  @override
  State<UpdateProductScreen> createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateProductScreen> {
  late bool _updateProductInProgress = false;

  final TextEditingController _nameTEC = TextEditingController();
  final TextEditingController _priceTEC = TextEditingController();
  final TextEditingController _totalPriceTEC = TextEditingController();
  final TextEditingController _quantityTEC = TextEditingController();
  final TextEditingController _imageTEC = TextEditingController();
  final TextEditingController _codeTEC = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _nameTEC.text = widget.product.name ?? '';
    _codeTEC.text = widget.product.code.toString();
    _priceTEC.text = widget.product.unitPrice.toString();
    _totalPriceTEC.text = widget.product.totalPrice.toString();
    _quantityTEC.text = widget.product.quantity.toString();
    _imageTEC.text = widget.product.imageUrl ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Update Product')),

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

          Visibility(
            visible: _updateProductInProgress == false,
            replacement: CircularProgressIndicator(),
            child: FilledButton(
              onPressed: _updateProduct,
              child: Text('Update Product'),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _updateProduct() async {
    if(_formKey.currentState?.validate() != true) {
      return;
    }
    setState(() {
      _updateProductInProgress = true;
    });

    Uri uri = Uri.parse(Urls.updateProductUrl(widget.product.id));

    // Prepare data
    int totalPrice = int.parse(_priceTEC.text) * int.parse(_quantityTEC.text);
    Map<String, dynamic> requestBody = {
      "ProductName": _nameTEC.text.trim(),
      "ProductCode": _codeTEC.text.trim(),
      "Img": _imageTEC.text.trim(),
      "Qty": int.parse(_quantityTEC.text.trim()),
      "UnitPrice": int.parse(_priceTEC.text.trim()),
      "TotalPrice": totalPrice,
    };

    // Send request with data
    Response response = await post(
      uri,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(requestBody),
    );

    print("Response status: ${response.statusCode}");
    print("Response body: ${response.body}");

    if (response.statusCode == 200) {
      showSnackBarMessage(context, "Product Updated successfully");
    } else {
      showSnackBarMessage(context, "Try Again!");
    }

    setState(() {
      _updateProductInProgress = false;
    });
  }

  @override
  void dispose() {
    _nameTEC.dispose();
    _codeTEC.dispose();
    _priceTEC.dispose();
    _totalPriceTEC.dispose();
    _quantityTEC.dispose();
    _imageTEC.dispose();
    super.dispose();
  }
}
