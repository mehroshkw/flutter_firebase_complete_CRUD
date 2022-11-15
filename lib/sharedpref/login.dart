import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sharedpref/sharedpref/forgot_password.dart';
import 'package:sharedpref/sharedpref/home.dart';
import 'package:sharedpref/sharedpref/reusable_button.dart';
import 'package:sharedpref/sharedpref/reusable_field.dart';
import 'package:sharedpref/sharedpref/signup.dart';
import 'auth_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthController authController = AuthController();
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            ReusableTextField(
              labelText: 'Phone/Email',
              controller: authController.emailController,
            ),
            SizedBox(
              height: 20,
            ),
            ReusableTextField(
              labelText: 'Password',
              controller: authController.passwordController,
            ),
            SizedBox(
              height: 20,
            ),

            // custom button and converting into  component
            ReusablePrimaryButton(
              onTap: () {
                authController.loginUser();
              },
              buttonText: 'Login',
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Dont have any account?'),
                TextButton(
                  onPressed: () {
                    Get.to(SignUpScreen());
                  },
                  child: Text('Sign Up'),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Forgot Password?'),
                TextButton(
                  onPressed: () {
                    Get.to(ForgotPass());
                  },
                  child: Text('Reset Password'),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            // TextButton(
            //   onPressed: () {
            //     authController.signInWithGoogle();
            //   },
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       Text('Login with Google'),
            //       SizedBox(
            //         width: 10,
            //       ),
            //       Image.network(
            //         "https://image.similarpng.com/very-thumbnail/2020/12/Flat-design-Google-logo-design-Vector-PNG.png",
            //         width: 20,
            //         height: 20,
            //       ),
            //     ],
            //   ),
            // ),
            // TextButton(
            //   onPressed: () {
            //     // authController.signInWithFacebook();
            //   },
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       Text('Login with Facebook'),
            //       SizedBox(
            //         width: 10,
            //       ),
            //       Image.network(
            //         "https://png.pngtree.com/element_our/png_detail/20181011/facebook-social-media-icon-design-template-vector-png_127003.png",
            //         width: 40,
            //         height: 40,
            //       ),
            //     ],
            //   ),
            // ),
          
          ],
        ),
      )),
    );
  }
}
