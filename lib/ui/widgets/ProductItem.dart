import 'package:flutter/material.dart';
import 'package:http/http.dart';
import '../models/product.dart';
import '../screens/update_product_screen.dart';
import '../utils/urls.dart';


class ProductItem extends StatefulWidget {
  const ProductItem({
    super.key,
    required this.product,
    required this.refreshProductList,
  });

  final ProductModel product;
  final VoidCallback refreshProductList;

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  bool _deleteInProgress = false;


  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          child: Image.network(
            widget.product.imageUrl,
            errorBuilder: (_, __, ___) => Icon(Icons.error_outline),
          ),
        ),
        title: Text(widget.product.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Product CODE: ${widget.product.code}"),
            Text("Quantity: ${widget.product.quantity}"),
            Text("Price: \$${widget.product.unitPrice}"),
            Text("Total Price \$${widget.product.totalPrice}"),
          ],
        ),
        trailing: Visibility(
          visible: _deleteInProgress == false,
          replacement: CircularProgressIndicator(),
          child: PopupMenuButton<ProductOptions>(
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  value: ProductOptions.update,
                  child: Text("Update"),
                ),
                PopupMenuItem(
                  value: ProductOptions.delete,
                  child: Text("Delete"),
                ),
              ];
            },
            onSelected: (ProductOptions selectedOption) {
              if (selectedOption == ProductOptions.update) {
                Navigator.pushNamed(
                  context,
                  UpdateProductScreen.routeName, arguments: widget.product
                );
              } else if (selectedOption == ProductOptions.delete) {
                _deleteProduct();
              }
            },
          ),
        ),

        /*trailing: Wrap(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, UpdateProductScreen.routeName);
                },
                icon: const Icon(Icons.edit, color: Colors.blue),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.delete, color: Colors.red),
              ),
            ],
          )*/
      ),
    );
  }

  Future<void> _deleteProduct() async {
    _deleteInProgress = true;
    setState(() {});
    Uri uri = Uri.parse(Urls.deleteProductUrl(widget.product.id));
    Response response = await get(uri);

    debugPrint(response.statusCode.toString());
    debugPrint(response.body);

    if (response.statusCode == 200) {
      widget.refreshProductList();
    }
    _deleteInProgress = false;
    setState(() {});
  }
}

enum ProductOptions { update, delete }
