import 'package:intl/intl.dart';

class Formatter {
  static String formatPrice(num price) {
    final numberFomat = NumberFormat("₹ #,##,###");
    return numberFomat.format(price);
  }

  static String formatDate(DateTime date) {
    DateTime localDate = date.toLocal();
    final dateFormat = DateFormat("dd MMM y, hh:mm a");
    return dateFormat.format(localDate);
  }
}
