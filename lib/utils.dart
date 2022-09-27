class Utils {
  // sert a rien puisque ne peut que recuperer les repos public 😢
  static checkRepoPrivate(bool? checker) {
    if (checker == true) {
      return "Privé";
    }
    return "Public";
  }
}
