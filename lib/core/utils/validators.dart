String? defaultPhoneValidator(String value) {
  // Example validation: must be at least 10 characters long and start with '+'
  if (!value.startsWith('+') || value.length < 10) {
    return 'Enter a valid phone number';
  }
  return null; // null means valid
}
