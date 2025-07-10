import 'package:get/get.dart';
import '../views/auth/login_view.dart';
import '../views/home/home_view.dart';
import '../views/splash/splash_view.dart';
import '../views/auth/signup_view.dart';
import '../bindings/initial_binding.dart';

/// AppRoutes defines all named routes for the Note App using GetX.
class AppRoutes {
  static const splash = '/splash';
  static const login = '/login';
  static const home = '/home';
  static const signup = '/signup';

  static final routes = [
    GetPage(name: splash, page: () => SplashView(), binding: InitialBinding()),
    GetPage(name: login, page: () => LoginView(), binding: InitialBinding()),
    GetPage(name: home, page: () => HomeView(), binding: InitialBinding()),
    GetPage(name: signup, page: () => SignupView(), binding: InitialBinding()),
  ];
}
