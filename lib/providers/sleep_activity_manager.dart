import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../model/sleep_activity.dart';

class SleepActivityManager extends StateNotifier<List<SleepActivity>>{
  SleepActivityManager(List<SleepActivity> state) : super(state);


  void addSleepActivity(DateTime startTime, DateTime finishTime, int second){
    var newSleepActivity = SleepActivity(id: const Uuid().v4(), startTime: startTime, finishTime: finishTime, second: second);
    state = [...state, newSleepActivity];
  }
}