import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/providers/all_providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class CameraPage extends ConsumerStatefulWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  ConsumerState<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends ConsumerState<CameraPage> {
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
      appBar: AppBar(),
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
            image != null
                ? SizedBox(
                    height: 100,
                    width: 50,
                    child: Image.file(image!, fit: BoxFit.fill),
                  )
                : const Text("No Image"),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                    onPressed: () {
                      if (image == null) return;
                      ref
                          .read(photoAlbumProvider.notifier)
                          .addPhotoModel(DateTime.now(), "Image Test", image!);
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.check)),
                IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.close))
              ],
            )
          ],
        ),
      ),
    );
  }
}
