import 'package:booking_system/modules/auth/controller/logincontroller.dart';
import 'package:booking_system/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});
  
  @override
  Widget build(Object context) {

    final loginController = Get.put(LoginController()); // Initialize the LoginController
    

    return Form(
      child: Container(
        child: Column(
          children: [
            TextFormField(
              controller: loginController.email,
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.person_outline_outlined),
                labelText: "E-mail",
                hintText: "Enter your email",
                border: OutlineInputBorder(),
              ),
              ),
              const SizedBox(height: 20),
            Obx(()=>
              TextFormField(
                controller: loginController.password,
                obscureText: loginController.isPasswordHidden.value,
                decoration:  InputDecoration(
                  prefixIcon: Icon(Icons.fingerprint),
                  labelText: "Password",
                  hintText: "Enter your password",
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: LoginController.instance.togglePasswordVisibility,
                    icon: Icon(LoginController.instance.isPasswordHidden.value
                        ? Icons.visibility_off
                        : Icons.visibility),
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 20),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
              
                onPressed: () {
                 Get.offAllNamed(AppRoutes.forgotPassword);
                },
                child: const Text("Forget Password?"),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: 
                 () => LoginController.instance.loginUser(),
                child: Text("Login".toUpperCase()),
              ),
            ),
              ],
              ),
              ),
              );
  }

}