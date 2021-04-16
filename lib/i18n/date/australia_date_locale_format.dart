import 'package:intl/intl.dart';

/// 20xx 2021 to 2099
/// It would be interesting if this software was used for more than a century
const String twoDigitYearPrefix = '20';
// ignore: constant_identifier_names
const String en_AU = 'en_AU';

final DateFormat ausFullDateDisplayFormat = DateFormat(
  'dd/MM/yyyy',
  en_AU,
);
