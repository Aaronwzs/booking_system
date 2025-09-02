import 'package:booking_system/modules/auth/model/profilemodel.dart';
import 'package:booking_system/repo/auth_repo/profile_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileController extends GetxController{

static ProfileController get instance => Get.find(); //singleton instance

final fullNameController = TextEditingController();
final phoneController = TextEditingController();
final ageController = TextEditingController();

var isLoading = false.obs;
var isEditing = false.obs;
ProfileModel? profile; //nullable profile variable

final _profileRepo = ProfileRepo();
final supabase = Supabase.instance.client;

@override
  void onInit() {
    super.onInit();
    fetchProfile();
  }
  
  Future<void> fetchProfile() async {
  isLoading.value = true;
  final authUserId = supabase.auth.currentUser?.id;

  if (authUserId != null) {
    profile = await _profileRepo.getProfile(authUserId); // Already ProfileModel
    if (profile != null) {
      fullNameController.text = profile!.fullName;
      ageController.text = profile!.age.toString();
      phoneController.text = profile!.phone.toString();
    }
  }

  isLoading.value = false;
}


  Future<void> updateProfile() async {
    final authUserId = supabase.auth.currentUser?.id;
    if (authUserId == null) return;

    final updatedData = {
      'full_name': fullNameController.text.trim(),
      'age': int.tryParse(ageController.text.trim()) ?? 0,
      'phone': int.tryParse(phoneController.text.trim()) ?? 0,
    };

    final success = await _profileRepo.updateProfile(authUserId, updatedData);
    if (success) {
      Get.snackbar("Success", "Profile updated successfully");
      fetchProfile();
    } else {
      Get.snackbar("Error", "Failed to update profile");
    }
  }


 // Toggle edit mode
  void toggleEditing() {
    isEditing.value = !isEditing.value;
  }
}