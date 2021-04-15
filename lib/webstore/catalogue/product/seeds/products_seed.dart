import 'package:testable_web_app/webstore/catalogue/product/models/drug_model.dart';
import 'package:testable_web_app/webstore/catalogue/product/models/product_model.dart';

const List<ProductModel> seedProducts = [
  ProductModel(
    productID: 1,
    productName: 'Pralatrexate - Syringe',
    containerName: 'Syringe', // 20mL
    drugs: [
      DrugModel(
        'Pralatrexate',
        'mg',
      ),
    ],
    productAdministrationRoute: 'IVINF',
  ),
  ProductModel(
    productID: 2,
    productName: 'Pembrolizumab N/S 50mL Freeflex',
    containerName: 'N/S 50mL Freeflex', // 127mL
    drugs: [
      DrugModel(
        'Pembrolizumab',
        'mg',
      ),
    ],
    productAdministrationRoute: 'IVENOS',
  ),
  ProductModel(
    productID: 3,
    productName: 'Pembrolizumab N/S 100mL Freeflex',
    containerName: 'N/S 100mL Freeflex', // 198mL
    drugs: [
      DrugModel(
        'Pembrolizumab',
        'mg',
      ),
    ],
    productAdministrationRoute: 'IVENOS',
  ),
  ProductModel(
    productID: 4,
    productName: 'Doxorubicin / Vincristine / Etoposide (E/phos br) - '
        '24-hour Surefuser, Surefuser 250mL 1 day',
    containerName: '24-hour Surefuser, Surefuser 250mL 1 day', // 241mL
    drugs: [
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
    productAdministrationRoute: 'IVINF',
  ),
];
