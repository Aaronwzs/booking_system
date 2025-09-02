import 'dart:ui';

import 'package:booking_system/modules/auth/model/profilemodel.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileRepo extends GetxController{
static ProfileRepo get instance => Get.put(ProfileRepo()); //singleton instance


final _client = Supabase.instance.client;


Future<void> createProfile(Map<String, dynamic> data)
async {
try{
     await _client.from('profiles').insert(data);

}on PostgrestException catch (e) {
      Get.snackbar('PostgrestException Error', e.message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color.fromARGB(255, 255, 204, 204),
          colorText: const Color.fromARGB(255, 255, 0, 0));
    } catch (e) {
      Get.snackbar('System Error', e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: const Color.fromARGB(255, 255, 204, 204),
          colorText: const Color.fromARGB(255, 255, 0, 0));
    }

}

Future<ProfileModel?> getProfile(String authUserId) async {
  final data = await _client
      .from('profiles')
      .select()
      .eq('auth_user_id', authUserId)
      .single();

  return ProfileModel.fromMap(data);
}

Future<bool> updateProfile(String authUserId, Map<String, dynamic> updatedData) async {
    final response = await _client
        .from('profiles')
        .update(updatedData)
        .eq('auth_user_id', authUserId)
        .select();

  return response.isNotEmpty;
  }

 }