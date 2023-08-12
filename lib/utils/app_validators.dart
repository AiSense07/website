class Validators {
  static String? phoneNumber(String? text) {
    if (text != null) {
      if (text.isEmpty) {
        return "Please enter your phone number!";
      } else if (text.length < 10) {
        return "Please enter valid phone number!";
      }
    }
    return null;
  }

  static String? email(String? text) {
    final RegExp regex =
        RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (text != null) {
      final bool validEmail = regex.hasMatch(text);
      if (text.isEmpty) {
        return "Please enter your email address!";
      } else if (!validEmail) {
        return "Please enter valid email address!";
      }
    }
    return null;
  }

  static String? pass(String? text) {
    final RegExp regex =
        RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
    if (text != null) {
      final bool validEmail = regex.hasMatch(text);
      if (text.isEmpty) {
        return "Please enter your password";
      } else if (text.length < 8) {
        return "Please enter at least 8 digit password";
      } else if (!validEmail) {
        return "Please enter valid password";
      }
    }
    return null;
  }

  static String? commonString(String? text) {
    if (text != null) {
      if (text.isEmpty) {
        return "Please enter your Full name";
      }
    }
    return null;
  }
}
