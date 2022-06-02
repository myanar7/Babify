import 'dart:async';

import 'package:flutter_application_1/model/sleep_activity.dart';
import 'package:flutter_application_1/model/timer_activity.dart';
import 'package:uuid/uuid.dart';

class TummyActivity extends Activity{
  DateTime finishTime;
  int second;

  TummyActivity(String id, DateTime startTime, this.finishTime, this.second,  String note):
  super(id: id,startTime: startTime, note: note)  {
  }

}

