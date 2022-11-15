import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:share/share.dart';

class PreviewImage extends StatefulWidget {
  String? image;
  PreviewImage({this.image});

  @override
  State<PreviewImage> createState() => _PreviewImageState();
}

class _PreviewImageState extends State<PreviewImage> {
  Future<void> shareImage() async {
    String url = widget.image.toString();
    final response = await http.get(Uri.parse(url));
    final directory = await getApplicationDocumentsDirectory();
    String date = DateTime.now().millisecondsSinceEpoch.toString();
    final imagePath = await File("${directory.path}/image$date.png").create();
    await imagePath.writeAsBytes(response.bodyBytes);
    Share.shareFiles([imagePath.path]);
  }

  saveImage() async {
    String url = widget.image.toString();
    final direc = await getTemporaryDirectory();
    final path = "${direc.path}/image.png";
    await Dio().downloadUri(Uri.parse(url), path);
    GallerySaver.saveImage(path).whenComplete(() => print("saved image"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Image.network(widget.image.toString()),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              shareImage();
            },
            child: Text("Share"),
          ),
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              saveImage();
            },
            child: Text("Save"),
          ),
        ],
      ),
    );
  }
}
