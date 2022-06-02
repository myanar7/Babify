import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/model/bottlemilk_activity.dart';
import 'package:flutter_application_1/model/medication_activity.dart';
import 'package:flutter_application_1/model/pumping_activity.dart';
import 'package:flutter_application_1/providers/all_providers.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../model/diaper_activity.dart';

class ChoicePage extends ConsumerStatefulWidget {
  final String activity;
  const ChoicePage({Key? key, required this.activity}) : super(key: key);

  @override
  ConsumerState<ChoicePage> createState() => _ChoicePageState();
}

class _ChoicePageState extends ConsumerState<ChoicePage> {
  String provNote = '';
  var colorController = false;
  var colorController2 = false;
  String type = '';
  String note = '';
  String amount = '';
  late DateTime startTime;
  var selectedDate = DateTime.now();
  Color color = Colors.amber;
  String activity = '';
  String choice1 = ' ';
  String choice2= '';
  
  
  @override
  void initState() {
    
    super.initState();
    activity = widget.activity;
    switch(activity){
      case 'Bottle milk':
      choice1 = 'Formula';
      choice2 = "Mom's milk";
      break;
      case 'Pumping':
      choice1 = 'Left breast';
      choice2 = 'Right breast';
      color = const Color.fromARGB(255, 71, 208, 235);
      break;
      case 'Diaper':
      choice1 = 'Pee';
      choice2 = 'Poo';
      color = const Color.fromARGB(255, 54, 218, 152);
      break;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color,
      appBar: AppBar(
        backgroundColor: color,
        title: Text('Add ' + activity),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.delete))
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  choiceButton(choice1),
                  choiceButton2(choice2),
                ],
              ),
            ),

            
            Expanded(
              flex: 1,
              child: Container(
                  child: setButton(context),
                  ),
            ),
            activity == 'Diaper' ?const SizedBox():
            Expanded(
              flex: 1,
              child: Container(
                  width: 150,
                  child: inputField(context),
                  ),
            ),
            Expanded(
              flex: 1,
              child: addNoteButton(context),
            ),
            Expanded(
              flex: 1,
              child: Container(
                  child: okButton(),
                  ),
            ),
          ],
        ),
      ),
    );
    
    
    
    
    
  }

  choiceButton(String input) {
      return Center(
      child: OutlinedButton(
          
          style: OutlinedButton.styleFrom(
            fixedSize: const Size(100, 50),
            backgroundColor: colorController ? Colors.black: color,
            side: (const BorderSide(color: Colors.white)),
            primary: Colors.white,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30))),
          ),
          onPressed: () {
            setState(() {
              colorController = !colorController;
              type = choice1;
            });
          },
          child: Center(
            child: Text(
              input,
              style: const TextStyle(fontSize: 18),
            ),
          )),
    );

  }

  choiceButton2(String input) {
      return Center(
      child: OutlinedButton(
          
          style: OutlinedButton.styleFrom(
            fixedSize: const Size(100, 50),
            backgroundColor: colorController2 ? Colors.black: color,
            side: (const BorderSide(color: Colors.white)),
            primary: Colors.white,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30))),
          ),
          onPressed: () {
            setState(() {
              colorController2 = !colorController2;
              type = choice2;
            });
          },
          child: Center(
            child: Text(
              input,
              style: const TextStyle(fontSize: 18),
            ),
          )),
    );

  }

  addNoteButton(BuildContext context) {
    return Center(
      child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            fixedSize: const Size(110, 50),
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
              'Add note',
              style: TextStyle(fontSize: 18),
            ),
          )),
    );
  }

  setButton(BuildContext context) {
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

  

 

  inputField(BuildContext context) {
    return TextField(
        keyboardType: TextInputType.number,
        onSubmitted: (String value){
          amount = value;
        },
        decoration: const InputDecoration(
          hintText: 'Enter ml',
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            
            borderRadius: BorderRadius.all(Radius.circular(18)),
          )

        ),
      
    );
  }

  IconButton okButton() {
    return IconButton(
      icon: const Icon(Icons.ac_unit),
      iconSize: 100,
      color: Colors.white,
      onPressed: () {       
        startTime = DateTime.now();
        objectCreater();
         Navigator.of(context).pop();
      },
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

  void setActivity(BuildContext context) {
    DatePicker.showDateTimePicker(context, onConfirm: ((time) {
      startTime = time;
      objectCreater();
      Navigator.of(context).pop();
    }));   
    
    
    
  }

  void objectCreater() {
    switch(widget.activity){
      case "Bottle milk":
      BottleMilkActivity bottleMilkActivity = BottleMilkActivity(const Uuid().v4(), startTime, type, amount, provNote);
      ref.read(timerActivityProvider.notifier).addActivity(bottleMilkActivity);
      break;
      case "Pumping":
      PumpingActivity pumpingActivity = PumpingActivity(const Uuid().v4(), startTime, type, amount, provNote);
      ref.read(timerActivityProvider.notifier).addActivity(pumpingActivity);
      break;    
      case "Diaper":
      DiaperActivity diaperActivity = DiaperActivity(const Uuid().v4(), startTime, type, provNote);
      ref.read(timerActivityProvider.notifier).addActivity(diaperActivity);
      break;   
  
    }
  }
}