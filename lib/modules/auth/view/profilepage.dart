import 'package:booking_system/modules/auth/controller/profilecontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        actions: [
          Obx(() => IconButton(
                icon: Icon(
                  controller.isEditing.value ? Icons.close : Icons.edit,
                ),
                onPressed: () {
                  controller.toggleEditing();
                },
              )),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildField(
                label: "Full Name",
                controller: controller.fullNameController,
                enabled: controller.isEditing.value,
              ),
              const SizedBox(height: 10),
              _buildField(
                label: "Age",
                controller: controller.ageController,
                enabled: controller.isEditing.value,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 10),
              _buildField(
                label: "Phone",
                controller: controller.phoneController,
                enabled: controller.isEditing.value,
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 20),
              if (controller.isEditing.value)
                ElevatedButton(
                  onPressed: () async {
                    await controller.updateProfile();

                    // Show confirmation modal
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text("Profile Updated"),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Full Name: ${controller.fullNameController.text}"),
                            Text("Age: ${controller.ageController.text}"),
                            Text("Phone: ${controller.phoneController.text}"),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(ctx).pop();
                              controller.toggleEditing(); // Exit edit mode
                            },
                            child: const Text("OK"),
                          ),
                        ],
                      ),
                    );
                  },
                  child: const Text("Save Changes"),
                )
            ],
          ),
        );
      }),
    );
  }

  /// Helper Widget for Text Fields
  Widget _buildField({
    required String label,
    required TextEditingController controller,
    bool enabled = false,
    TextInputType? keyboardType,
  }) {
    return TextFormField(
      controller: controller,
      enabled: enabled,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        filled: !enabled,
        fillColor: enabled ? null : Colors.grey.shade200,
      ),
    );
  }
}
