import 'package:customer_hailing/presentation/auth/phone_number/login_or_signup_screen.dart';
import 'package:customer_hailing/core/app_export.dart';
import 'package:customer_hailing/presentation/auth/verification.dart';
import 'package:customer_hailing/presentation/home/binding/home_binding.dart';
import 'package:customer_hailing/presentation/home/home_screen.dart';

class AppRoutes {
  static const String home = '/';
  static const String loginorsignup ="/login_or_signup";
  static const String verification ="/verification";

  static List<GetPage> pages = [
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
  ];
}
