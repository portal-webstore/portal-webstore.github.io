import 'package:flutter/material.dart';
import 'package:testable_web_app/order/forms/widgets/dose_field_widget.dart';
import 'package:testable_web_app/webstore/catalogue/product/models/drug_model.dart';
import 'package:testable_web_app/webstore/catalogue/product/models/product_model.dart';

class DrugDoseFields extends StatelessWidget {
  const DrugDoseFields({
    Key? key,
    required this.drugs,
    required this.onSubmitDrugDoseField,
    required this.onSaveDrugDoseField,
    required this.baseFocusNodes,
    required this.onFinishedLastDoseFieldSubmitted,
  }) : super(key: key);

  final List<DrugModel> drugs;

  /// On submit; trigger saving or other behaviour.
  ///
  /// To allow stateful parent to progressively build up ux feedback or respond
  /// to partial dose inputs in a multi-dose (2-or 3-drug product order)
  ///
  final Function(int index, double dose) onSubmitDrugDoseField;

  /// On save, trigger parent callback to save out into array of drug doses
  final Function(int index, double dose) onSaveDrugDoseField;

  /// Use to naively trigger the next focus event in parent
  /// when the user is done with all the multi dose fields
  ///
  final VoidCallback? onFinishedLastDoseFieldSubmitted;

  /// Length should be at least the number of fields (each drug) or greater
  ///
  /// Accessed by index.
  final List<FocusNode> baseFocusNodes;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        drugs.length,
        (int index) {
          final DrugModel drug = drugs[index];

          return DoseField(
            drug: drug,
            onFieldSubmitted: (String? doseText) {
              // If we want to notify partial progress for UX feedback
              // and widget rebuild
              if (doseText == null) {
                return;
              }

              // Marry up the dose to the drug (should be ordered) with index

              // Trailing dot is still valid syntax.
              final double? dose = double.tryParse(doseText);
              if (dose == null) {
                return;
              }

              // Check formKey.currentState.save() context works in this nested widget
              onSaveDrugDoseField(index, dose);

              // Successful save and focus next field
              _focusNextField(index);
            },
            onSaved: (String? doseText) {
              if (doseText == null) {
                return;
              }

              // Marry up the dose to the drug (should be ordered) with index

              final double? dose = double.tryParse(doseText);
              if (dose == null) {
                return;
              }

              // Check formKey.currentState.save() context works in this nested widget
              onSaveDrugDoseField(index, dose);
            },
          );
        },
      ),
    );
  }

  /// Trigger this after a *successful* dose is entered (enter key)
  ///
  /// Focuses our next internal field otherwise triggers the parent callback
  /// (which could be used to focus the next field in the parent widgets)
  ///
  /// Otherwise user can still use tab key instead of enter key.
  ///
  void _focusNextField(int currentDrugDoseFieldIndex) {
    final int lastDrugFocusIndex = drugs.length - 1;

    final bool isLastFinalDoseField =
        currentDrugDoseFieldIndex >= lastDrugFocusIndex;

    if (isLastFinalDoseField) {
      // This is the final field in the input fields presented.
      //
      // Trigger the parent callback (which would be used to focus outside)
      onFinishedLastDoseFieldSubmitted?.call();
    }

    baseFocusNodes[0].requestFocus();
  }
}

int getNumberOfDrugDoseFieldsFromProduct(ProductModel? product) {
  if (product == null) {
    return 0;
  }

  return product.drugs.length;
}
