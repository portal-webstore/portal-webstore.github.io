import 'package:flutter/material.dart';
import 'package:testable_web_app/shared/layout/default_layout_constant.dart';

class ProductListTile extends StatelessWidget {
  const ProductListTile({
    Key? key,
    required this.name,
    required this.onTap,
  }) : super(key: key);

  final String name;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
              left: DefaultLayout.indent,
            ),
            child: Text(
              name,
            ),
          )
        ],
      ),
      onTap: onTap,
    );
  }
}
