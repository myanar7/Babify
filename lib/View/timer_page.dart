import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/bath_activity.dart';
import 'package:flutter_application_1/model/breastfeeding_activity.dart';
import 'package:flutter_application_1/model/my_timer.dart';
import 'package:flutter_application_1/model/sleep_activity.dart';
import 'package:flutter_application_1/model/timer_activity.dart';
import 'package:flutter_application_1/model/walk_activity.dart';
import 'package:flutter_application_1/providers/all_providers.dart';
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
  int second = 0;
  String note = '';
  String provNote = '';
  MyTimer timer = MyTimer();
  DateTime startTime = DateTime.now();
  DateTime endTime = DateTime.now();
  var _dateController = true;
  var _controller = false;
  Color color = Color.fromARGB(255, 107, 195, 108);

  @override
  void initState() {
    super.initState();
    timer.reset();
    switch (widget.activity) {
      case 'sleep':
        activity = 'sleep';
        break;
      case 'tummy':
        activity = 'tummy';
        color = Color.fromARGB(255, 100, 158, 205);
        break;
      case 'walk':
        activity = 'walk';
        color = Color.fromARGB(255, 205, 87, 87);
      break;
      case 'bath':
        activity = 'bath';
        color = Color.fromARGB(255, 0, 140, 255);
      break;
      case 'breastfeeding':
        activity = 'breastfeeding';
        color = Color.fromARGB(255, 234, 254, 155);
      break;      
    }
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
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Text(
                  timer.hour + ':' + timer.minutes + ':' + timer.seconds,
                  style: const TextStyle(fontSize: 80, color: Colors.white),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                  child: setButton(context),
                  ),
            ),
            Expanded(
              flex: 1,
              child: addNoteButton(context),
            ),
            Expanded(
              flex: 1,
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
          fixedSize: const Size(100, 50),
          side: (const BorderSide(color: Colors.white)),
          primary: Colors.white,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30))),
        ),
        onPressed: () {
          noteDialog(context);
        },
        child: const Center(
          child:  Text(
            "Add note",
            style: TextStyle(fontSize: 18),
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
            fixedSize: const Size(100, 50),
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
              style: const TextStyle(fontSize: 18),
            ),
          )),
    );
  }

  void setActivity(BuildContext context) {
    
    DatePicker.showDateTimePicker(context, onConfirm: (time) {
      DatePicker.showDateTimePicker(context, onConfirm: ((tim) {
        objectCreater(time, tim, findMinute());
        Navigator.of(context).pop();
      }));
    });
  }

  void objectCreater(DateTime time, DateTime tim, int second) {
    switch(widget.activity){
      case "sleep":
      SleepActivity sleepActivity = SleepActivity(const Uuid().v4(), time, tim, second, provNote);
      ref.read(timerActivityProvider.notifier).addActivity(sleepActivity);
      break;         
      case "tummy":
      TummyActivity tummyActivity = TummyActivity(const Uuid().v4(), time, tim, second, provNote);
      ref.read(timerActivityProvider.notifier).addActivity(tummyActivity);
      break;
      case "breastfeeding":
      BreastFeedingActivity breastFeedingActivity = BreastFeedingActivity(const Uuid().v4(), time, tim, second, provNote);
      ref.read(timerActivityProvider.notifier).addActivity(breastFeedingActivity);
      break;
      case "walk":
      WalkActivity walkActivity = WalkActivity(const Uuid().v4(), time, tim, second, provNote);
      ref.read(timerActivityProvider.notifier).addActivity(walkActivity);
      break;
      case "bath":
      BathActivity bathActivity = BathActivity(const Uuid().v4(), time, tim, second, provNote);
      ref.read(timerActivityProvider.notifier).addActivity(bathActivity);
      break;
    }
  }

  IconButton cancelButton() {
    return IconButton(
      icon: const Icon(Icons.stop_circle),
      iconSize: 100,
      color: Colors.white,
      onPressed: () {
        objectCreater(startTime, DateTime.now(), timer.duration.inSeconds);
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
