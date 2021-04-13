import 'package:flutter/material.dart';

const edgeInsetsPadding = EdgeInsets.fromLTRB(24, 16, 24, 16);

class OrderForm extends StatefulWidget {
  const OrderForm({
    Key? key,
  }) : super(key: key);

  @override
  _OrderFormState createState() => _OrderFormState();
}

class _OrderFormState extends State<OrderForm> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: edgeInsetsPadding,
        ),
      ],
    );
  }
}
