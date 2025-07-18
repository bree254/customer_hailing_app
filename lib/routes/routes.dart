import 'package:customer_hailing/core/app_export.dart';
import 'package:customer_hailing/presentation/auth/email/email_sign-in_up_screen.dart';
import 'package:customer_hailing/presentation/auth/email/enter_your_number.dart';
import 'package:customer_hailing/presentation/auth/google/google_sign_in_up_screen.dart';
import 'package:customer_hailing/presentation/auth/verification.dart';
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
import 'package:customer_hailing/presentation/schedule_trip/screens/schedule_new_trip_screens.dart';
import 'package:customer_hailing/presentation/schedule_trip/screens/scheduled_trips_screen.dart';
import 'package:customer_hailing/presentation/schedule_trip/screens/trip_details.dart';
import 'package:customer_hailing/presentation/splash/splash_screen.dart';
import 'package:customer_hailing/presentation/trip_history/trip_history_screen.dart';
import '../presentation/auth/phone_number/login_or_signup_screen.dart';
import '../presentation/trip_history/history_details_screen.dart';
import '../presentation/auth/phone_number/login_or_signup_screen.dart';
import '../presentation/schedule_trip/screens/enter_schedule_trip_details.dart';
import '../presentation/schedule_trip/screens/schedule_select_ride_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String home = '/home';
  static const String loginorsignup = "/login_or_signup";
  static const String verification = "/verification";
  static const String googleSignOn = "/google_sign_on";
  static const String emailSignOn = "/email_sign_on";
  static const String emailPhoneNumber = "/email_phone_no";
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


  static List<GetPage> pages = [
    GetPage(
      name: splash,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: home,
      page: () => const HomeScreen(),
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
      name: emailPhoneNumber,
      page: () => const EmailPhoneNumberScreen(),
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
  ];
}
