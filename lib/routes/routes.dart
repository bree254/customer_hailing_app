import 'package:customer_hailing/presentation/auth/login_or_signup_screen.dart';
import 'package:customer_hailing/presentation/auth/login_screen.dart';
import 'package:customer_hailing/presentation/auth/register_screen.dart';
import 'package:customer_hailing/core/app_export.dart';
import 'package:customer_hailing/presentation/home/binding/home_binding.dart';
import 'package:customer_hailing/presentation/home/home_screen.dart';

class AppRoutes {
  static const String home = '/';
  static const String loginorsignup ="/login_or_signup";
  static const String signUp ="/sign_up";
  static const String login ="/login";

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
      name: signUp,
      page: () => const RegisterScreen(),
    ),
    GetPage(
      name: login,
      page: () => const LoginScreen(),
    ),
  ];
}
