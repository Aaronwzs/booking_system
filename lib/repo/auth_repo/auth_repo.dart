  import 'dart:convert';
import 'dart:ui';

  import 'package:booking_system/modules/auth/model/profilemodel.dart';
import 'package:booking_system/modules/auth/model/userauthmodel.dart';
import 'package:booking_system/repo/auth_repo/profile_repo.dart';
import 'package:flutter/foundation.dart';
  import 'package:get/get.dart';
import 'package:http/http.dart' as http;
  import 'package:supabase_flutter/supabase_flutter.dart';

  class AuthRepo extends GetxController{

  static AuthRepo get instance => Get.put(AuthRepo()); //singleton instance

  //variables
  final supabaseAuth = Supabase.instance.client.auth;
  final _client = Supabase.instance.client;
  late Rx<User?> _user; //Reactive user variable
  var verificationId =''.obs; // Observable variable to hold the verification ID for phone authentication


//Fix variables for api 
static const String supabaseProjectRef = 'haejqygbvesegirzngix';
  static const String supabaseBaseUrl = 'https://$supabaseProjectRef.supabase.co';
final String supabaseAnonKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImhhZWpxeWdidmVzZWdpcnpuZ2l4Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTYyMDU2NjksImV4cCI6MjA3MTc4MTY2OX0.GxAxgGZzW-Rn7qRJ8BCVIJPmSgoORiliHZSl86NYw-g";
final String apiSecretKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImhhZWpxeWdidmVzZWdpcnpuZ2l4Iiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTc1NjIwNTY2OSwiZXhwIjoyMDcxNzgxNjY5fQ.EtXv8oE8hJm9kVP2KhSdb_D-Hw8w4mku4mqY_zhSG5k";
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


  // populate token table, send token via email (SMTP / Edge Function)
    Future<void> requestPasswordReset(String email) async {
    final token = DateTime.now().millisecondsSinceEpoch.toString().substring(7, 13); // simple 6 digit token
    final expiresAt = DateTime.now().add(const Duration(minutes: 15)).toIso8601String();

  await _client.from('password_reset_tokens').insert({
      'email': email,
      'prt_token': token,
      'expires_at': expiresAt,
    });

  // TODO: send token via email (SMTP / Edge Function)
  AuthRepo.instance.getUserByEmail(email).then((user) {
    if (user != null) {
      print("Password reset token for $email: $token");
    } else {
      print("No user found with email: $email");
    }
  });

  }

  Future<bool> verifyResetToken(String email, String token) async {

    final res = await _client 
    .from('password_reset_tokens')
    .select()
    .eq('email', email)
    .eq('prt_token', token)
    .eq('used',false)
    .single();
    
    if (kDebugMode) {
      print(res);
    }

  final expiresAt = DateTime.parse(res['expires_at']);
    if (DateTime.now().isAfter(expiresAt)) {
    return false;
  }
  return true; // valid token
  }
  

  Future<String?> updatePasswordEdge(AuthUserModel user) async {
  final url = '$supabaseBaseUrl/auth/v1/update-user'; 
 final response = await http.post(
    Uri.parse(url),
    headers: {
      'Content-Type': 'application/json',
      'apikey': supabaseAnonKey, // public anon key
    },
    body: jsonEncode(user.toMap()),
  );

  return response.statusCode == 200 ? null : "Failed to update user";
  }
  
  Future<Map<String, dynamic>?> getUserByEmail(String email) async {
 
  final url = '$supabaseBaseUrl/functions/v1/get-user-by-email'; 

  final response = await http.post(
    Uri.parse(url),
    headers: {
      'Content-Type': 'application/json',
      'apikey': supabaseAnonKey, // public anon key
    },
    body: jsonEncode({'email': email}),
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body) as Map<String, dynamic>;
  } else {
    print("Error: ${response.body}");
    return null;
  }
}

Future<void> updatePassword(String newPassword) async {
    final user = supabaseAuth.currentUser;
    if (user != null) {
      await supabaseAuth.updateUser(UserAttributes(password: newPassword));
    } else {
      throw Exception("No authenticated user found");
    }
  }

  Future<void> resetPassword(String email) async {
    await supabaseAuth.resetPasswordForEmail(email);
  }

  Future<void> markTokenAsUsed(String token) async {
  await await _client 
    .from('password_reset_tokens')
    .update({'used': true})
    .eq('token', token);
  }

  }

   