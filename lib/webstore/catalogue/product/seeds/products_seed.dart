import 'package:testable_web_app/webstore/catalogue/product/models/drug_model.dart';
import 'package:testable_web_app/webstore/catalogue/product/models/product_model.dart';

const List<ProductModel> seedProducts = [
  ProductModel(
    productID: '16ec5ac0-f31c-45d1-8011-c65868d744f1',
    productName: 'Pralatrexate - Syringe',
    containerName: 'Syringe', // 20mL
    drugs: [
      DrugModel(
        drugID: '18e11c42-26d4-41a8-83cd-ef7e770d0f5f',
        drugName: 'Pralatrexate',
        drugUnits: 'mg',
        ocsDrugID: 1,
      ),
    ],
    productAdministrationRoute: 'IVINF',
    ocsProductID: 1,
  ),
  ProductModel(
    productID: '26ec5ac0-f31c-45d1-8011-c65868d744f1',
    productName: 'Pembrolizumab N/S 50mL Freeflex',
    containerName: 'N/S 50mL Freeflex', // 127mL
    drugs: [
      DrugModel(
        drugID: '28e11c42-26d4-41a8-83cd-ef7e770d0f5f',
        drugName: 'Pembrolizumab',
        drugUnits: 'mg',
        ocsDrugID: 2,
      ),
    ],
    productAdministrationRoute: 'IVENOS',
    ocsProductID: 2,
  ),
  ProductModel(
    productID: '36ec5ac0-f31c-45d1-8011-c65868d744f1',
    productName: 'Pembrolizumab N/S 100mL Freeflex',
    containerName: 'N/S 100mL Freeflex', // 198mL
    drugs: [
      DrugModel(
        drugID: '38e11c42-26d4-41a8-83cd-ef7e770d0f5f',
        drugName: 'Pembrolizumab',
        drugUnits: 'mg',
        ocsDrugID: 3,
      ),
    ],
    productAdministrationRoute: 'IVENOS',
    ocsProductID: 3,
  ),
  ProductModel(
    productID: '46ec5ac0-f31c-45d1-8011-c65868d744f1',
    productName: 'Doxorubicin / Vincristine / Etoposide (E/phos br) - '
        '24-hour Surefuser, Surefuser 250mL 1 day',
    containerName: '24-hour Surefuser, Surefuser 250mL 1 day', // 241mL
    drugs: [
      DrugModel(
        drugID: '48e11c42-26d4-41a8-83cd-ef7e770d0f5f',
        drugName: 'Doxorubicin',
        drugUnits: 'mg',
        ocsDrugID: 4,
      ),
      DrugModel(
        drugID: '58e11c42-26d4-41a8-83cd-ef7e770d0f5f',
        drugName: 'Vincristine',
        drugUnits: 'mg',
        ocsDrugID: 5,
      ),
      DrugModel(
        drugID: '68e11c42-26d4-41a8-83cd-ef7e770d0f5f',
        drugName: 'Etoposide (E/phos br)',
        drugUnits: 'mg',
        ocsDrugID: 6,
      ),
    ],
    productAdministrationRoute: 'IVINF',
    ocsProductID: 4,
  ),
];
