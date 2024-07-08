import '../core/app_export.dart';
import '../presentation/home/binding/home_binding.dart';
import '../presentation/home/home_screen.dart';

class AppRoutes {
  static const String home = '/';

  static List<GetPage> pages = [
    GetPage(
      name: home,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
    ),
  ];
}
