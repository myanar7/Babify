import 'package:flutter_application_1/model/timer_activity.dart';
import 'package:uuid/uuid.dart';

class TummyActivity extends TimerActivity {
  String id;
  DateTime startTime;
  DateTime finishTime;
  int second;
  String note;

  TummyActivity(
      {required this.id,
      required this.startTime,
      required this.finishTime,
      required this.second,
      required this.note});
}
