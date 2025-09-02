

import 'package:booking_system/modules/auth/controller/forgetpasswordcontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ChangePasswordPage extends StatelessWidget {
  final String email;

  const ChangePasswordPage({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(forgetPasswordController());

    return Scaffold(
      appBar: AppBar(title: const Text("Reset Password")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: controller.formKey,
          child: Column(
            children: [
              // Token
              TextFormField(
                controller: controller.tokenController,
                decoration: const InputDecoration(
                  labelText: "Reset Token",
                  prefixIcon: Icon(Icons.vpn_key),
                  border: OutlineInputBorder(),
                ),
                validator: (value) =>
                    value == null || value.isEmpty ? "Enter your token" : null,
              ),
              const SizedBox(height: 16),

              // Email (readonly)
              TextFormField(
                initialValue: email,
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: "Email",
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // New Password
              Obx(() => TextFormField(
                    controller: controller.passwordController,
                    obscureText: controller.isPasswordHidden.value,
                    decoration: InputDecoration(
                      labelText: "New Password",
                      prefixIcon: const Icon(Icons.lock),
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        
                       onPressed: forgetPasswordController.instance.togglePasswordVisibility,
                    icon: Icon(forgetPasswordController.instance.isPasswordHidden.value
                        ? Icons.visibility_off
                        : Icons.visibility) 
                        ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter a new password";
                      }
                      if (value.length < 6) {
                        return "Password must be at least 6 characters";
                      }
                      return null;
                    },
                  )),
              const SizedBox(height: 16),

              // Confirm Password
              Obx(() => TextFormField(
                    controller: controller.confirmpasswordController,
                    obscureText: controller.isPasswordHidden.value,
                    decoration: InputDecoration(
                      labelText: "Confirm Password",
                      prefixIcon: const Icon(Icons.lock_outline),
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                          onPressed: forgetPasswordController.instance.togglePasswordVisibility,
                    icon: Icon(forgetPasswordController.instance.isPasswordHidden.value
                        ? Icons.visibility_off
                        : Icons.visibility)),
                    ),
                    validator: (value) {
                      if (value != controller.passwordController.text) {
                        return "Passwords do not match";
                      }
                      return null;
                    },
                  )),
              const SizedBox(height: 24),

              // Reset Button
              Obx(() => SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: controller.isLoading.value
                          ? null
                          : () => controller.sendResetLink(email),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: controller.isLoading.value
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text("Reset Password",
                              style: TextStyle(fontSize: 16)),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
