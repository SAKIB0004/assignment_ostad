import 'package:assignment_ostad/ui/models/product.dart';
import 'package:assignment_ostad/ui/screens/add_new_product.dart';
import 'package:assignment_ostad/ui/screens/product_list_screen.dart';
import 'package:assignment_ostad/ui/screens/update_product_screen.dart';
import 'package:flutter/material.dart';


class CRUDApp extends StatelessWidget {
  const CRUDApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        late Widget widget;
        if (settings.name == '/') {
          widget = const ProductListScreen();
        } else if (settings.name == AddNewProduct.routeName) {
          widget = const AddNewProduct();
        } else if (settings.name == UpdateProductScreen.routeName) {
          if (settings.arguments is ProductModel) {
            final ProductModel product = settings.arguments as ProductModel;
            widget = UpdateProductScreen(product: product);
          } else {
            // Handle error or missing argument
            widget = const ProductListScreen();
          }
        }
        return MaterialPageRoute(builder: (context) => widget);
      },
    );
  }
}
