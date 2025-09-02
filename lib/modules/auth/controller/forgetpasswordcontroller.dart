import 'package:booking_system/repo/auth_repo/auth_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class forgetPasswordController extends GetxController {

static forgetPasswordController get instance => Get.find();

final formKey = GlobalKey<FormState>();

final emailController = TextEditingController();
final tokenController = TextEditingController();
final passwordController = TextEditingController();
final confirmpasswordController = TextEditingController();

final isPasswordHidden = true.obs;
final isLoading = false.obs;

void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

void dispose() {
    tokenController.dispose();
    passwordController.dispose();
    confirmpasswordController.dispose();
  }

 Future<void> sendResetLink(String email) async {

  //AuthRepo.instance.resetPassword(email);
  AuthRepo.instance.requestPasswordReset(email);
  }

  
 }
