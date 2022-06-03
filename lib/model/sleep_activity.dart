import 'package:flutter_application_1/model/timer_activity.dart';
import 'package:uuid/uuid.dart';

class SleepActivity extends Activity{

  DateTime finishTime;
  int second;
  

  SleepActivity(String id, DateTime startTime,  this.finishTime, this.second,  String note):super(id:id, startTime: startTime, note: note){

  } 

 

}