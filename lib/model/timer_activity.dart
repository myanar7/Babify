import 'package:flutter_application_1/model/sleep_activity.dart';
import 'package:flutter_application_1/model/tummy_activity.dart';

 class Activity{
  late String id;
  late DateTime startTime;
  late  String note;

  Activity({required this.id,required this.startTime,required this.note});
  
  /*
  TimerActivity();

  factory TimerActivity.fromJson(Map<String, dynamic> json) {
    final String type = json['type'];
    if (type == "sleep") {
      return SleepActivity(
          id: json['id'].toString(),
          startTime: DateTime.parse(json['startTime']),
          finishTime: DateTime.parse(json['finishTime']),
          second: json['seconds'],
          note: json['note']);
    } else {
      // buna else if denecek
      return TummyActivity(
          id: json['id'].toString(),
          startTime: DateTime.parse(json['startTime']),
          finishTime: DateTime.parse(json['finishTime']),
          second: json['seconds'],
          note: json['note']);
    }
  }
}
  */
}
