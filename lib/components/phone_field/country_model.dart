class Country {
  final String name;
  final String? alpha2Code;
  final String flagUri;
  final String dialCode;

  Country(
      {required this.name,
      required this.alpha2Code,
      required this.flagUri,
      required this.dialCode});

  factory Country.fromJson(Map<String, dynamic> data) {
    return Country(
      name: data['en_short_name'],
      alpha2Code: data['alpha_2_code'],
      dialCode: data['dial_code'],
      flagUri: 'assets/flags/${data['alpha_2_code'].toLowerCase()}.png',
    );
  }
}
