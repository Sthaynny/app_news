class Validators {
  static String? validateText(String? value) {
    if (value == null || value.isEmpty) {
      return 'This field cannot be empty';
    }
    return null;
  }

  static String? validateLocalization(String? value) {
    if (value != null) {
      final regex = RegExp(r'^-?\d+(\.\d+)?,\s*-?\d+(\.\d+)?$');

      if (!regex.hasMatch(value)) {
        return 'Formato inválido. ex: 000.000, 0000.0000';
      }
    }
    return null;
  }

  static String? validateUrl(String? value) {
    if (value != null) {
      final regex = RegExp(
        r'^(https?:\/\/)?(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)$',
      );

      if (!regex.hasMatch(value)) {
        return 'Formato inválido. ex: https://exemplo.com';
      }
    }
    return null;
  }
}
