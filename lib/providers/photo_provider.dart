import 'dart:io';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../model/photo_model.dart';

class PhotoProviderManager extends StateNotifier<List<PhotoModel>> {
  PhotoProviderManager(List<PhotoModel> state) : super(state);

  void addPhotoModel(DateTime photoTakenDate, String title, File image) {
    var newPhotoModel = PhotoModel(
        id: const Uuid().v4(),
        photoTakenDate: photoTakenDate,
        image: image,
        title: title);
    state = [...state, newPhotoModel];
  }

  void remove(PhotoModel photoModel) {
    state = state.where((element) => element.id != photoModel.id).toList();
  }
}
