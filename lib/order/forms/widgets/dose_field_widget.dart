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
    required this.onFieldSubmitted,
    required this.onSaved,
  }) : super(key: key);

  final DrugModel drug;

  final void Function(String?) onFieldSubmitted;
  final void Function(String?) onSaved;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        border: const UnderlineInputBorder(),
        labelText: _getDrugDoseLabel,
        helperText: '',
      ),
      inputFormatters: [
        allowDecimalTwoPlacesInput,
      ],
      validator: doseInputValidator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      onFieldSubmitted: onFieldSubmitted,
      onSaved: onSaved,
    );
  }

  String get _getDrugDoseLabel => '${drug.drugName} dose (${drug.drugUnits})';
}
