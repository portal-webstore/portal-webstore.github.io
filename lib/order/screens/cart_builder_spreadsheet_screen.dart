import 'package:editable/editable.dart';
import 'package:flutter/material.dart';
import 'package:testable_web_app/shared/navigation/widgets/side_menu_nav_drawer/side_menu_nav_drawer_widget.dart';

class CustomRow {
  const CustomRow(
    this.urn,
    this.dob,
    this.patientName,
    this.qty,
    this.productName,
    this.adminRoute,
    // Doses
    // Drugs multiple rows required..
    // Table should be used for data rather than display logic!
    this.dose,
    this.requiredDeliveryDate,
  );

  final String urn;
  final String dob;
  final String patientName;
  final int qty;
  final String productName;
  final String adminRoute;
  final double dose;
  final String requiredDeliveryDate;
}

class CartBuilderSpreadsheetScreen extends StatefulWidget {
  /// We want the order screen with the data populated already
  ///
  /// Route guard login block earlier with error response handling from
  /// home page login flow + loading spinner while querying offline list.
  const CartBuilderSpreadsheetScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CartBuilderSpreadsheetScreenState();
}

class _CartBuilderSpreadsheetScreenState
    extends State<CartBuilderSpreadsheetScreen> {
  final _editableKey = GlobalKey<EditableState>();

  final String clinicPlaceholder = 'SCHOC';
  final Map<String, Object> mapmap = {
    'urn': 2342809,
    'dob': '31/01/1980',
    'patientName': 'Joan Smith',
    'qty': 1,
    'productName': 'Pembrolizumab N/S 100mL Freeflex',
    'adminRoute': 'IVENOS',
    'dose': 400,
    'requiredDeliveryDate': '25/04/2021',
  };

  List<dynamic> treatmentRows = <Map<String, Object>>[
    {
      'urn': 2342809,
      'dob': '31/01/1980',
      'patientName': 'Joan Smith',
      'qty': 1,
      'productName': 'Pembrolizumab N/S 100mL Freeflex',
      'adminRoute': 'IVENOS',
      'dose': 400,
      'requiredDeliveryDate': '25/04/2021',
    },
    {
      'urn': 2342809,
      'dob': '31/01/1980',
      'patientName': 'Joan Smith',
      'qty': 1,
      'productName': 'Pembrolizumab N/S 50mL Freeflex',
      'adminRoute': 'IVENOS',
      'dose'
          'requiredDeliveryDate': '25/04/2021',
    },
  ];

  List<dynamic> columnHeaders = <dynamic>[
    {
      'title': 'URN',
      'widthFactor': 0.05,
      'key': 'urn',
      'editable': false,
    },
    {
      'title': 'DOB',
      'widthFactor': 0.15,
      'key': 'dob',
      'editable': false,
    },
    {
      'title': 'Patient name',
      'widthFactor': 0.2,
      'key': 'patientName',
      'editable': false
    },
    {
      'title': 'Qty',
      'widthFactor': 0.05,
      'key': 'qty',
      'editable': false,
    },
    {
      'title': 'Product name',
      'widthFactor': 0.3,
      'key': 'productName',
    },
    {
      'title': 'Route',
      'widthFactor': 0.1,
      'key': 'adminRoute',
      'editable': false
    },
    {
      'title': 'dose',
      'widthFactor': 0.1,
      'key': 'adminRoute',
      'editable': false
    },
    {
      'title': 'Required delivery date',
      'widthFactor': 0.1,
      'key': 'requiredDeliveryDate',
      'editable': true
    },
  ];

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Spreadsheet prototype screen',
        ),
        leadingWidth: 200,
        leading: TextButton.icon(
          onPressed: () => _addNewRow(),
          icon: const Icon(Icons.add),
          label: const Text(
            'Add',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              onPressed: () => _printEditedRows(),
              child: const Text(
                'Print Edited Rows',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
      drawer: const SideMenuNavigationDrawer(),
      body: Editable(
        key: _editableKey,
        columns: columnHeaders,
        rows: treatmentRows,
        zebraStripe: true,
        stripeColor1: Colors.blue[50]!,
        stripeColor2: Colors.grey[200]!,
        onRowSaved: (dynamic value) {
          final Map<String, Object> test = value as Map<String, Object>;

          debugPrint(test.toString());
        },
        onSubmitted: (value) {
          debugPrint(value);
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
    );
  }
}
