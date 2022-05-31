import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/my_timer.dart';
import 'package:flutter_application_1/model/sleep_activity.dart';
import 'package:flutter_application_1/model/timer_activity.dart';
import 'package:flutter_application_1/services/api_controller.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../model/tummy_activity.dart';

class TimerPage extends ConsumerStatefulWidget {
  final String activity;
  const TimerPage({Key? key, required this.activity}) : super(key: key);

  @override
  ConsumerState<TimerPage> createState() => _SleepPageState();
}

class _SleepPageState extends ConsumerState<TimerPage> {
  String activity = '';
  int second = 0;
  String note = '';
  String provNote = '';
  MyTimer timer = MyTimer();
  DateTime startTime = DateTime.now();
  DateTime endTime = DateTime.now();
  late TimerActivity timerActivity;
  var _dateController = true;
  var _controller = false;
  Color color = const Color.fromARGB(255, 107, 195, 108);
  late TimerActivityType type;
  @override
  void initState() {
    super.initState();
    timer.reset();
    switch (widget.activity) {
      case 'sleep':
        activity = 'sleep';
        type = TimerActivityType.sleepActivity;
        timerActivity = SleepActivity(
            id: const Uuid().v4(),
            startTime: startTime,
            finishTime: endTime,
            second: second,
            note: provNote);
        break;
      case 'tummy':
        activity = 'tummy';
        type = TimerActivityType.tummyActivity;
        color = const Color.fromARGB(255, 100, 158, 205);
        timerActivity = TummyActivity(
            id: const Uuid().v4(),
            startTime: startTime,
            finishTime: endTime,
            second: second,
            note: provNote);
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
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                child: Text(
                  timer.hour + ':' + timer.minutes + ':' + timer.seconds,
                  style: const TextStyle(fontSize: 100, color: Colors.white),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                  child: setButton(context),
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 250)),
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
        child: const Text(
          "Add note",
          style: TextStyle(fontSize: 18),
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
          child: Text(
            'Set ' + activity,
            style: const TextStyle(fontSize: 16),
          )),
    );
  }

  void setActivity(BuildContext context) {
    noteDialog(context);
    DatePicker.showDateTimePicker(context, onConfirm: (time) {
      timerActivity.startTime = time;
      DatePicker.showDateTimePicker(context, onConfirm: ((tim) async {
        timerActivity.finishTime = tim;
        timerActivity.second = findMinute();
        timerActivity.note = provNote;
        await ApiController.postTimerActivity(ref, timerActivity, type);
      }));
    });
  }

  IconButton cancelButton() {
    return IconButton(
      icon: const Icon(Icons.stop_circle),
      iconSize: 100,
      color: Colors.white,
      onPressed: () async {
        timerActivity.second = timer.duration.inSeconds;
        clearTimer();
        timerActivity.finishTime = DateTime.now();
        timerActivity.startTime = startTime;
        timerActivity.note = provNote;
        await ApiController.postTimerActivity(ref, timerActivity, type);
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
