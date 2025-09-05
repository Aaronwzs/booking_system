import 'package:booking_system/modules/auth/controller/forgetpasswordcontroller.dart';
import 'package:booking_system/modules/auth/model/userauthmodel.dart';
import 'package:booking_system/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordPage extends StatelessWidget {
  ForgotPasswordPage({super.key});

  final forgetPasswordController fpController = Get.put(forgetPasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Forgot Password")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Enter your registered email to reset your password.",
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: fpController.emailController,
              decoration: const InputDecoration(
                labelText: "Email",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  fpController.sendResetLink(fpController.emailController.text.trim());
                  
                  Get.snackbar("Success", "Password reset link sent to your email");
                 Get.offAllNamed(AppRoutes.changePassword,
                 arguments: {'email': fpController.emailController.text.trim()}
                 ); 
                },
                child: const Text("Send Reset Link"),
              ),  
            ),
          ],
        ),
      ),
    );
  }
}
