import 'package:uuid/uuid.dart';

class TummyActivity{
  String id;
  DateTime startTime;
  DateTime finishTime;
  int second;
  String note;

  TummyActivity({required this.id, required this.startTime, required this.finishTime, required this.second, required this.note });

  factory TummyActivity.create({required startTime, required finishTime, required second, required note}){
    return TummyActivity(id: const Uuid().v4(), startTime: startTime, finishTime: finishTime, second: second, note: note);
  }

}