import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/bath_activity.dart';
import 'package:flutter_application_1/model/breastfeeding_activity.dart';
import 'package:flutter_application_1/model/my_timer.dart';
import 'package:flutter_application_1/model/sleep_activity.dart';
import 'package:flutter_application_1/model/walk_activity.dart';
import 'package:flutter_application_1/providers/all_providers.dart';
import 'package:flutter_application_1/services/api_controller.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../model/tummy_activity.dart';

class TimerPage extends ConsumerStatefulWidget {
  final String activity;
  const TimerPage({Key? key, required this.activity}) : super(key: key);

  @override
  ConsumerState<TimerPage> createState() => _TimerPageState();
}

class _TimerPageState extends ConsumerState<TimerPage> {
  String activity = '';
  String icon = '';
  int second = 0;
  String note = '';
  String provNote = '';
  MyTimer timer = MyTimer();
  DateTime startTime = DateTime.now();
  DateTime endTime = DateTime.now();
  var _dateController = true;
  var _controller = false;
  Color color = const Color.fromARGB(255, 205, 202, 194);
  late TimerActivityType type;
  @override
  void initState() {
    super.initState();
    timer.reset();
    switch (widget.activity) {
      case 'sleep':
        activity = 'sleep';
        icon = "assets/icons/sleep.png";
        break;
      case 'tummy':
        activity = 'tummy';
        color = const Color.fromARGB(255, 100, 158, 205);
        icon = "assets/icons/tummy.png";
        break;
      case 'walk':
        activity = 'walk';
        color = const Color.fromARGB(255, 205, 87, 87);
        icon = "assets/icons/walk.png";
        break;
      case 'bath':
        activity = 'bath';
        color = Color.fromARGB(255, 255, 0, 221);
        icon = "assets/icons/bath.png";
        break;
      case 'breastfeeding':
        activity = 'breastfeeding';
        color = const Color.fromARGB(255, 216, 44, 44);
        icon = "assets/icons/breastfeeding.png";
        break;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    timer.buildTime();
    return Scaffold(
      backgroundColor: color,
      appBar: AppBar(
        backgroundColor: color,
        title: Text('Add ' + activity),
        actions: [
          IconButton(
              onPressed: () {
                clearTimer();
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.delete))
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(child: Image.asset(icon),flex: 1,),
            Expanded(
              flex: 2,
              child: Container(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Text(
                  timer.hour + ':' + timer.minutes + ':' + timer.seconds,
                  style: const TextStyle(fontSize: 80, color: Colors.white),
                ),
              ),
            ),
            

            Expanded(
              flex: 2,
              child: Container(
                child: setButton(context),
              ),
            ),
            Expanded(
              flex: 2,
              child: addNoteButton(context),
            ),
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(child: _controller ? stopButton() : startButton()),
                  cancelButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Center addNoteButton(BuildContext context) {
    return Center(
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          fixedSize: const Size(120, 50),
          side: (const BorderSide(color: Colors.white)),
          primary: Colors.white,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30))),
        ),
        onPressed: () {
          noteDialog(context);
        },
        child: const Center(
          child: Text(
            "Add note",
            style: TextStyle(fontSize: 17),
          ),
        ),
      ),
    );
  }

  void noteDialog(BuildContext context) {
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

  Center setButton(BuildContext context) {
    return Center(
      child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            fixedSize: const Size(140, 50),
            side: (const BorderSide(color: Colors.white)),
            primary: Colors.white,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30))),
          ),
          onPressed: () {
            setActivity(context);
          },
          child: Center(
            child: Text(
              'Set ' + activity,
              style: const TextStyle(fontSize: 17),
            ),
          )),
    );
  }

  void setActivity(BuildContext context) {
    DatePicker.showDateTimePicker(context,minTime: DateTime(2022, 4, 1),maxTime: DateTime.now(), onConfirm: (time) {
      DatePicker.showDateTimePicker(context, minTime: DateTime(2022, 4, 1),maxTime: DateTime.now(), onConfirm: ((tim) async {
        await objectCreater(time, tim, findMinute());
        Navigator.of(context).pop();
      }));
    });
  }

  Future<void> objectCreater(DateTime time, DateTime tim, int second) async {
    switch (widget.activity) {
      case "sleep":
        SleepActivity sleepActivity =
            SleepActivity(const Uuid().v4(), time, tim, second, provNote);
        type = TimerActivityType.sleepActivity;
        await ApiController.postTimerActivity(ref, sleepActivity, type);
        break;
      case "tummy":
        TummyActivity tummyActivity =
            TummyActivity(const Uuid().v4(), time, tim, second, provNote);
        type = TimerActivityType.tummyActivity;
        await ApiController.postTimerActivity(ref, tummyActivity, type);
        break;
      case "breastfeeding":
        BreastFeedingActivity breastFeedingActivity = BreastFeedingActivity(
            const Uuid().v4(), time, tim, second, provNote);
        type = TimerActivityType.breastFeedingActivity;
        await ApiController.postTimerActivity(ref, breastFeedingActivity, type);
        break;
      case "walk":
        WalkActivity walkActivity =
            WalkActivity(const Uuid().v4(), time, tim, second, provNote);
        type = TimerActivityType.walkActivity;
        await ApiController.postTimerActivity(ref, walkActivity, type);
        break;
      case "bath":
        BathActivity bathActivity =
            BathActivity(const Uuid().v4(), time, tim, second, provNote);
        type = TimerActivityType.bathActivity;
        await ApiController.postTimerActivity(ref, bathActivity, type);
        break;
    }
  }

  IconButton cancelButton() {
    return IconButton(
      icon: const Icon(Icons.stop_circle),
      iconSize: 100,
      color: Colors.white,
      onPressed: () async {
        await objectCreater(
            startTime, DateTime.now(), timer.duration.inSeconds);
        clearTimer();
        Navigator.of(context).pop();
      },
    );
  }

  IconButton startButton() {
    return IconButton(
      icon: const Icon(Icons.play_circle),
      iconSize: 100,
      color: Colors.white,
      onPressed: () {
        timer.startTimer();
        _controller = true;
        if (_dateController) {
          _dateController = false;
          startTime = DateTime.now();
        }
        setState(() {});
      },
    );
  }

  IconButton stopButton() {
    return IconButton(
      icon: const Icon(Icons.pause_circle),
      iconSize: 100,
      color: Colors.white,
      onPressed: () {
        timer.timer.cancel();
        _controller = false;
        setState(() {});
      },
    );
  }

  void clearTimer() {
    timer.reset();
    _controller = false;
    timer.timer.cancel();
    setState(() {});
    _dateController = true;
  }

  int findMinute() {
    int totalMinute = (endTime.hour - startTime.hour) * 60 +
        (endTime.minute - startTime.minute);
    return totalMinute;
  }
}
