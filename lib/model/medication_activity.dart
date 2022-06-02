


import 'package:flutter_application_1/model/timer_activity.dart';

class MedicationActivity extends Activity{
  String type;
  String dose;
  String name;  
  MedicationActivity(String id, DateTime startTime,  this.type, this.dose,this.name,  String note):super(id:id, startTime: startTime, note: note){

  } 

 

}