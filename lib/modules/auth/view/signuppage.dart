import 'package:booking_system/modules/auth/view/loginpage.dart';
import 'package:booking_system/modules/auth/view/signupformwidget.dart';
import 'package:booking_system/common_widgets/form/footerForm.dart';
import 'package:booking_system/common_widgets/form/headerForm.dart';
import 'package:flutter/material.dart';

class SignupPage extends StatelessWidget {
  
  const SignupPage({super.key});
  
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const headerform(
                image: 'assets/images/signup.png',
                title: "Sign Up",
                subTitle: "Create an account, It's free",
              ),
              const signupForm(),
              footerform(
                image: "assets/images/google.png",
                buttonText: "Sign Up with Google",
                alternativeText: "Already have an account? ",
                alternativeTextSpan: "Login",
                heightBetween: 20.0,
                onPressAlternative: () => loginPage(),
              ),
              //
            ],
          ),
        ),
      ),
    );
  }
}