import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/baby.dart';
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

class ApiController {
  static Future<int> authTokenFetch(
      BuildContext context, String username, String password) async {
    var headers = {
      'accept': '/',
      'Content-Type': 'application/json',
    };

    var data = '{ "username": "$username","password": "$password"}';

    var url = Uri.parse("http://dadash3-001-site1.etempurl.com/api/User/login");
    var res = await http.post(url, headers: headers, body: data);
    if (res.statusCode == 200) {
      final parsed = json.decode(res.body).cast<String, dynamic>();
    } else {
      throw Exception('http.post error: statusCode= ${res.statusCode}');
    }
    return res.statusCode;
  }

  static void authRegisterFetch(BuildContext context, String email,
      String username, String password) async {
    var headers = {
      'accept': '/',
      'Content-Type': 'application/json',
    };

    var data =
        '{"userName": "$username","email": "$email","password": "$password"}';

    var url =
        Uri.parse("http://dadash3-001-site1.etempurl.com/api/User/register");
    var res = await http.post(url, headers: headers, body: data);

    if (res.statusCode == 200) {
      final parsed = json.decode(res.body).cast<String, dynamic>();
      Navigator.of(context).pop();
    } else {
      throw Exception('http.post error: statusCode= ${res.statusCode}');
    }
  }

  static Future<void> postTimerActivity(
      WidgetRef ref, dynamic timerActivity, TimerActivityType type) async {
    String body = "";
    String path = "";
    List babies = ref.read(babyProfileProvider);
    int babyId = -1;
    if (babies.isNotEmpty) babyId = int.parse(babies[Baby.currentIndex].id);
    switch (type) {
      case TimerActivityType.sleepActivity:
        if (timerActivity is! SleepActivity) break;
        SleepActivity sleepActivity = timerActivity;
        body = jsonEncode(<String, dynamic>{
          'babyId': babyId,
          'startTime': sleepActivity.startTime.toString(),
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
          'babyId': babyId,
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
          'babyId': babyId,
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
          'babyId': babyId,
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
          'babyId': babyId,
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
          'babyId': babyId,
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
          'babyId': babyId,
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
          'babyId': babyId,
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
          'babyId': babyId,
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
          'babyId': babyId,
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
          'babyId': babyId,
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

  static Future<List<Activity>> fetchTimerActivity(List<Baby> babies) async {
    int babyId = 0;
    if (babies.isNotEmpty) babyId = int.parse(babies[Baby.currentIndex].id);

    final response = await http.get(Uri.parse(
        'http://dadash3-001-site1.etempurl.com/api/Activity/get-activities-with-baby-id?babyId=$babyId'));
    //'http://dadash3-001-site1.etempurl.com/api/Activity/get-activity-with-baby-id?babyId=${ref.read(babyProfileProvider)[Baby.currentIndex].id}'));
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

  static Future<Baby> postBaby(WidgetRef ref, String name, DateTime birthday,
      double height, double weight) async {
    String body = "";
    String path = "";

    body = jsonEncode(<String, dynamic>{
      'startTime': "",
      'name': "",
      'note': "",
      'type': "",
    });
    path = "1";

    final response = await http.post(
      Uri.parse(
          'http://dadash3-001-site1.etempurl.com/api/Baby/get-baby-with-parent-id?parentId=$path'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: body, // ŞU URL SESSIONU YAPINCA OLUR GIBI GIBI
    );

    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      print(response.body);
      return Baby(
          id: response.body,
          photoPath:
              'https://images.pexels.com/photos/1556706/pexels-photo-1556706.jpeg?cs=srgb&dl=pexels-daniel-reche-1556706.jpg&fm=jpg',
          name: name,
          birthday: birthday,
          height: height,
          weight: weight);
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  }

  static Future<void> fetchBabies(WidgetRef ref) async {
    final response = await http.get(Uri.parse(
        'http://dadash3-001-site1.etempurl.com/api/Baby/get-babies?parentId=1'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      ref.read(babyProfileProvider.notifier).addAllBabyProfiles(
          jsonResponse.map((data) => Baby.fromJson(data)).toList());
      Baby.currentIndex = 0;
    } else {
      throw Exception("Failed to fetch Babies");
    }
  }
}
