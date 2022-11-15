import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sharedpref/sharedpref/home.dart';

class AuthProvider {
  Future<bool>? LogInWithPhone(BuildContext context, String phone) {
    FirebaseAuth _auth = FirebaseAuth.instance;
    TextEditingController otpc = TextEditingController();

    _auth.verifyPhoneNumber(
        phoneNumber: phone,
        verificationCompleted: (AuthCredential credential) async {
          UserCredential result = await _auth.signInWithCredential(credential);
          Navigator.pop(context);
          User? user = result.user;
          if (user != null) {
            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (_) {
              return HomePage();
            }), (route) => false);
          } else {
            print("eror");
          }
        },
        verificationFailed: (FirebaseAuthException e) {
          print("eror");
        },
        codeSent: (String? verificationcode, int? token) {
          showDialog(
              context: context,
              builder: (c) {
                return AlertDialog(
                  title: Text("Enter OTP"),
                  content: Column(
                    children: [
                      TextField(
                        controller: otpc,
                      ),
                    ],
                  ),
                  actions: [
                    ElevatedButton(
                        onPressed: () async {
                          final code = otpc.text;
                          AuthCredential credential =
                              PhoneAuthProvider.credential(
                                  verificationId: verificationcode.toString(),
                                  smsCode: code);
                          UserCredential result =
                              await _auth.signInWithCredential(credential);
                          User? user = result.user;
                          if (user != null) {
                            Navigator.pushAndRemoveUntil(context,
                                MaterialPageRoute(builder: (_) {
                              return HomePage();
                            }), (route) => false);

                            print("success");
                          } else {
                            print("eror");
                          }
                        },
                        child: Text("verify"))
                  ],
                );
              });
        },
        codeAutoRetrievalTimeout: (id) => {});
  }
}
