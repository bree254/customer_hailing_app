class Endpoints {
  static const String baseUrl = 'https://yasil-backend.cymelle.com';

  //Onboarding Endpoints
  static const String loginUser = '$baseUrl/auth/api/v1/onboard';
  static const String validateOtp = '$baseUrl/auth/api/v1/validate';
  static const String updateUser = '$baseUrl/auth/api/v1/update/user';
  static const String socialAuth = '$baseUrl/auth/api/v1/social/auth';
  static const String resendOtp = '$baseUrl/auth/api/v1/resend/otp';

  static const String getUser = '$baseUrl/auth/api/v1/get/user/';
  //add the pathvariable to the endpoint

}