import 'package:flutter/material.dart';
import 'package:testable_web_app/order/forms/order_form.dart';
import 'package:testable_web_app/shared/navigation/widgets/side_menu_nav_drawer/side_menu_nav_drawer_widget.dart';
import 'package:testable_web_app/webstore/catalogue/product/models/product_model.dart';

class OrderScreen extends StatelessWidget {
  /// We want the order screen with the data populated already
  ///
  /// Route guard login block earlier with error response handling from
  /// home page login flow + loading spinner while querying offline list.
  const OrderScreen({
    Key? key,
    required this.products,
    required this.patients,
  }) : super(key: key);

  final List<ProductModel> products;
  final List patients;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Order screen',
        ),

        // We do not use history. Push replace.
        /* 
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
         */
      ),
      drawer: const SideMenuNavigationDrawer(),
      body: OrderForm(
        products: products,
        patients: patients,
      ),
    );
  }
}
