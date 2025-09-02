import 'package:booking_system/repo/auth_repo/auth_repo.dart';
import 'package:booking_system/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class LoginController extends GetxController {

  static LoginController get instance => Get.find();

  final email = TextEditingController();
  final password = TextEditingController();

  final isPasswordHidden = true.obs;

  String? validateEmail(String value) {
   if (value.isEmpty) {
      return "Email cannot be empty";
    }
   if (!GetUtils.isEmail(value)) {
      return "Provide valid Email";
    }
    return null;
  }

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }


   Future<void> loginUser() async {
    final emailText = email.text.trim();
    final passwordText = password.text.trim();

    final emailError = validateEmail(emailText);
    if (emailError != null) {
       Get.snackbar("Error", emailError,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white);
      return;
    }
    if (passwordText.isEmpty) {
      Get.snackbar("Error", "Password cannot be empty",
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white);
      return;
    }
    final success = await AuthRepo.instance.loginUser( emailText, passwordText);
    if(success != null){
      Get.offAllNamed(AppRoutes.home); // Navigate & remove all previous pages
    }
  }

  Future<void> logout() async {
    await AuthRepo.instance.logout();
    Get.offAllNamed(AppRoutes.login); // Navigate to login and remove all previous pages
  }
}