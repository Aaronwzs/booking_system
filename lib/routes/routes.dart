


import 'package:booking_system/modules/auth/view/changepasswordpage.dart';
import 'package:booking_system/modules/auth/view/forgetpassword.dart';
import 'package:booking_system/modules/auth/view/homepage.dart';
import 'package:booking_system/modules/auth/view/loginpage.dart';
import 'package:booking_system/modules/auth/view/profilepage.dart';
import 'package:booking_system/modules/auth/view/signuppage.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class AppRoutes {
  static const login = '/login';
  static const signup = '/signup';
  static const home = '/home';
  static const profile = '/profile';
  static const forgotPassword = '/forgot-password';
  static const changePassword = '/change-password';

  static List<GetPage> pages = [
    GetPage(name: login, page: () => const loginPage()),
    GetPage(name: signup, page: () => const SignupPage()),
    GetPage(name: home, page: () =>  HomePage()),
    GetPage(name: profile, page: () => const ProfilePage()),
    GetPage(name: forgotPassword, page: () => ForgotPasswordPage()),
    GetPage(name: changePassword, page: () => ChangePasswordPage(email: '')),
  ];
}