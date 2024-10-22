String? validatePassword(String? value) {
  if (value == null) {
    return 'Password cannot be empty.';
  } else if (value.length < 8) {
    return 'Password must be at least 8 characters long.';
  } else if (!value.contains(RegExp(r'[A-Z]'))) {
    return 'Password must contain at least one uppercase letter.';
  } else if (!value.contains(RegExp(r'[a-z]'))) {
    return 'Password must contain at least one lowercase letter.';
  } else if (!value.contains(RegExp(r'[0-9]'))) {
    return 'Password must contain at least one number.';
  } else {
    return null;
  }
}
bool isValidPassword(
    String? inputString, {
      bool isRequired = false,
    }) {
  bool isInputStringValid = false;

  if (!isRequired && (inputString == null ? true : inputString.isEmpty)) {
    isInputStringValid = true;
  }

  if (inputString != null && inputString.isNotEmpty) {
    const pattern = r'^(?=.*[A-Z])(?=.*[\W_])(?=.*\d).{8,}$';

    final regExp = RegExp(pattern);

    isInputStringValid = regExp.hasMatch(inputString);
  }

  return isInputStringValid;
}

bool passwordIsValid(String password) {
  if (validatePassword(password) == null) {
    return true;
  } else {
    return false;
  }
}

bool isValidEmail(
    String? inputString, {
      bool isRequired = false,
    }) {
  bool isInputStringValid = false;

  if (!isRequired && (inputString == null ? true : inputString.isEmpty)) {
    isInputStringValid = true;
  }

  if (inputString != null && inputString.isNotEmpty) {
    const pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

    final regExp = RegExp(pattern);

    isInputStringValid = regExp.hasMatch(inputString);
  }

  return isInputStringValid;
}


