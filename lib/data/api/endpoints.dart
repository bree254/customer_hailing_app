class Endpoints {
  static const String baseUrl = 'https://backend.yasil.co.ke';
  //static const String baseUrl = 'https://yasil-backend.cymelle.com';
  static const String ngrokUrl = 'https://driven-credible-panda.ngrok-free.app';

  //user management Endpoints
  static const String loginUser = '$baseUrl/auth/api/v1/onboard';
  static const String validateOtp = '$baseUrl/auth/api/v1/validate';
  static const String updateUser = '$baseUrl/auth/api/v1/update/user';
  static const String socialAuth = '$baseUrl/auth/api/v1/social/auth';
  static const String resendOtp = '$baseUrl/auth/api/v1/resend/otp';
  static const String uploadProfile = '$baseUrl/auth/api/v1/upload/profile/pic';
  static const String updateProfile = '$baseUrl/auth/api/v1/update/profile';
  static const String getUser = '$baseUrl/auth/api/v1/get/user/';

  static const String saveDestination = '$baseUrl/auth/api/v1/frequent-destinations';
  static const String frequentDestinations = '$baseUrl/auth/api/v1/frequent-destinations';

  // RIDE REQUESTS
  static const String postLocation = '$baseUrl/rides/api/v1/customers/searchRides';
  static const String confirmTrip = '$baseUrl/rides/api/v1/customers/confirmTrip';
  static const String driverLocations = '$baseUrl/rides/api/v1/drivers/locations';
  static const String tripDetails = '$baseUrl/rides/api/v1/tripDetails/';
  static const String rateTrip = '$baseUrl/rides/api/v1/rateTrip';
  static const String tripHistory = '$baseUrl/rides/api/v1/customers/';
  static const String historyDetails = '$baseUrl/rides/api/v1/customers/';
  static const String scheduleTrip = '$baseUrl/rides/api/v1/customers/scheduleTrip';
  static const String scheduledTrip = '$baseUrl/rides/api/v1/scheduledRequests';
  static const String scheduledTripDetails = '$baseUrl/rides/api/v1/scheduledRequestInfo/';
  static const String shareTrip = '$baseUrl/rides/api/v1/shareTrip';
  static const String raiseSos = '$baseUrl/rides/api/v1/sos/raise';
  static const String cancelTrip = '$baseUrl/rides/api/v1/customers/';

}