import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sharedpref/otpLogin/auth_otp.dart';

class OTP extends StatefulWidget {
  const OTP({super.key});

  @override
  State<OTP> createState() => _OTPState();
}

class _OTPState extends State<OTP> {
  TextEditingController phone = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: phone,
            ),
            ElevatedButton(
              onPressed: () {
                if (phone != null) {
                  final phonenumber = ("+92" + phone.text);
                  AuthProvider().LogInWithPhone(context, phonenumber);
                }
              },
              child: Text("LOGIN"),
            ),
          ],
        ),
      ),
    );
  }
}
