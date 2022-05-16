import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/sleep_page.dart';
import 'package:flutter_application_1/model/tummy_activity.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers/all_providers.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  String provNote = '';
  var _allSleepActivities = [];
  var _allTummyActivities = [];
  @override
  Widget build(BuildContext context) {
    _allSleepActivities = ref.watch(sleepActivityProvider);
    _allTummyActivities = ref.watch(tummyActivityProvider);
    var sleepActivity = SleepPage(activity: 'sleep');
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

          ListView.builder(shrinkWrap: true,itemCount: _allSleepActivities.length,itemBuilder: ((context, index) {
            return Dismissible(
              key: ValueKey(_allSleepActivities[index].id),
              onDismissed: (a){
                ref.read(sleepActivityProvider.notifier).remove(_allSleepActivities[index]);
              },
              child: GestureDetector(
                onTap: () {
                  setActivity(context, 'sleep', _allSleepActivities[index].id);
                },child: Text(_allSleepActivities[index].second.toString() + _allSleepActivities[index].note),
              ) 
            );
          }),),

          for(var i=0; i<_allTummyActivities.length; i++)
            Dismissible(
              key: ValueKey(_allTummyActivities[i].id),
              onDismissed: (a){
                ref.read(tummyActivityProvider.notifier).remove(_allTummyActivities[i]);
              },
              child: GestureDetector(
                onTap: () {
                  setActivity(context, 'tummy', _allTummyActivities[i].id);
                },child: Text(_allTummyActivities[i].second.toString() + _allTummyActivities[i].note),
              ) 
              
            )
        ],
      )
      
    );

    
  }


  void setActivity(BuildContext context,  String activity, String id) {
    noteDialog(context);
    DateTime startTime = DateTime.now();
    DateTime endTime = DateTime.now();
    DatePicker.showDateTimePicker(context, onConfirm: (time) {
      startTime = time;
      DatePicker.showDateTimePicker(context, onConfirm: ((time) {
        endTime = time;
        int totalMinute = (endTime.hour - startTime.hour) * 60 + (endTime.minute - startTime.minute);
        if(activity == 'sleep'){
          for(int i=0; i<_allSleepActivities.length; i++){
            if(_allSleepActivities[i].id == id){
              ref.read(sleepActivityProvider.notifier).remove(_allSleepActivities[i]);
            }
          }          
          ref.read(tummyActivityProvider.notifier).addActivity(startTime, endTime, totalMinute, provNote);
        }else{
          for(int i=0; i<_allTummyActivities.length; i++){
            if(_allTummyActivities[i].id == id){
              ref.read(tummyActivityProvider.notifier).remove(_allTummyActivities[i]);
            }
          }
          
          ref.read(tummyActivityProvider.notifier).addActivity(startTime, endTime, totalMinute, provNote);
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

          