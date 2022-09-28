import 'package:intl/intl.dart';

class Utils {
  // sert a rien puisque ne peut que recuperer les repos public 😢
  static checkRepoPrivate(bool? checker) {
    if (checker == true) {
      return "Privé";
    }
    return "Public";
  }

  static checkRepoLanguage(String? language) {
    if (language != null) {
      return language;
    }

    return "inconnu";
  }

  static dateFormatter(date) {
    final dateFormat =
        DateFormat("dd-MM-yyyy HH:mm:ss").format(DateTime.parse(date));

    return dateFormat;
  }
}
