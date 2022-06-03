import 'package:flutter_application_1/model/timer_activity.dart';

class DiaperActivity extends Activity{
  String type;  
  DiaperActivity(String id, DateTime startTime,  this.type,String note):super(id:id, startTime: startTime, note: note){

  } 
}