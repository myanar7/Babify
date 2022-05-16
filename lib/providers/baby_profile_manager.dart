import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../model/baby.dart';

class BabyProfileManager extends StateNotifier<List<Baby>> {
  BabyProfileManager(List<Baby> state) : super(state);

  void addBabyProfile(Baby baby) {
    var newBabyProfile = Baby(
        id: const Uuid().v4(),
        photoPath: baby.photoPath,
        name: baby.name,
        birthday: baby.birthday,
        height: baby.height,
        weight: baby.weight);
    state = [...state, newBabyProfile];
  }

  void removeBabyProfile(Baby baby) {
    state = state.where((element) => element.id != baby.id).toList();
  }
}
