import 'package:customer_hailing/presentation/auth/email/email_sign-in_up_screen.dart';
import 'package:customer_hailing/presentation/auth/email/enter_your_number.dart';
import 'package:customer_hailing/presentation/auth/google/google_sign_in_up_screen.dart';
import 'package:customer_hailing/presentation/auth/phone_number/login_or_signup_screen.dart';
import 'package:customer_hailing/core/app_export.dart';
import 'package:customer_hailing/presentation/auth/verification.dart';
import 'package:customer_hailing/presentation/order_request/binding/home_binding.dart';
import 'package:customer_hailing/presentation/order_request/home_screen.dart';
import 'package:customer_hailing/presentation/order_request/search_screen.dart';
import 'package:customer_hailing/presentation/splash/splash_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String home = '/home';
  static const String loginorsignup ="/login_or_signup";
  static const String verification ="/verification";
  static const String googleSignOn ="/google_sign_on";
  static const String emailSignOn ="/email_sign_on";
  static const String emailPhoneNumber = "/email_phone_no";
  static const String search ="/search";


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
        page: ()=> const GoogleSignInUpScreen(),
    ),
    GetPage(
        name: emailSignOn,
        page: ()=> const EmailSignInUpScreen(),
    ),
    GetPage(
        name: emailPhoneNumber,
        page: ()=> const EmailPhoneNumberScreen(),
    ),
    GetPage(
        name: search,
        page: ()=> SearchScreen()),
  ];
}
