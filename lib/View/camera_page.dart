import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/providers/all_providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class CameraPage extends ConsumerStatefulWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  ConsumerState<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends ConsumerState<CameraPage> {
  File? image;
  DateTime selectedDate = DateTime.now();
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

  Future pickImageOnGallery() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return;

      final imageTemp = File(image.path);

      setState((() => this.image = imageTemp));
    } on PlatformException catch (e) {
      print("ERROOOOOR ON IMAGE PICK");
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        colors: [Color.fromARGB(255, 21, 35, 43), Color(0xffffc107)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      )),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(backgroundColor: Colors.transparent),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MaterialButton(
                    color: Colors.white,
                    onPressed: (() => pickImage()),
                    child: const Text("Open Camera"),
                  ),
                  MaterialButton(
                    color: Colors.white,
                    onPressed: (() => pickImageOnGallery()),
                    child: const Text("Open Gallery"),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              image != null
                  ? SizedBox(
                      height: size.height / 2,
                      width: size.height / 3,
                      child: Image.file(image!, fit: BoxFit.fill),
                    )
                  : const Text(
                      "No Image",
                      style: TextStyle(color: Colors.white),
                    ),
              const SizedBox(
                height: 20,
              ),
              MaterialButton(
                color: Colors.white,
                onPressed: () => _selectDate(context),
                child: const Text('Select Photo Taken Date'),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                      onPressed: () {
                        if (image == null) return;
                        ref.read(photoAlbumProvider.notifier).addPhotoModel(
                            selectedDate,
                            DateFormat('dd/MM/yyyy').format(selectedDate),
                            image!);
                        Navigator.of(context).pop();
                      },
                      color: Colors.green,
                      iconSize: 50,
                      icon: const Icon(Icons.check)),
                  IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      color: Colors.red,
                      iconSize: 50,
                      icon: const Icon(Icons.close))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
