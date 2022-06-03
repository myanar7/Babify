import 'package:flutter_application_1/model/timer_activity.dart';

class BottleMilkActivity extends Activity{
  String type;
  String amount;  
  BottleMilkActivity(String id, DateTime startTime,  this.type, this.amount,  String note):super(id:id, startTime: startTime, note: note){

  } 

 

}