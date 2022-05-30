import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/timer_page.dart';
import 'package:flutter_application_1/model/sleep_activity.dart';
import 'package:flutter_application_1/model/timer_activity.dart';
import 'package:flutter_application_1/model/tummy_activity.dart';
import 'package:flutter_application_1/services/api_controller.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../providers/all_providers.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  String provNote = '';
  var _allTimerActivities = [];
  @override
  void initState() {
    super.initState();
    _fetchAllActivitesFromApi(); // bunu öyle bi yere koymalı ki hem ref.watchtan sonra olacak hem de initStatede olacak ya da bi
  }

  void _fetchAllActivitesFromApi() async {
    ref
        .read(timerActivityProvider.notifier)
        .addAllActivities(await ApiController.fetchTimerActivity());
  }

  @override
  Widget build(BuildContext context) {
    _allTimerActivities = ref.watch(timerActivityProvider);
    var sleepActivity = const TimerPage(activity: 'sleep');
    var tummyActivity = const TimerPage(activity: 'tummy');
    return Scaffold(
        body: ListView(
      children: [
        IconButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => sleepActivity));
          },
          icon: const Icon(Icons.add),
        ),
        IconButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => tummyActivity));
          },
          icon: const Icon(Icons.add),
        ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: _allTimerActivities.length,
          itemBuilder: ((context, index) {
            return Dismissible(
                key: ValueKey(_allTimerActivities[index].id),
                onDismissed: (a) {
                  ref
                      .read(timerActivityProvider.notifier)
                      .remove(_allTimerActivities[index]);
                },
                child: GestureDetector(
                  onTap: () {
                    setActivity(context, _allTimerActivities[index].id);
                  },
                  child: Text(_allTimerActivities[index] is SleepActivity
                      ? _allTimerActivities[index].second.toString() +
                          _allTimerActivities[index].note +
                          _allTimerActivities[index].id
                      : "Yok Bu Sleep Activity Degil"),
                ));
          }),
        ),
      ],
    ));
  }

  void setActivity(BuildContext context, String id) {
    noteDialog(context);
    DateTime startTime = DateTime.now();
    DateTime endTime = DateTime.now();
    DatePicker.showDateTimePicker(context, onConfirm: (time) {
      startTime = time;
      DatePicker.showDateTimePicker(context, onConfirm: ((time) {
        endTime = time;
        int totalMinute = (endTime.hour - startTime.hour) * 60 +
            (endTime.minute - startTime.minute);
        ref
            .read(timerActivityProvider.notifier)
            .edit(id, totalMinute, startTime, endTime, provNote);
      }));
    });
  }

  void noteDialog(BuildContext context) {
    String note = '';
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Add Note"),
              content: TextField(
                autofocus: true,
                onChanged: (String value) {
                  note = value;
                },
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      note = '';
                      Navigator.pop(context);
                    },
                    child: const Text('Cancel')),
                TextButton(
                    onPressed: () {
                      provNote = note;
                      Navigator.pop(context);
                    },
                    child: const Text('Ok'))
              ],
            ));
  }
}
