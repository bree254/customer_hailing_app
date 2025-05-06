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

//Card Validators
String ? cardNumberValidator(String value) {
  final regex = RegExp(r'^[0-9]{16}$');
  if (!regex.hasMatch(value)) {
    return 'Enter a valid card number (16 digits)';
  }
  return null;
}

String? validateCardNumber(String? value) {
  if (value == null || value.isEmpty) {
    return 'Card number is required.';
  } else if (!RegExp(r'^\d+$').hasMatch(value)) {
    return 'Card number must contain only digits.';
  } else if (value.length != 16) {
    return 'Card number must be 16 digits long.';
  }
  return null;
}

String? validateExpiryDate(String? value) {
  if (value == null || value.isEmpty) {
    return 'Expiry date is required.';
  } else if (!RegExp(r'^(0[1-9]|1[0-2])/\d{2}$').hasMatch(value)) {
    return 'Expiry date must be in MM/YY format.';
  }
  return null;
}

String? validateCvv(String? value) {
  if (value == null || value.isEmpty) {
    return 'CVV is required.';
  } else if (!RegExp(r'^\d{3}$').hasMatch(value)) {
    return 'CVV must be 3 digits long.';
  }
  return null;
}

String? validateCVV(String? value) {
  if (value == null || value.isEmpty) {
    return 'CVV is required.';
  } else if (!RegExp(r'^\d+$').hasMatch(value)) {
    return 'CVV must contain only digits.';
  } else if (value.length < 3 || value.length > 4) {
    return 'CVV must be 3 or 4 digits long.';
  }
  return null;
}

