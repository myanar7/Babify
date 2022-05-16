import 'package:flutter_application_1/model/timer_activity.dart';
import 'package:uuid/uuid.dart';

class SleepActivity extends TimerActivity{
  String id;
  DateTime startTime;
  DateTime finishTime;
  int second;
  String note;

  SleepActivity({required this.id, required this.startTime, required this.finishTime, required this.second, required this.note });

 

}