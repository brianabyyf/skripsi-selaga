import 'package:intl/intl.dart';

class CurrencyFormat {
  static String convertToIdr(String denom , dynamic number, int decimalDigit) {
    NumberFormat currencyFormatter = NumberFormat.currency(
      symbol: '$denom  ',
      decimalDigits: decimalDigit,
    );

    if (number != null) {
      return currencyFormatter.format(number);
    }

    return "";
  }
}

class DateTimeFormat {
  static convertToString(int month) {
    switch (month) {
      case 1:
        return "January";
      case 2:
        return "February";
      case 3:
        return "March";
      case 4:
        return "April";
      case 5:
        return "Mei";
      case 6:
        return "June";
      case 7:
        return "July";
      case 8:
        return "August";
      case 9:
        return "September";
      case 10:
        return "October";
      case 11:
        return "November";
      case 12:
        return "December";
    }
  }
}