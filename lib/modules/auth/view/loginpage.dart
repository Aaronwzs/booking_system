import 'package:booking_system/modules/auth/view/loginformwidget.dart';
import 'package:booking_system/modules/auth/view/signuppage.dart';
import 'package:booking_system/common_widgets/form/footerForm.dart';
import 'package:booking_system/common_widgets/form/headerForm.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class loginPage extends StatelessWidget{
const loginPage({super.key}); 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(children: [
            const headerform(
              image: 'assets/images/login.png',
              title: 'Welcome Back',
              subTitle: 'Login to your account',
              ),
            const LoginForm(),
             footerform(
              image: 'assets/images/google.png',
              buttonText: 'Login with Google',
              alternativeText: "Don't have an account? ",
              alternativeTextSpan: "Sign up",
              heightBetween: 20,
              crossAxisAlignment: CrossAxisAlignment.center,
              onPressAlternative: () => SignupPage(),
            ),
          ],),
        ),
      )
    );
  }

}

