import 'dart:convert';

import 'package:flutter_application_1/model/sleep_activity.dart';
import 'package:flutter_application_1/model/timer_activity.dart';
import 'package:flutter_application_1/model/tummy_activity.dart';
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
        break;
      case TimerActivityType.breastFeedingActivity:
        body = jsonEncode(<String, dynamic>{
          'startTime': timerActivity.startTime.toString(),
          'finishTime': timerActivity.finishTime.toString(),
          'seconds': timerActivity.second,
          'note': timerActivity.note,
          'type': type.toStringType(),
        });
        break;
      case TimerActivityType.bathActivity:
        body = jsonEncode(<String, dynamic>{
          'startTime': timerActivity.startTime.toString(),
          'finishTime': timerActivity.finishTime.toString(),
          'seconds': timerActivity.second,
          'note': timerActivity.note,
          'type': type.toStringType(),
        });
        break;
      case TimerActivityType.walkActivity:
        body = jsonEncode(<String, dynamic>{
          'startTime': timerActivity.startTime.toString(),
          'finishTime': timerActivity.finishTime.toString(),
          'seconds': timerActivity.second,
          'note': timerActivity.note,
          'type': type.toStringType(),
        });
        break;
      case TimerActivityType.pumpingActivity:
        body = jsonEncode(<String, dynamic>{
          'startTime': timerActivity.startTime.toString(),
          'pumpingType': timerActivity.finishTime.toString(),
          'amount': timerActivity.second.toString(),
          'note': timerActivity.note,
          'type': type.toStringType(),
        });
        break;
      case TimerActivityType.diaperActivity:
        body = jsonEncode(<String, dynamic>{
          'startTime': timerActivity.startTime.toString(),
          'diaperType': timerActivity.finishTime.toString(),
          'note': timerActivity.note,
          'type': type.toStringType(),
        });
        break;
      case TimerActivityType.bottleMilkActivity:
        body = jsonEncode(<String, dynamic>{
          'startTime': timerActivity.startTime.toString(),
          'bottleMilkType': timerActivity.finishTime.toString(),
          'amount': timerActivity.second.toString(),
          'note': timerActivity.note,
          'type': type.toStringType(),
        });
        break;
      case TimerActivityType.measureActivity:
        body = jsonEncode(<String, dynamic>{
          'startTime': timerActivity.startTime.toString(),
          'weight': timerActivity.finishTime.toString(),
          'height': timerActivity.finishTime.toString(),
          'head': timerActivity.finishTime.toString(),
          'note': timerActivity.note,
          'type': type.toStringType(),
        });
        break;
      case TimerActivityType.medicationActivity:
        body = jsonEncode(<String, dynamic>{
          'startTime': timerActivity.startTime.toString(),
          'finishTime': timerActivity.finishTime.toString(),
          'dose': timerActivity.second.toString(),
          'note': timerActivity.note,
          'type': type.toStringType(),
        });
        break;
      case TimerActivityType.vaccinationActivity:
        body = jsonEncode(<String, dynamic>{
          'startTime': timerActivity.startTime.toString(),
          'name': timerActivity.finishTime.toString(),
          'note': timerActivity.note,
          'type': type.toStringType(),
        });
        break;
      default:
        body = "1";
    }
    final response = await http.post(
      Uri.parse('http://dadash3-001-site1.etempurl.com/api/Activity'),
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

  static Future<List<TimerActivity>> fetchTimerActivity() async {
    final response = await http
        .get(Uri.parse('http://dadash3-001-site1.etempurl.com/api/Activity'));
    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      print(response.body);
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => TimerActivity.fromJson(data)).toList();
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  }
}
