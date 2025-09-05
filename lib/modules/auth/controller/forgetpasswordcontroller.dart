import 'package:booking_system/modules/auth/model/userauthmodel.dart';
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

Future<bool?> resetPasswordWithToken({
  required String email,
  required String token,
  required String newPassword,
}) async {
//Verify tokens in db
final isValid = AuthRepo.instance.verifyResetToken(email, token);
// ignore: unrelated_type_equality_checks
if(isValid  == true){
//Get the Supabase user (Auth)
final userData = await AuthRepo.instance.getUserByEmail(email);
if(userData != null){
  print("✅ User Data: $userData");  
  print("User ID: ${userData['id']}");  
  print("User Email: ${userData['email']}"); 
}
if( userData != null) {
  var user = AuthUserModel.fromMap(userData);

  user = user.copyWith(password: newPassword);

  final updateUser = await AuthRepo.instance.updatePasswordEdge(user);

  if(updateUser != true){
    await AuthRepo.instance.markTokenAsUsed(token);
    return true;
  }
} else{
  Get.snackbar("Error", "Invalid or expired reset token");
}
}
return null;

}



  



 

}
