import 'dart:convert';

import 'package:flutter_application_1/model/bath_activity.dart';
import 'package:flutter_application_1/model/bottlemilk_activity.dart';
import 'package:flutter_application_1/model/breastfeeding_activity.dart';
import 'package:flutter_application_1/model/diaper_activity.dart';
import 'package:flutter_application_1/model/measure_activity.dart';
import 'package:flutter_application_1/model/medication_activity.dart';
import 'package:flutter_application_1/model/pumping_activity.dart';
import 'package:flutter_application_1/model/sleep_activity.dart';
import 'package:flutter_application_1/model/timer_activity.dart';
import 'package:flutter_application_1/model/tummy_activity.dart';
import 'package:flutter_application_1/model/vaccination_activity.dart';
import 'package:flutter_application_1/model/walk_activity.dart';
import 'package:flutter_application_1/providers/all_providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;

enum TimerActivityType {
  sleepActivity,
  tummyActivity,
  breastFeedingActivity,
  bathActivity,
  walkActivity,
  pumpingActivity,
  diaperActivity,
  bottleMilkActivity,
  measureActivity,
  medicationActivity,
  vaccinationActivity
}

extension ParseToString on TimerActivityType {
  String toStringType() {
    return toString().split('.').last;
  }
}

class ApiController<T> {
  static Future<void> postTimerActivity(
      WidgetRef ref, dynamic timerActivity, TimerActivityType type) async {
    String body = "";
    String path = "";
    switch (type) {
      case TimerActivityType.sleepActivity:
        if (timerActivity is! SleepActivity) break;
        SleepActivity sleepActivity = timerActivity;
        body = jsonEncode(<String, dynamic>{
          'startTime': sleepActivity.startTime.toString(),

          /// BUNLAR GİBİ OLACAK HEPSİ
          'finishTime': sleepActivity.finishTime.toString(),
          'seconds': sleepActivity.second,
          'note': sleepActivity.note,
          'type': type.toStringType(),
        });
        path = "sleep";
        break;
      case TimerActivityType.tummyActivity:
        if (timerActivity is! TummyActivity) break;
        TummyActivity tummyActivity = timerActivity;
        body = jsonEncode(<String, dynamic>{
          'startTime': tummyActivity.startTime.toString(),
          'finishTime': tummyActivity.finishTime.toString(),
          'seconds': tummyActivity.second,
          'note': tummyActivity.note,
          'type': type.toStringType(),
        });
        path = "tummy";
        break;
      case TimerActivityType.breastFeedingActivity:
        if (timerActivity is! BreastFeedingActivity) break;
        BreastFeedingActivity breastFeedingActivity = timerActivity;
        body = jsonEncode(<String, dynamic>{
          'startTime': breastFeedingActivity.startTime.toString(),
          'finishTime': breastFeedingActivity.finishTime.toString(),
          'seconds': breastFeedingActivity.second,
          'note': breastFeedingActivity.note,
          'type': type.toStringType(),
        });
        path = "breast-feeding";
        break;
      case TimerActivityType.bathActivity:
        if (timerActivity is! BathActivity) break;
        BathActivity bathActivity = timerActivity;
        body = jsonEncode(<String, dynamic>{
          'startTime': bathActivity.startTime.toString(),
          'finishTime': bathActivity.finishTime.toString(),
          'seconds': bathActivity.second,
          'note': bathActivity.note,
          'type': type.toStringType(),
        });
        path = "bath";
        break;
      case TimerActivityType.walkActivity:
        if (timerActivity is! WalkActivity) break;
        WalkActivity walkActivity = timerActivity;
        body = jsonEncode(<String, dynamic>{
          'startTime': walkActivity.startTime.toString(),
          'finishTime': walkActivity.finishTime.toString(),
          'seconds': walkActivity.second,
          'note': walkActivity.note,
          'type': type.toStringType(),
        });
        path = "walk";
        break;
      case TimerActivityType.pumpingActivity:
        if (timerActivity is! PumpingActivity) break;
        PumpingActivity pumpingActivity = timerActivity;
        body = jsonEncode(<String, dynamic>{
          'startTime': pumpingActivity.startTime.toString(),
          'pumpingType': pumpingActivity.type,
          'amount': pumpingActivity.amount,
          'note': pumpingActivity.note,
          'type': type.toStringType(),
        });
        path = "pumping";
        break;
      case TimerActivityType.diaperActivity:
        if (timerActivity is! DiaperActivity) break;
        DiaperActivity diaperActivity = timerActivity;
        body = jsonEncode(<String, dynamic>{
          'startTime': diaperActivity.startTime.toString(),
          'diaperType': diaperActivity.type,
          'note': diaperActivity.note,
          'type': type.toStringType(),
        });
        path = "diaper";
        break;
      case TimerActivityType.bottleMilkActivity:
        if (timerActivity is! BottleMilkActivity) break;
        BottleMilkActivity bottleMilkActivity = timerActivity;
        body = jsonEncode(<String, dynamic>{
          'startTime': bottleMilkActivity.startTime.toString(),
          'bottleMilkType': bottleMilkActivity.type,
          'amount': bottleMilkActivity.amount,
          'note': bottleMilkActivity.note,
          'type': type.toStringType(),
        });
        path = "bottle-milk";
        break;
      case TimerActivityType.measureActivity:
        if (timerActivity is! MeasureActivity) break;
        MeasureActivity measureActivity = timerActivity;
        body = jsonEncode(<String, dynamic>{
          'startTime': timerActivity.startTime.toString(),
          'weight': timerActivity.weight,
          'height': timerActivity.height,
          'head': timerActivity.head,
          'note': timerActivity.note,
          'type': type.toStringType(),
        });
        path = "measure";
        break;
      case TimerActivityType.medicationActivity:
        if (timerActivity is! MedicationActivity) break;
        MedicationActivity medicationActivity = timerActivity;
        body = jsonEncode(<String, dynamic>{
          'startTime': medicationActivity.startTime.toString(),
          'name': medicationActivity.name,
          'dose': medicationActivity.dose,
          'note': medicationActivity.note,
          'type': type.toStringType(),
        });
        path = "medication";
        break;
      case TimerActivityType.vaccinationActivity:
        if (timerActivity is! VaccinationActivity) break;
        VaccinationActivity vaccinationActivity = timerActivity;
        body = jsonEncode(<String, dynamic>{
          'startTime': vaccinationActivity.startTime.toString(),
          'name': vaccinationActivity.name,
          'note': vaccinationActivity.note,
          'type': type.toStringType(),
        });
        path = "vaccination";
        break;
      default:
        body = "1";
    }
    final response = await http.post(
      Uri.parse('http://dadash3-001-site1.etempurl.com/api/Activity/$path'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: body,
    );

    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      print(response.body);
      timerActivity.id = response.body;
      ref.read(timerActivityProvider.notifier).addActivity(timerActivity);
      return;
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  }

  static Future<List<Activity>> fetchTimerActivity() async {
    final response = await http
        .get(Uri.parse('http://dadash3-001-site1.etempurl.com/api/Activity'));
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      print(response.body);
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Activity.fromJson(data)).toList();
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  }
}
