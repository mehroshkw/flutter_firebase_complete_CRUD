import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart' as Path;
import 'package:sharedpref/image/showImages.dart';

class UploadImages extends StatefulWidget {
  const UploadImages({super.key});

  @override
  State<UploadImages> createState() => _UploadImagesState();
}

class _UploadImagesState extends State<UploadImages> {
  @override
  void initState() {
    imageRef = FirebaseFirestore.instance.collection("imageUrls");
    super.initState();
  }

  CollectionReference? imageRef;
  firebase_storage.Reference? ref;
  final ImagePicker _picker = ImagePicker();
  List<File>? imageFileList;
  pickMultiImages() async {
    List<XFile>? selectImages = await _picker.pickMultiImage();
    setState(() {
      imageFileList =
          selectImages!.map<File>((xfile) => File(xfile.path)).toList();
      print(imageFileList);
    });
  }

  Future storeImages() async {
    for (var img in imageFileList!) {
      ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child("images/${Path.basename(img.path)}");
      await ref!.putFile(img).whenComplete(() async {
        await ref!.getDownloadURL().then((value) async {
          await imageRef!.add({"url": value}).whenComplete(
              () => Navigator.push(context, MaterialPageRoute(builder: (_) {
                    return ShowImages();
                  })));
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              pickMultiImages();
            },
            child: Text("Pick Images"),
          ),
          ElevatedButton(
            onPressed: () {
              storeImages();
            },
            child: Text("upload Images"),
          ),
          TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return ShowImages();
                }));
              },
              child: Text("Show images screen"))
        ],
      ),
    );
  }
}
