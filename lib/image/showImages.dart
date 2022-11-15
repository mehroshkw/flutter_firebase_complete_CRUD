import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:sharedpref/image/previewfirebaseimage.dart';

class ShowImages extends StatefulWidget {
  const ShowImages({super.key});

  @override
  State<ShowImages> createState() => _ShowImagesState();
}

class _ShowImagesState extends State<ShowImages> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("imageUrls").snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (c, i) {
                return InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) {
                        return PreviewImage(
                          image: snapshot.data!.docs[i].get("url"),
                        );
                      }));
                    },
                    child: Image.network(snapshot.data!.docs[i].get("url")));
              },
            );
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
