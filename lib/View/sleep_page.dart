import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/my_timer.dart';
import 'package:flutter_application_1/model/sleep_activity.dart';
import 'package:flutter_application_1/providers/all_providers.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers/sleep_activity_manager.dart';

class SleepPage extends ConsumerStatefulWidget {
  final String activity;
  const SleepPage({Key? key, required this.activity}) : super(key: key);

  @override
  ConsumerState<SleepPage> createState() => _SleepPageState();
}

class _SleepPageState extends ConsumerState<SleepPage> {
  String activity = '';
  String note = '';
  String provNote = '';
  MyTimer timer = MyTimer();
  DateTime startTime = DateTime.now();
  DateTime endTime = DateTime.now();
  var _dateController = true;
  var _controller = false;
  

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
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    timer.buildTime();
    return Scaffold(
      appBar: AppBar(
        title: Text('Add ' + activity),
        
        
        actions: [
          IconButton(
              onPressed: () {
                clearTimer();
              },
              icon: const Icon(Icons.delete))
        ],
      ),
      body: ListView(
        children: [
          Text(
            timer.hour + ':' + timer.minutes + ':' + timer.seconds,
            style: const TextStyle(fontSize: 80),
          ),
          _controller
              ? stopButton()
              : startButton(),
          cancelButton(),
          setButton(context),
          addNoteButton(context)
        ],
      ),
    );
  }

  ElevatedButton addNoteButton(BuildContext context) {
    return ElevatedButton(onPressed: (){
          noteDialog(context);
        }, child: const Text('Add Note'));
  }

  void noteDialog(BuildContext context) {
    showDialog(context: context, builder: (context) => AlertDialog(
      title: const Text("Add Note"),
      content: TextField(autofocus: true, onChanged: (String value){
        note = value;
      },),
      actions: [
        TextButton(onPressed: (){
          note = '';
          Navigator.pop(context);
        }, child: const Text('Cancel')),
        TextButton(onPressed: (){
          provNote = note;
          Navigator.pop(context);
        }, child: const Text('Ok'))
      ],
    ));
  }

  ElevatedButton setButton(BuildContext context) {
    return ElevatedButton(onPressed: (){
          setActivity(context);
        }, child: Text('Set ' + activity));
  }

  void setActivity(BuildContext context) {
    noteDialog(context);
    DatePicker.showDateTimePicker(context, onConfirm: (time) {
      startTime = time;
      DatePicker.showDateTimePicker(context, onConfirm: ((time) {
        endTime = time;
        int totalMinute = findMinute();
        if(activity == 'sleep'){
          ref
            .read(sleepActivityProvider.notifier)
            .addActivity(startTime, endTime, totalMinute, provNote);
        }else{
          ref
            .read(tummyActivityProvider.notifier)
            .addActivity(startTime, endTime, totalMinute, provNote);
        }
        
      }));
    }   
    );
  }

  ElevatedButton cancelButton() {
    return ElevatedButton(
            onPressed: () {
              int second = timer.duration.inSeconds;
              clearTimer();
              endTime = DateTime.now();
              if(activity == 'sleep'){
                ref
                  .read(sleepActivityProvider.notifier)
                  .addActivity(startTime, endTime, second, provNote);
              }else{
                ref
                  .read(tummyActivityProvider.notifier)
                  .addActivity(startTime, endTime, second, provNote);
              }
            },
            child: const Text('Cancel'));
  }

  ElevatedButton startButton() {
    return ElevatedButton(
                onPressed: () {
                  timer.startTimer();
                  _controller = true;
                  if (_dateController) {
                    _dateController = false;
                    startTime = DateTime.now();
                  }
                  setState(() {});
                },
                child: const Text('Start'));
  }

  ElevatedButton stopButton() {
    return ElevatedButton(
                onPressed: () {
                  timer.timer.cancel();
                  _controller = false;
                  setState(() {});
                },
                child: const Text('Stop'));
  }

  void clearTimer() {
    timer.reset();
    _controller = false;
    timer.timer.cancel();
    setState(() {});
    _dateController = true;
  }

  int findMinute() {
    int totalMinute = (endTime.hour - startTime.hour) * 60 + (endTime.minute - startTime.minute);
    return totalMinute;
  }

  
}
