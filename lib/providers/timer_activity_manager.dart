import 'package:flutter_application_1/model/bottlemilk_activity.dart';
import 'package:flutter_application_1/model/sleep_activity.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../model/bath_activity.dart';
import '../model/breastfeeding_activity.dart';
import '../model/timer_activity.dart';
import '../model/tummy_activity.dart';
import '../model/walk_activity.dart';

class TimerActivityManager extends StateNotifier<List<Activity>> {
  TimerActivityManager(List<Activity> state) : super(state);

  void addAllActivities(List<Activity> timerActivities) {
    state.addAll(timerActivities);
  }

  void addActivity(Activity timerActivity) {
    state = [...state, timerActivity];
  }

  void remove(Activity timerActivity) {
    state = state.where((element) => element.id != timerActivity.id).toList();
  }

  void edit(String id, int second, DateTime startTime, DateTime finishTime,
      String note) {
    late Activity timerActivity;
    for (int i = 0; i < state.length; i++) {
      if (state[i].id == id) {
        if (state[i] is SleepActivity) {
          timerActivity =
              SleepActivity(id, startTime, finishTime, second, note);
        } else if (state[i] is TummyActivity) {
          timerActivity =
              TummyActivity(id, startTime, finishTime, second, note);
        } else if (state[i] is WalkActivity) {
          timerActivity =
              TummyActivity(id, startTime, finishTime, second, note);
        } else if (state[i] is BathActivity) {
          timerActivity =
              TummyActivity(id, startTime, finishTime, second, note);
        } else if (state[i] is BreastFeedingActivity) {
          timerActivity =
              TummyActivity(id, startTime, finishTime, second, note);
        }

        remove(state[i]);
        addActivity(timerActivity);
        break;
      }
    }
  }
}
