import 'package:uuid/uuid.dart';

class SleepActivity{
  String id;
  DateTime startTime;
  DateTime finishTime;
  int second;
  String note;

  SleepActivity({required this.id, required this.startTime, required this.finishTime, required this.second, required this.note });

  factory SleepActivity.create({required startTime, required finishTime, required second, required note}){
    return SleepActivity(id: const Uuid().v4(), startTime: startTime, finishTime: finishTime, second: second, note: note);
  }

}