class Validators {
  static String? validateIsEmpty(String? value) {
    if (value != null) {
      if (value.isEmpty) {
        return 'Field cannot be left empty';
      }
      return null;
    }
    return "";
  }
}
