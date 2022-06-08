import 'package:flutter_application_1/model/bath_activity.dart';
import 'package:flutter_application_1/model/bottlemilk_activity.dart';
import 'package:flutter_application_1/model/breastfeeding_activity.dart';
import 'package:flutter_application_1/model/diaper_activity.dart';
import 'package:flutter_application_1/model/measure_activity.dart';
import 'package:flutter_application_1/model/medication_activity.dart';
import 'package:flutter_application_1/model/pumping_activity.dart';
import 'package:flutter_application_1/model/sleep_activity.dart';
import 'package:flutter_application_1/model/tummy_activity.dart';
import 'package:flutter_application_1/model/vaccination_activity.dart';
import 'package:flutter_application_1/model/walk_activity.dart';
import 'package:flutter_application_1/services/api_controller.dart';

class Activity {
  late String id;
  late DateTime startTime;
  late String note;

  Activity({required this.id, required this.startTime, required this.note});

  factory Activity.fromJson(Map<String, dynamic> json) {
    String type = json['type'];
    if (type == TimerActivityType.sleepActivity.toStringType()) {
      return SleepActivity(
          json['activityId'].toString(),
          DateTime.parse(json['startTime']),
          DateTime.parse(json['finishTime']),
          json['seconds'],
          json['note']);
    } else if (type == TimerActivityType.tummyActivity.toStringType()) {
      return TummyActivity(
          json['activityId'].toString(),
          DateTime.parse(json['startTime']),
          DateTime.parse(json['finishTime']),
          json['seconds'],
          json['note']);
    } else if (type == TimerActivityType.bathActivity.toStringType()) {
      return BathActivity(
          json['activityId'].toString(),
          DateTime.parse(json['startTime']),
          DateTime.parse(json['finishTime']),
          json['seconds'],
          json['note']);
    } else if (type == TimerActivityType.bottleMilkActivity.toStringType()) {
      return BottleMilkActivity(
          json['activityId'].toString(),
          DateTime.parse(json['startTime']),
          json['bottleMilkType'],
          json['amount'],
          json['note']);
    } else if (type == TimerActivityType.breastFeedingActivity.toStringType()) {
      return BreastFeedingActivity(
          json['activityId'].toString(),
          DateTime.parse(json['startTime']),
          DateTime.parse(json['finishTime']),
          json['seconds'],
          json['note']);
    } else if (type == TimerActivityType.diaperActivity.toStringType()) {
      return DiaperActivity(json['activityId'].toString(),
          DateTime.parse(json['startTime']), json['diaperType'], json['note']);
    } else if (type == TimerActivityType.measureActivity.toStringType()) {
      return MeasureActivity(
          json['activityId'].toString(),
          DateTime.parse(json['startTime']),
          json['height'],
          json['weight'],
          json['head'],
          json['note']);
    } else if (type == TimerActivityType.medicationActivity.toStringType()) {
      return MedicationActivity(
          json['activityId'].toString(),
          DateTime.parse(json['startTime']),
          json['type'],
          json['dose'],
          json['name'],
          json['note']);
    } else if (type == TimerActivityType.pumpingActivity.toStringType()) {
      return PumpingActivity(
          json['activityId'].toString(),
          DateTime.parse(json['startTime']),
          json['pumpingType'],
          json['amount'],
          json['note']);
    } else if (type == TimerActivityType.vaccinationActivity.toStringType()) {
      return VaccinationActivity(
          json['activityId'].toString(),
          DateTime.parse(json['startTime']),
          json['vaccinationName'] ?? "",
          json['note']);
    } else if (type == TimerActivityType.walkActivity.toStringType()) {
      return WalkActivity(
          json['activityId'].toString(),
          DateTime.parse(json['startTime']),
          DateTime.parse(json['finishTime']),
          json['seconds'],
          json['note']);
    } else {
      return Activity(
          id: json['activityId'].toString(),
          startTime: DateTime.parse(json['startTime']),
          note: json['note']);
    }
  }

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
