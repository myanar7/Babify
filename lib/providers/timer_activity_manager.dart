import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../model/timer_activity.dart';



class TimerActivityManager extends StateNotifier<List<TimerActivity>>{
  TimerActivityManager(List<TimerActivity> state) : super(state);


  void addActivity(TimerActivity timerActivity){
    state = [...state, timerActivity];
  }

  void remove(TimerActivity timerActivity) {
    state = state.where((element) => element.id != timerActivity.id).toList();
  }

   
}