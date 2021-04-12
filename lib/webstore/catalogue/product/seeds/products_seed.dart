import 'package:testable_web_app/webstore/catalogue/product/models/drug_model.dart';
import 'package:testable_web_app/webstore/catalogue/product/models/product_model.dart';

const List<ProductModel> seedProducts = [
  ProductModel(
    1,
    'Pralatrexate - Syringe',
    'Syringe', // 20mL
    [
      DrugModel(
        'Pralatrexate',
        'mg',
      ),
    ],
  ),
  ProductModel(
    2,
    'Pembrolizumab N/S 50mL Freeflex',
    'N/S 50mL Freeflex', // 127mL
    [
      DrugModel(
        'Pembrolizumab',
        'mg',
      ),
    ],
  ),
  ProductModel(
    3,
    'Pembrolizumab N/S 100mL Freeflex',
    'N/S 100mL Freeflex', // 198mL
    [
      DrugModel(
        'Pembrolizumab',
        'mg',
      ),
    ],
  ),
  ProductModel(
    4,
    'Doxorubicin / Vincristine / Etoposide (E/phos br) - '
        '24-hour Surefuser, Surefuser 250mL 1 day',
    '24-hour Surefuser, Surefuser 250mL 1 day', // 241mL
    [
      DrugModel(
        'Doxorubicin',
        'mg',
      ),
      DrugModel(
        'Vincristine',
        'mg',
      ),
      DrugModel(
        'Etoposide (E/phos br)',
        'mg',
      ),
    ],
  ),
];
