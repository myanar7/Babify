import 'package:flutter_application_1/model/timer_activity.dart';

class WalkActivity extends Activity{

  DateTime finishTime;
  int second;
  

  WalkActivity(String id, DateTime startTime,  this.finishTime, this.second,  String note):super(id:id, startTime: startTime, note: note){

  } 

 

}