import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../model/sleep_activity.dart';

class SleepActivityManager extends StateNotifier<List<SleepActivity>>{
  SleepActivityManager(List<SleepActivity> state) : super(state);


  void addActivity(DateTime startTime, DateTime finishTime, int second, String note){
    var newSleepActivity = SleepActivity(id: const Uuid().v4(), startTime: startTime, finishTime: finishTime, second: second, note: note);
    state = [...state, newSleepActivity];
  }

  void remove(SleepActivity sleepActivity) {
    state = state.where((element) => element.id != sleepActivity.id).toList();
  }

   
}