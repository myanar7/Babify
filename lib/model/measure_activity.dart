


import 'package:flutter_application_1/model/timer_activity.dart';

class MeasureActivity extends Activity{
  String height;
  String weight;
  String head;

  MeasureActivity(String id, DateTime startTime,  this.height, this.weight,this.head, String note):super(id:id, startTime: startTime, note: note){

  } 

 

}