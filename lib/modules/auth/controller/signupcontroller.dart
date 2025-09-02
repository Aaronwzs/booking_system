import 'package:booking_system/modules/auth/model/profilemodel.dart';
import 'package:booking_system/repo/auth_repo/auth_repo.dart';
import 'package:booking_system/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class SignupController extends GetxController {

  static SignupController get instance => Get.find();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final fullNameController = TextEditingController();
  final phoneController = TextEditingController();
  final ageController = TextEditingController(); 

  
  

String? validateEmail(String value) {
   if (value.isEmpty) {
      return "Email cannot be empty";
    }
   if (!GetUtils.isEmail(value)) {
      return "Provide valid Email";
    }
    return null;
  }

  String? validatePassword(String value) {
  if (value.isEmpty) {
    return "Password cannot be empty";
  }
  if (value.length < 6) {
    return "Password should be at least 6 characters";
  }
  return null;
}

  Future<void> signupUser(ProfileModel profile , String email, String password) async {
  final emailText = email.trim();
  final passwordText = password.trim();
  

  final emailError = validateEmail(emailText);
  if (emailError != null) {
    Get.snackbar("Error", emailError,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white);
    return;
  }

  if (passwordText.isEmpty || profile.fullName.isEmpty || profile.phone.bitLength == 0 || profile.age.bitLength == 0) {
    Get.snackbar("Error", "Fields cannot be empty",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white);
    return;
  }

   // Password validation
  if (passwordText.length < 6) {
    Get.snackbar("Error", "Password must be at least 6 characters",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white);
    return;
  }

  final success = await AuthRepo.instance.registerUser(
      profile, emailText, passwordText );

  if (success != null) {
    Get.offAllNamed(AppRoutes.login); // Navigate & remove all previous pages
  }
}

}