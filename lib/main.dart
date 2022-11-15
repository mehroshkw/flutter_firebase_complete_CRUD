import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharedpref/sharedpref/home.dart';
import 'package:sharedpref/sharedpref/signup.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var emails = prefs.getString("email");

  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    // home: AddData()
    // home: ImageHome(),
    // home: Maps(),
    // home: SignUpScreen(),
    // home: MyPhone(),
     home: emails == null ? SignUpScreen() : HomePage(),
    // home: Contacts(),
  ));
}

