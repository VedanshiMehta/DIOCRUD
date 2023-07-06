class Validator {
  static const String _emailPattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';

  static const String _fristNamePattern = r'^[a-zA-Z]{2,50}$';

  static RegExp emailReg = RegExp(_emailPattern);
  static RegExp nameReg = RegExp(_fristNamePattern);

  static String? validateFirstName(String? value) {
    if (value == null || value.isEmpty) {
      return "This field can't be blank";
    } else if (!nameReg.hasMatch(value)) {
      return "Please enter valid first name";
    } else if (value.length < 2) {
      return "Minimum character length is 2";
    }
    return null;
  }

  static String? validateLastName(String? value) {
    if (value == null || value.isEmpty) {
      return "This field can't be blank";
    } else if (!nameReg.hasMatch(value)) {
      return "Please enter valid last name";
    } else if (value.length < 2) {
      return "Minimum character length is 2";
    }
    return null;
  }

  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "This field can't be blank";
    } else if (!emailReg.hasMatch(value)) {
      return "Please enter valid email id.";
    }
    return null;
  }
}
