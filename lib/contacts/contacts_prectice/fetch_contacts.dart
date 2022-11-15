import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class FetchContacts extends StatefulWidget {
  const FetchContacts({super.key});

  @override
  State<FetchContacts> createState() => _FetchContactsState();
}

class _FetchContactsState extends State<FetchContacts> {
  @override
  void initState() {
    getContacts();
    super.initState();
  }

  getContacts()async{
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
