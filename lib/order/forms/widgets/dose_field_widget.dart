import 'package:flutter/material.dart';
import 'package:testable_web_app/order/forms/helpers/allow_decimal_input_formatter.dart'
    show allowDecimalTwoPlacesInput;
import 'package:testable_web_app/order/forms/helpers/dose_input_validator.dart'
    show doseInputValidator;
import 'package:testable_web_app/webstore/catalogue/product/models/drug_model.dart'
    show DrugModel;

class DoseField extends StatelessWidget {
  const DoseField({
    Key? key,
    required this.drug,
  }) : super(key: key);

  final DrugModel drug;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        border: const UnderlineInputBorder(),
        labelText: '${drug.drugName} dose (${drug.drugUnits})',
        helperText: '',
      ),
      inputFormatters: [
        allowDecimalTwoPlacesInput,
      ],
      validator: doseInputValidator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );
  }
}
