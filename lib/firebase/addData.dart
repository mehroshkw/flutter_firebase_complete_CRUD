import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sharedpref/firebase/showData.dart';

class AddData extends StatefulWidget {
  const AddData({super.key});

  @override
  State<AddData> createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {
  final formKey = GlobalKey<FormState>();
  TextEditingController nameC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController phoneC = TextEditingController();
  TextEditingController AboutC = TextEditingController();

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    Future<void> validate(
        String name, String email, String phone, String about) async {
      if (formKey.currentState!.validate()) {
        await firestore.collection("user").add({
          "name": name,
          "email": email,
          "phone": phone,
          "about": about
        }).whenComplete(
          () => Navigator.push(context, MaterialPageRoute(builder: (_) {
            return ShowData();
          })),
        );
        print("okay");
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Add Data"),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Text(
            "Add To Firebase",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 10,
          ),
          Form(
            key: formKey,
            child: Column(
              children: [
                Column(
                  children: [
                    Text("Enter Name"),
                    TextFormField(
                      validator: (v) {
                        if (nameC.text.length < 3) {
                          return "Enter name of minimum 3 characters";
                        }
                      },
                      controller: nameC,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text("Enter Email"),
                    TextFormField(
                      validator: (V) {
                        if (!emailC.text.contains("@gmail.com")) {
                          return "Email badly formatted";
                        }
                      },
                      controller: emailC,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text("Enter Phone Number"),
                    TextFormField(
                      validator: (v) {
                        if (phoneC.text.length < 11) {
                          return "Badly formatted";
                        }
                      },
                      controller: phoneC,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text("Enter About details"),
                    TextFormField(
                      validator: (v) {
                        if (AboutC.text.isEmpty) {
                          return "Should not be empty";
                        }
                      },
                      controller: AboutC,
                    ),
                  ],
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              validate(nameC.text, emailC.text, phoneC.text, AboutC.text);
            },
            child: Text("Add Data"),
          ),
        ],
      ),
    );
  }
}
