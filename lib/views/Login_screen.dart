import 'package:firebase_auth_getx_mvc/controller/controller.dart';
import 'package:firebase_auth_getx_mvc/views/home_screen.dart';
import 'package:firebase_auth_getx_mvc/views/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final AuthController controller = Get.put(AuthController());
final ThemeController themeController = Get.put(ThemeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          spacing: 20,
          children: [
            ListTile(
              title: Text('Change theme'),
              trailing: Obx((){
                return IconButton(
                  onPressed: () {
                    themeController.isLightMode.value = !themeController.isLightMode.value;
                    Get.changeTheme(
                      themeController.isLightMode.value ? ThemeData.light() : ThemeData.dark(),
                    );
                  },
                  icon: themeController.isLightMode.value
                      ? Icon(Icons.light_mode)
                      : Icon(Icons.dark_mode),
                );
  }),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'email'),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'password'),
            ),
            Obx(() {
              return controller.isLoading.value
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.withOpacity(0.5),
                        foregroundColor: Colors.grey,
                        minimumSize: Size(MediaQuery.widthOf(context), 40),
                      ),
                      onPressed: () {
                        controller.loginUser(
                          emailController.text,
                          passwordController.text,
                        );

                      },
                      child: Text(
                        'Login',
                        style: TextStyle(color: Colors.black),
                      ),
                    );
            }),

            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Colors.grey,
                backgroundColor: Colors.grey.withOpacity(0.5),
              ),
              onPressed: () {
                // 2ono tareqay hai navigate ky liay
                // Get.to(RegisterScreen());
                Get.to(() => RegisterScreen());
              },
              child: Text(
                "Create account",
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
