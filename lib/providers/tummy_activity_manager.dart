import 'package:flutter/cupertino.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../model/tummy_activity.dart';



class TummyActivityManager extends StateNotifier<List<TummyActivity>>{
  TummyActivityManager(List<TummyActivity> state) : super(state);


  void addActivity(DateTime startTime, DateTime finishTime, int second, String note){
    var newSleepActivity = TummyActivity(id: const Uuid().v4(), startTime: startTime, finishTime: finishTime, second: second, note: note);
    state = [...state, newSleepActivity];
  }

  void remove(TummyActivity sleepActivity) {
    state = state.where((element) => element.id != sleepActivity.id).toList();
  }
}