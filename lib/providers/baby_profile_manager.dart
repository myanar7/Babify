import 'package:flutter_application_1/services/api_controller.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../model/baby.dart';

class BabyProfileManager extends StateNotifier<List<Baby>> {
  BabyProfileManager(List<Baby> state) : super(state);

  void addBabyProfile(Baby baby) {
    var newBabyProfile = Baby(
        id: baby.id,
        photoPath: baby.photoPath,
        name: baby.name,
        birthday: baby.birthday,
        height: baby.height,
        weight: baby.weight);
    state = [...state, newBabyProfile];
  }

  void addAllBabyProfiles(List<Baby> babies) {
    state.addAll(babies);
  }

  void removeBabyProfile(String id) {
    state = state.where((element) => element.id != id).toList();
  }

  void changeBabyProfile(int index) {
    Baby.currentIndex = index;
  }
}
