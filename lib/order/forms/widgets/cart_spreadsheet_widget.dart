import 'package:editable/editable.dart';
import 'package:flutter/material.dart';

class CustomRow {
  const CustomRow(
    this.urn,
    this.dob,
    this.patientName,
    this.qty,
    this.productName,
    this.adminRoute,
    this.requiredDeliveryDate,
  );

  final String urn;
  final String dob;
  final String patientName;
  final int qty;
  final String productName;
  final String adminRoute;
  final String requiredDeliveryDate;
}

class CartSpreadsheet extends StatefulWidget {
  const CartSpreadsheet({
    Key? key,
  }) : super(key: key);

  @override
  _CartSpreadsheetState createState() => _CartSpreadsheetState();
}

class _CartSpreadsheetState extends State<CartSpreadsheet> {
  final _editableKey = GlobalKey<EditableState>();

  final String clinicPlaceholder = 'SCHOC';
  final Map<String, Object> mapmap = {
    'urn': 2342809,
    'dob': '31/01/1980',
    'patientName': 'Joan Smith',
    'qty': 2,
    'productName': 'Pembrolizumab N/S 50mL Freeflex',
    'adminRoute': 'IVENOS',
    'requiredDeliveryDate': '25/04/2021',
  };

  List<dynamic> treatmentRows = <Map<String, Object>>[
    {
      'urn': 2342809,
      'dob': '31/01/1980',
      'patientName': 'Joan Smith',
      'qty': 2,
      'productName': 'Pembrolizumab N/S 50mL Freeflex',
      'adminRoute': 'IVENOS',
      'requiredDeliveryDate': '25/04/2021',
    },
  ];

  List<dynamic> columnHeaders = <dynamic>[
    {'title': 'URN', 'widthFactor': 0.1, 'key': 'urn', 'editable': false},
    {'title': 'DOB', 'widthFactor': 0.1, 'key': 'dob'},
    {'title': 'Patient name', 'widthFactor': 0.2, 'key': 'patientName'},
    {'title': 'Qty', 'key': 'qty'},
    {'title': 'Product name', 'widthFactor': 0.2, 'key': 'productName'},
    {
      'title': 'Route',
      'key': 'adminRoute',
    },
    {
      'title': 'Required delivery date',
      'widthFactor': 0.1,
      'key': 'requiredDeliveryDate',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
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
        Editable(
          key: _editableKey,
          columns: columnHeaders,
          rows: treatmentRows,
          zebraStripe: true,
          stripeColor1: Colors.blue[50]!,
          stripeColor2: Colors.grey[200]!,
          onRowSaved: (dynamic value) {
            final Map<String, Object> test = value as Map<String, Object>;

            print(value);
          },
          onSubmitted: (value) {
            print(value);
          },
          borderColor: Colors.blueGrey,
          tdStyle: const TextStyle(fontWeight: FontWeight.bold),
          trHeight: 80,
          thStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          thAlignment: TextAlign.center,
          thVertAlignment: CrossAxisAlignment.end,
          thPaddingBottom: 3,
          showSaveIcon: true,
          saveIconColor: Colors.black,
          showCreateButton: true,
          tdAlignment: TextAlign.left,
          tdEditableMaxLines: 100, // don't limit and allow data to wrap
          tdPaddingTop: 0,
          tdPaddingBottom: 14,
          tdPaddingLeft: 10,
          // tdPaddingRight: 8,
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue),
            borderRadius: BorderRadius.all(Radius.circular(0)),
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
