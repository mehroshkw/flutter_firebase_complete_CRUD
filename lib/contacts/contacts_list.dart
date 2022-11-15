import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_contacts/flutter_contacts.dart';

class Contacts extends StatefulWidget {
  const Contacts({super.key});

  @override
  State<Contacts> createState() => _ContactsState();
}

class _ContactsState extends State<Contacts> {
  List<String>? nameList;
  List<dynamic>? contactList;

  @override
  void initState() {
    getContacts();
    super.initState();
  }

  List<Contact>? contacts;

  Future<void>? addContacts(List<dynamic> number, List<dynamic> name) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    firestore.collection("contacts").add(
        {"name": name, "number": number}).whenComplete(() => print("added"));
  }

  getContacts() async {
    if (await FlutterContacts.requestPermission()) {
      contacts = await FlutterContacts.getContacts(
          withAccounts: true,
          withGroups: true,
          withProperties: true,
          withThumbnail: true,
          withPhoto: true);
      print(contacts);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            nameList = contacts!.map<String>((e) => e.displayName).toList();
            contactList = contacts!
                .map<dynamic>((e) => e.phones.map((e) => e.number))
                .toList();
            addContacts(contactList!.map<String>((e) => e.toString()).toList(),
                nameList!.map<String>((e) => e.toString()).toList());
          },
          child: Text("DONE"),
        ),
      ),
    );
  }
}
