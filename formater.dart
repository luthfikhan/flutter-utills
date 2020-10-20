import 'package:intl/intl.dart';

class Formater {
  static String currency(double currency) {
    return NumberFormat.currency(
            name: 'IDR', locale: 'id_ID', symbol: 'Rp ', decimalDigits: 0)
        .format(currency);
  }
}
