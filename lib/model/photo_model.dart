import 'dart:io';
import 'package:uuid/uuid.dart';

class PhotoModel {
  String id;
  DateTime photoTakenDate;
  String title;
  File image;

  PhotoModel(
      {required this.id,
      required this.photoTakenDate,
      required this.title,
      required this.image});

  factory PhotoModel.create(
      {required photoTakenDate, required title, required image}) {
    return PhotoModel(
        id: const Uuid().v4(),
        photoTakenDate: photoTakenDate,
        title: title,
        image: image);
  }
}
