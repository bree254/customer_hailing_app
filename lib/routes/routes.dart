import 'package:customer_hailing/core/app_export.dart';
import 'package:customer_hailing/presentation/auth/email/email_sign-in_screen.dart';
import 'package:customer_hailing/presentation/auth/email/email_sign_up_screen.dart';
import 'package:customer_hailing/presentation/auth/google/google_sign_in_up_screen.dart';
import 'package:customer_hailing/presentation/auth/verification.dart';
import 'package:customer_hailing/presentation/call-driver/screens/incoming_call_screen.dart';
import 'package:customer_hailing/presentation/call-driver/screens/ongoing_call_screen.dart';
import 'package:customer_hailing/presentation/message-driver/screens/message_driver_screen.dart';
import 'package:customer_hailing/presentation/order_request/screens/await_driver_screen.dart';
import 'package:customer_hailing/presentation/order_request/binding/home_binding.dart';
import 'package:customer_hailing/presentation/order_request/screens/chat_screen.dart';
import 'package:customer_hailing/presentation/order_request/screens/emergency_services_screen.dart';
import 'package:customer_hailing/presentation/order_request/screens/home_screen.dart';
import 'package:customer_hailing/presentation/order_request/screens/name_location_screen.dart';
import 'package:customer_hailing/presentation/order_request/screens/profile_screen.dart';
import 'package:customer_hailing/presentation/order_request/screens/rate_ride_screen.dart';
import 'package:customer_hailing/presentation/order_request/screens/saved_locations_screen.dart';
import 'package:customer_hailing/presentation/order_request/screens/search_location_screen.dart';
import 'package:customer_hailing/presentation/order_request/screens/enter_trip_details.dart';
import 'package:customer_hailing/presentation/order_request/screens/select_ride_screen.dart';
import 'package:customer_hailing/presentation/order_request/screens/share_trip_details_screen.dart';
import 'package:customer_hailing/presentation/order_request/screens/share_with_screen.dart';
import 'package:customer_hailing/presentation/order_request/screens/trip_status_screen.dart';
import 'package:customer_hailing/presentation/payments/screens/add_card_screen.dart';
import 'package:customer_hailing/presentation/payments/screens/add_new_payment_screen.dart';
import 'package:customer_hailing/presentation/payments/screens/payment_methods_screen.dart';
import 'package:customer_hailing/presentation/personal_information/edit_profile_screen.dart';
import 'package:customer_hailing/presentation/promotions/promotions_screen.dart';
import 'package:customer_hailing/presentation/schedule_trip/screens/schedule_new_trip_screens.dart';
import 'package:customer_hailing/presentation/schedule_trip/screens/scheduled_trips_screen.dart';
import 'package:customer_hailing/presentation/schedule_trip/screens/trip_details.dart';
import 'package:customer_hailing/presentation/splash/splash_screen.dart';
import 'package:customer_hailing/presentation/support-centre/chat_lists.dart';
import 'package:customer_hailing/presentation/support-centre/chat_support_screen.dart';
import 'package:customer_hailing/presentation/support-centre/faqs.dart';
import 'package:customer_hailing/presentation/support-centre/support_centre_screen.dart';
import 'package:customer_hailing/presentation/trip_history/trip_history_screen.dart';
import 'package:customer_hailing/presentation/two_factor_authentication/change_password_screen.dart';
import 'package:customer_hailing/presentation/two_factor_authentication/forgot_password_screen.dart';
import 'package:customer_hailing/presentation/two_factor_authentication/password_and_security_screen.dart';
import 'package:customer_hailing/presentation/two_factor_authentication/reset_password_screen.dart';
import 'package:customer_hailing/presentation/two_factor_authentication/success_screen.dart';
import 'package:customer_hailing/presentation/two_factor_authentication/two_factor_authentication_screen.dart';
import '../presentation/auth/email/details_email_sign_up_screen.dart';
import '../presentation/auth/phone_number/login_or_signup_screen.dart';
import '../presentation/call-driver/screens/outgoing_call_screen.dart';
import '../presentation/trip_history/history_details_screen.dart';
import '../presentation/schedule_trip/screens/enter_schedule_trip_details.dart';
import '../presentation/schedule_trip/screens/schedule_select_ride_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String home = '/home';
  static const String loginorsignup = "/login_or_signup";
  static const String verification = "/verification";
  static const String googleSignOn = "/google_sign_on";
  static const String emailSignOn = "/email_sign_on";
  static const String emailSignUp = "/email_sign_up";
  static const String detailsEmailSignUp = "/details_email_sign_up";
  static const String search = "/search";
  static const String selectRide = "/rides";
  static const String awaitDriver = "/await_driver";
  static const String tripStatus ="/trip_status";
  static const String rateRide = "/rate_ride";
  static const String shareTrip ="/share_trip";
  static const String shareWith = "/share_with";
  static const String chats ="/chat";
  static const String profile="/profile";
  static const String savedLocation="/saved_location";
  static const String searchLocation="/search_location";
  static const String nameLocation ="/name_location";
  static const String tripHistory ="/trip_history";
  static const String historyDetails ="/history_details";
  static const String paymentMethods ="/payments_methods";
  static const String addPaymentMethods ="/add_payments_methods";
  static const String addCard ="/add_card";
  static const String emergency = "/emergency";
  static const String scheduleTrip = "/schedule_trip";
  static const String scheduleNewTrip ="/schedule_new_trip";
  static const String enterScheduleTripDetails ="/enter_schedule_trip_details";
  static const String scheduleSelectRide ="/schedule_rides";
  static const String tripDetails ="/trip_details";
  static const String passwordSecurity="/password_security";
  static const String twoFA="/two_factor_authentication";
  static const String changePassword="/change_password";
  static const String forgotPassword="/forgot_password";
  static const String success="/success";
  static const String resetPassword="/reset_password";
  static const String editProfile="/edit_profile";
  static const String incomingCalls="/incoming_calls";
  static const String ongoingCalls="/ongoing_calls";
  static const String outgoingCalls="/outgoing_calls";
  static const String messageDriver="/message_driver";
  static const String promotions="/promotions";
  static const String support="/support";
  static const String faq="/faq";
  static const String chatList="/chat_list";
  static const String chatSupportScreen="/chat_support_screen";

  static List<GetPage> pages = [
    GetPage(
      name: splash,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: home,
      page: () =>   HomeScreen(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: loginorsignup,
      page: () => const LoginOrSignupScreen(),
    ),
    GetPage(
      name: verification,
      page: () => const VerificationScreen(),
    ),
    GetPage(
      name: googleSignOn,
      page: () => const GoogleSignInUpScreen(),
    ),
    GetPage(
      name: emailSignOn,
      page: () => const EmailSignInUpScreen(),
    ),
    GetPage(
      name: emailSignUp,
      page: () => const EmailSignUpScreen(),
    ),
    GetPage(
      name: detailsEmailSignUp,
      page: () => const DetailsEmailSignUpScreen(),
    ),
    GetPage(
        name: search,
        page: () => const EnterTripDetailsScreen(),
    ),
    GetPage(
        name: selectRide,
        page: () =>  const SelectRideScreen(),
    ),
    GetPage(
        name: awaitDriver,
        page: () => const AwaitDriverScreen(),
    ),
    GetPage(
      name: tripStatus,
      page: () => const TripStatusScreen(),
    ),
    GetPage(
      name: rateRide,
      page: () => const RateRideScreen(),
    ),
    GetPage(
      name: shareTrip,
      page: () => const ShareTripDetailsScreen(),
    ),
    GetPage(
      name: shareWith,
      page: () => const ShareWithScreen(),
    ),
    GetPage(
      name: chats,
      page: () =>  const ChatScreen(),
    ),
    GetPage(
      name: profile,
      page: () =>  const ProfileScreen(),
    ),
    GetPage(
      name: savedLocation,
      page: () =>  const SavedLocationsScreen(),
    ),
    GetPage(
      name: searchLocation,
      page: () =>  const SearchLocationScreen(),
    ),
    GetPage(
      name: nameLocation,
      page: () =>  const NameLocationScreen(),
    ),
    GetPage(
      name: tripHistory,
      page: () =>  const TripHistoryScreen(),
    ),
    GetPage(
      name: historyDetails,
      page: () =>  const HistoryDetailsScreen(),
  ),
    GetPage(
      name: paymentMethods,
      page: () =>  const PaymentMethodsScreen(),
    ),
    GetPage(
      name: addPaymentMethods,
      page: () =>  const AddNewPaymentScreen(),
    ),
    GetPage(
      name: addCard,
      page: () =>  const AddCardScreen(),
  ),
    GetPage(
      name: emergency,
      page: () =>  const EmergencyServicesScreen(),
    ),
    GetPage(
      name: scheduleTrip,
      page: () =>  const ScheduledTripsScreen(),
    ),
    GetPage(
      name: scheduleNewTrip,
      page: () =>  const ScheduleNewTripScreen(),
    ),
    GetPage(
      name: enterScheduleTripDetails,
      page: () =>  const EnterScheduleTripDetailsScreen(),
    ),
    GetPage(
      name: scheduleSelectRide,
      page: () =>  const ScheduleSelectRideScreen(),
    ),
    GetPage(
      name: tripDetails,
      page: () =>  const TripDetailsScreen(),
    ),
    GetPage(
      name: passwordSecurity,
      page: () =>  const PasswordAndSecurityScreen(),
    ),
    GetPage(
      name: twoFA,
      page: () =>  const TwoFactorAuthenticationScreen(),
    ),
    GetPage(
      name: changePassword,
      page: () =>  const ChangePasswordScreen(),
    ),
    GetPage(
      name: forgotPassword,
      page: () =>  const ForgotPasswordScreen(),
    ),
    GetPage(
      name: success,
      page: () =>  const SuccessScreen(),
    ),
    GetPage(
      name: resetPassword,
      page: () =>  const ResetPasswordScreen(),
    ),
    GetPage(
      name: editProfile,
      page: () =>  const EditProfileScreen(),
    ),
    GetPage(
      name: incomingCalls,
      page: () =>    IncomingCallScreen(),
    ),
    GetPage(
      name: ongoingCalls,
      page: () =>    OngoingCallScreen(),
    ),
    GetPage(
      name: outgoingCalls,
      page: () =>    OutgoingCallScreen(),
    ),
    GetPage(
      name: messageDriver,
      page: () =>   const MessageDriverScreen(),
    ),
    GetPage(
      name: promotions,
      page: () =>   const PromotionsScreen(),
    ),
    GetPage(
      name: support,
      page: () =>   const SupportCentreScreen(),
    ),
    GetPage(
      name: faq,
      page: () =>   const FaqScreen(),
    ),
    GetPage(
      name: chatList,
      page: () =>   const ChatLists(),
    ),
    GetPage(
      name: chatSupportScreen,
      page: () =>   const ChatSupportScreen(),
    ),
  ];
}
