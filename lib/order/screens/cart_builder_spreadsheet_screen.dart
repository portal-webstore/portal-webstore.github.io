import 'package:flutter/material.dart';
import 'package:testable_web_app/order/forms/widgets/cart_spreadsheet_widget.dart';
import 'package:testable_web_app/shared/navigation/widgets/side_menu_nav_drawer/side_menu_nav_drawer_widget.dart';

class CartBuilderSpreadsheetScreen extends StatelessWidget {
  /// We want the order screen with the data populated already
  ///
  /// Route guard login block earlier with error response handling from
  /// home page login flow + loading spinner while querying offline list.
  const CartBuilderSpreadsheetScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Spreadsheet prototype screen',
        ),
      ),
      drawer: const SideMenuNavigationDrawer(),
      body: const CartSpreadsheet(),
    );
  }
}
