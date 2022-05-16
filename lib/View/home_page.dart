import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/sleep_page.dart';
import 'package:flutter_application_1/model/sleep_activity.dart';
import 'package:flutter_application_1/model/timer_activity.dart';
import 'package:flutter_application_1/model/tummy_activity.dart';
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
  Widget build(BuildContext context) {
    _allTimerActivities = ref.watch(timerActivityProvider);
    var sleepActivity = const SleepPage(activity: 'sleep');
    var tummyActivity = const SleepPage(activity: 'tummy');
    return Scaffold(
      body: ListView(
        children: [
          IconButton(onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => sleepActivity));
          }, icon: const Icon(Icons.add),),
          IconButton(onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => tummyActivity));
          }, icon: const Icon(Icons.add),),

          ListView.builder(shrinkWrap: true,itemCount: _allTimerActivities.length,itemBuilder: ((context, index) {
            return Dismissible(
              key: ValueKey(_allTimerActivities[index].id),
              onDismissed: (a){
                ref.read(timerActivityProvider.notifier).remove(_allTimerActivities[index]);
              },
              child: GestureDetector(
                onTap: () {
                  setActivity(context, _allTimerActivities[index].id);
                },child: Text(_allTimerActivities[index].second.toString() + _allTimerActivities[index].note),
              ) 
            );
          }),),
        ],
      )
      
    );    
  }


  void setActivity(BuildContext context, String id) {
    noteDialog(context);
    DateTime startTime = DateTime.now();
    DateTime endTime = DateTime.now();
    DatePicker.showDateTimePicker(context, onConfirm: (time) {
      startTime = time;
      DatePicker.showDateTimePicker(context, onConfirm: ((time) {
        endTime = time;
        int totalMinute = (endTime.hour - startTime.hour) * 60 + (endTime.minute - startTime.minute);
          int i=0;
          for(; i<_allTimerActivities.length; i++){
            if(_allTimerActivities[i].id == id){
              ref.read(timerActivityProvider.notifier).remove(_allTimerActivities[i]);
              break;
            }
          }          
          if(_allTimerActivities[i] is SleepActivity ){
            TimerActivity sleepActivity = SleepActivity(id: const Uuid().v4(), startTime: startTime, finishTime: endTime, second: totalMinute, note: provNote);
            ref.read(timerActivityProvider.notifier).addActivity(sleepActivity);
          }else{
            TimerActivity tummyActivity = TummyActivity(id: const Uuid().v4(), startTime: startTime, finishTime: endTime, second: totalMinute, note: provNote);
            ref.read(timerActivityProvider.notifier).addActivity(tummyActivity);
          }
        }));
    }   
    );
  }


  void noteDialog(BuildContext context) {
    String note = '';
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


}

          