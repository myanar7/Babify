import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  File? image;

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);

      if (image == null) return;

      final imageTemp = File(image.path);

      setState((() => this.image = imageTemp));
    } on PlatformException catch (e) {
      print("ERROOOOOR ON IMAGE PICK");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            MaterialButton(
              onPressed: (() => pickImage()),
              child: const Text("Open Camera"),
            ),
            const SizedBox(
              height: 20,
            ),
            image != null ? Image.file(image!) : const Text("No Image")
          ],
        ),
      ),
    );
  }
}
