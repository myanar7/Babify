import 'dart:convert';

import 'package:flutter_application_1/model/timer_activity.dart';
import 'package:flutter_application_1/providers/all_providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;

enum TimerActivityType { sleepActivity, tummyActivity }

class ApiController {
  static Future<void> postTimerActivity(WidgetRef ref,
      TimerActivity timerActivity, TimerActivityType type) async {
    final response = await http.post(
      Uri.parse('http://dadash3-001-site1.etempurl.com/api/TimerActivity'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'startTime': timerActivity.startTime.toString(),
        'endTime': timerActivity.finishTime.toString(),
        'seconds': timerActivity.second,
        'note': timerActivity.note,
        'type': type == TimerActivityType.sleepActivity ? "sleep" : "tummy",
      }),
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
    final response = await http.get(
        Uri.parse('http://dadash3-001-site1.etempurl.com/api/TimerActivity'));
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
