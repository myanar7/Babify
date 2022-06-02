import 'package:flutter_application_1/model/timer_activity.dart';

class PumpingActivity extends Activity{
  String type;
  String amount;  
  PumpingActivity(String id, DateTime startTime,  this.type, this.amount,  String note):super(id:id, startTime: startTime, note: note){

  } 

 

}