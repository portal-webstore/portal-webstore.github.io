import 'package:editable/editable.dart';
import 'package:flutter/material.dart';

class CartSpreadsheet extends StatefulWidget {
  const CartSpreadsheet({
    Key? key,
  }) : super(key: key);

  @override
  _CartSpreadsheetState createState() => _CartSpreadsheetState();
}

class _CartSpreadsheetState extends State<CartSpreadsheet> {
  final _editableKey = GlobalKey<EditableState>();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        TextButton.icon(
          onPressed: () => _addNewRow(),
          icon: const Icon(Icons.add),
          label: const Text(
            'Add',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          width: 16,
        ),
        TextButton(
          onPressed: () => _printEditedRows(),
          child: const Text(
            'Print edited rows',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  /// Function to add a new row
  /// Using the global key assigined to Editable widget
  /// Access the current state of Editable
  void _addNewRow() {
    setState(() {
      _editableKey.currentState?.createRow();
    });
  }

  ///Print only edited rows.
  void _printEditedRows() {
    final List<dynamic>? editedRows = _editableKey.currentState?.editedRows;

    if (editedRows == null) {
      return;
    }
    print(editedRows);
  }
}
