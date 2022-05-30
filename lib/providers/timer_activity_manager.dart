import 'package:flutter_application_1/model/sleep_activity.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../model/timer_activity.dart';
import '../model/tummy_activity.dart';

class TimerActivityManager extends StateNotifier<List<TimerActivity>> {
  TimerActivityManager(List<TimerActivity> state) : super(state);

  void addAllActivities(List<TimerActivity> timerActivities) {
    state.addAll(timerActivities);
  }

  void addActivity(TimerActivity timerActivity) {
    state = [...state, timerActivity];
  }

  void remove(TimerActivity timerActivity) {
    state = state.where((element) => element.id != timerActivity.id).toList();
  }

  void edit(String id, int second, DateTime startTime, DateTime finishTime,
      String note) {
    late TimerActivity timerActivity;
    for (int i = 0; i < state.length; i++) {
      if (state[i].id == id) {
        if (state[i] is SleepActivity) {
          timerActivity = SleepActivity(
              id: id,
              startTime: startTime,
              finishTime: finishTime,
              second: second,
              note: note);
        } else {
          timerActivity = TummyActivity(
              id: id,
              startTime: startTime,
              finishTime: finishTime,
              second: second,
              note: note);
        }
        remove(state[i]);
        addActivity(timerActivity);
        break;
      }
    }
  }
}
