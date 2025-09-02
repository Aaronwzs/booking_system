  import 'dart:ui';

  import 'package:booking_system/modules/auth/model/profilemodel.dart';
import 'package:booking_system/repo/auth_repo/profile_repo.dart';
  import 'package:get/get.dart';
  import 'package:supabase_flutter/supabase_flutter.dart';

  class AuthRepo extends GetxController{

  static AuthRepo get instance => Get.put(AuthRepo()); //singleton instance

  //variables
  final supabaseAuth = Supabase.instance.client.auth;
  final _client = Supabase.instance.client;
  late Rx<User?> _user; //Reactive user variable
  var verificationId =''.obs; // Observable variable to hold the verification ID for phone authentication

  @override
  void onReady() {
    Future.delayed(const Duration(seconds:6));
    _user = Rx<User?>(supabaseAuth.currentUser);
    ever(_user, _setInitialScreen);
  }

  _setInitialScreen(User? user) {
      user == null
          ? Get.offAllNamed('/modules/view/loginpage.dart') // If user is null, navigate to login screen
          : Get.offAllNamed('/modules/view/homepage.dart'); // If user is not null, navigate to home screen
    }
  //Functions

  Future<String?>registerUser(ProfileModel profile, String email, String password) async {
    try {
      final response = await supabaseAuth.signUp(
        email: email,
        password: password, 
      );
    
      final authUserId = response.user?.id;
    if(authUserId != null){
      // Create user profile in the 'profiles' table
      final userProfile = ProfileModel(
        authUserId: authUserId, 
        fullName: profile.fullName, 
        age: profile.age, 
        role: 1,
        status: 1, 
        phone: profile.phone);
      
      await ProfileRepo.instance.createProfile(userProfile.toMap());
    }
      return authUserId; // Return the user ID if registration is successful
    
    
    } on AuthException catch (e) {
      print("Supabase AuthException: ${e.message}");
      Get.snackbar('Error', e.message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color.fromARGB(255, 255, 204, 204),
          colorText: const Color.fromARGB(255, 255, 0, 0));
      return null; // Return null if there is an authentication error
    } catch (e) {
      Get.snackbar('Error', e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color.fromARGB(255, 255, 204, 204),
          colorText: const Color.fromARGB(255, 255, 0, 0));
      return null; // Return null for any other errors
    }
  }

  Future<String?> loginUser(String email, String password) async {
    try {
      final response = await supabaseAuth.signInWithPassword(
        email: email,
        password: password,
      );
      return response.user?.id; // Return the user ID if login is successful
    } on AuthException catch (e) {
      Get.snackbar('Error', e.message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color.fromARGB(255, 255, 204, 204),
          colorText: const Color.fromARGB(255, 255, 0, 0));
      return null; // Return null if there is an authentication error
    } catch (e) {
      Get.snackbar('Error', e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color.fromARGB(255, 255, 204, 204),
          colorText: const Color.fromARGB(255, 255, 0, 0));
      return null; // Return null for any other errors
    }
  }
  Future<void> logout() async {
    try {
      await supabaseAuth.signOut();
    } on AuthException catch (e) {
      Get.snackbar('Error', e.message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color.fromARGB(255, 255, 204, 204),
          colorText: const Color.fromARGB(255, 255, 0, 0));
    } catch (e) {
      Get.snackbar('Error', e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color.fromARGB(255, 255, 204, 204),
          colorText: const Color.fromARGB(255, 255, 0, 0));
    }
  }

Future<void> resetPassword(String email) async {
    try {
      await supabaseAuth.resetPasswordForEmail(
        email);
    } catch (e) {
      throw Exception("Error sending reset link: $e");
    }
  }

  Future<void> requestPasswordReset(String email) async {
  final token = DateTime.now().millisecondsSinceEpoch.toString().substring(7, 13); // simple 6 digit token
  final expiresAt = DateTime.now().add(const Duration(minutes: 15)).toIso8601String();

await _client.from('password_reset_tokens').insert({
    'email': email,
    'token': token,
    'expires_at': expiresAt,
  });

  // TODO: send token via email (SMTP / Edge Function)
  print("Token sent to $email: $token"); // placeholder

  }


  }