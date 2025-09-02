import 'package:booking_system/modules/auth/controller/logincontroller.dart';
import 'package:booking_system/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class HomePage extends StatelessWidget {
   HomePage({super.key});


final LoginController loginController = Get.put(LoginController()); // Initialize the controller

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: _buildDrawer(context), // Side navigation menu
      appBar: AppBar(
        title: const Text('Junior Shuttlers BA'),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle, size: 42),
            onPressed: () {
              // Navigate to profile page
               Get.toNamed(AppRoutes.profile);
              
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildBanner(),
          Expanded(
            child: Center(
              child: Text(
                'Welcome to the Homepage!',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Banner Section
  Widget _buildBanner() {
    return Container(
      height: 180,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blueAccent, Colors.lightBlue],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: const Center(
        child: Text(
          "Simple Banner",
          style: TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // Side Drawer Menu
  Drawer _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Menu',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
          leading: const Icon(Icons.shopping_bag),
          title: const Text('Products'),
          onTap: () {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Products Page")),
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.calendar_today),
          title: const Text('Calendar'),
          onTap: () {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Calendar Page")),
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.book),
          title: const Text('Bookings'),
          onTap: () {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Bookings Page")),
            );
          },
        ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Settings Page")),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () {
              Navigator.pop(context);
             loginController.logout();
            },
          ),
        ],
      ),
    );
  }
}
