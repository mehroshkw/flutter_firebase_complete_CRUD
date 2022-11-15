import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sharedpref/firebase_crud/create.dart';
import 'package:sharedpref/firebase_crud/read.dart';
import 'package:sharedpref/images_mehrosh/add_img.dart';
import 'package:sharedpref/sharedpref/login.dart';
import 'package:sharedpref/sharedpref/reusable_button.dart';
import 'auth_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthController authController = AuthController();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('HomePage'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 50,
            child: TextButton(
              child: Text("Create"),
              onPressed: () {
                Get.to(Create());
              },
            ),
          ),
          SizedBox(
            height: 50,
            child: TextButton(
              child: Text("Read"),
              onPressed: () {
                Get.to(Read());
              },
            ),
          ),
          SizedBox(
            height: 50,
            child: TextButton(
              child: Text("Add Image"),
              onPressed: () {
                Get.to(AddImg());
              },
            ),
          ),
          Center(
            child: ReusablePrimaryButton(
              buttonText: 'Logout',
              onTap: () {
                authController.logoutUser();
// ========for loggin out from google account=======
                // GoogleSignIn().signOut().whenComplete(() {
                //   print("logout");
                //   Get.off(LoginScreen);
                // });
              },
            ),
          ),
        ],
      ),
    );
  }
}
