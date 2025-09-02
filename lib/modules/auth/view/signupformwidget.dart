  import 'package:booking_system/modules/auth/controller/signupcontroller.dart';
import 'package:booking_system/modules/auth/model/profilemodel.dart';
  import 'package:flutter/material.dart';
  import 'package:get/get.dart';
  import 'package:get/get_core/src/get_main.dart';

  class signupForm extends StatelessWidget {
    const signupForm({super.key});

    @override
    Widget build(BuildContext context) {

      final signUpController =Get.put(SignupController()); // Initialize the SignupController
      // Use a GlobalKey to manage the form state
      final _formKey = GlobalKey<FormState>(); // Key for the form to validate and save

      return Container(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Form(
          key: _formKey, // Assign the key to the form
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: signUpController.fullNameController, // Use the controller from SignupController
                decoration: const InputDecoration(
                  labelText: "Full Name",
                  hintText: "Full Name",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person_outline_rounded),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: signUpController.emailController, // Use the controller from SignupController
                decoration: const InputDecoration(
                  labelText: "E-mail",
                  hintText: "Enter your email",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.email_outlined),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: signUpController.phoneController, // Use the controller from SignupController
                decoration: const InputDecoration(
                  labelText: "Phone No",
                  hintText: "Enter your phone number",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.numbers),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: signUpController.ageController, // Use the controller from SignupController
                decoration: const InputDecoration(
                  labelText: "Age",
                  hintText: "Enter your Age",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.app_registration),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: signUpController.passwordController, // Use the controller from SignupController
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                  labelText: "Password",
                  hintText: "Enter your password",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.fingerprint),                
                ),
                //validator: (value) => signUpController.validatePassword(value ?? ''),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {

                    if (_formKey.currentState!.validate()) {
   final profile = ProfileModel(
      authUserId: '',
      fullName: signUpController.fullNameController.text.trim(),
      age: int.tryParse(signUpController.ageController.text.trim()) ?? 0,
      phone: int.tryParse(signUpController.phoneController.text.trim()) ?? 0,
      role: 1,
      status: 1,
    );

                      SignupController.instance.signupUser(profile,
                          signUpController.emailController.text,
                          signUpController.passwordController.text);
                      }
                  },
                  child: Text("Sign Up".toUpperCase()),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
  
  