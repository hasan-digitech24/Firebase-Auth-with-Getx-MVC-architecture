import 'package:firebase_auth_getx_mvc/controller/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatelessWidget {
   RegisterScreen({super.key});

   final emailController = TextEditingController();
  final passwordController = TextEditingController();

   final AuthController controller = Get.put(AuthController());

  @override
   Widget build(BuildContext context) {
    return Scaffold(
body: Padding(
  padding: const EdgeInsets.all(8.0),
  child: Column(
    spacing: 20,
    children: [
      TextField(
          controller: emailController,
        decoration: InputDecoration(
          labelText: 'email'
        ),
      ),
       TextField(
        controller: passwordController,
        decoration: InputDecoration(
          labelText: 'password'
        ),
      ),
     Obx((){
        return controller.isLoading.value ? CircularProgressIndicator()
:  ElevatedButton(style: ElevatedButton.styleFrom(
        // backgroundColor: Colors.grey,
        foregroundColor: Colors.grey,
        minimumSize: Size(MediaQuery.widthOf(context), 40)
      ),onPressed: (){
        controller.registerUser(emailController.text, passwordController.text);
      }, child: Text('Register',style: TextStyle(color: Colors.black),));
      })

    ],
  ),
),
    );
  }
}
