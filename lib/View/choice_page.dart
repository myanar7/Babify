import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/model/bottlemilk_activity.dart';
import 'package:flutter_application_1/model/medication_activity.dart';
import 'package:flutter_application_1/model/pumping_activity.dart';
import 'package:flutter_application_1/providers/all_providers.dart';
import 'package:flutter_application_1/services/api_controller.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
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
  String icon = '';
  late DateTime startTime;
  var selectedDate = DateTime.now();
  Color color = Color.fromARGB(255, 101, 201, 243);
  String activity = '';
  String choice1 = ' ';
  String choice2 = '';

  @override
  void initState() {
    super.initState();
    activity = widget.activity;
    switch (activity) {
      case 'Bottle milk':
        choice1 = 'Formula';
        choice2 = "Mom's milk";
        icon = "assets/icons/milk.png";
        break;
      case 'Pumping':
        choice1 = 'Left breast';
        choice2 = 'Right breast';
        icon = "assets/icons/pumping.png";
        color = const Color.fromARGB(255, 162, 96, 94);
        break;
      case 'Diaper':
        choice1 = 'Pee';
        choice2 = 'Poo';
        icon = "assets/icons/diaper.png";
        color = const Color.fromARGB(255, 138, 255, 183);
        break;
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(builder: EasyLoading.init(),home: Scaffold(
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
            Expanded(flex: 1, child: Container(child: Image.asset(icon),padding: const EdgeInsets.fromLTRB(0, 10, 0, 0) )),
            Expanded(
              flex: 1,
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
            activity == 'Diaper'
                ? const SizedBox()
                : Expanded(
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
    ));
  }

  choiceButton(String input) {
    return Center(
      child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            fixedSize: const Size(100, 50),
            backgroundColor: colorController ? Colors.black : color,
            side: (const BorderSide(color: Colors.white)),
            primary: Colors.white,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30))),
          ),
          onPressed: () {
            setState(() {
              colorController = !colorController;
              
              if(colorController2){
                colorController2 = !colorController2;
              }
              type = choice1;
              if(!colorController){
                type = '';
              }
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
            backgroundColor: colorController2 ? Colors.black : color,
            side: (const BorderSide(color: Colors.white)),
            primary: Colors.white,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30))),
          ),
          onPressed: () {
            setState(() {
              colorController2 = !colorController2;
              if(colorController){
                colorController = !colorController;
              }
              type = choice2;
              if(!colorController2){
                type = '';
              }
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
      onChanged: (String value) {
        amount = value;
      },
      decoration: const InputDecoration(
          hintText: 'Enter ml',
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(18)),
          )),
    );
  }

  IconButton okButton() {
    return IconButton(
      icon: const Icon(Icons.check_circle_outline_sharp),
      iconSize: 100,
      color: Colors.white,
      onPressed: () async {
        startTime = DateTime.now();
        control();
      },
    );
  }

  void noteDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Text("Add Note"),
              content: TextField(
                maxLength: 25,
                autofocus: true,
                decoration: const InputDecoration(counterText: ""),
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
    DatePicker.showDateTimePicker(context,minTime: DateTime(2022, 4, 1),maxTime: DateTime.now(), onConfirm: ((time) async {
      startTime = time;
      control();
    }));
  }

  Future<void> objectCreater() async {
    switch (widget.activity) {
      case "Bottle milk":
        BottleMilkActivity bottleMilkActivity = BottleMilkActivity(
            const Uuid().v4(), startTime, type, amount, provNote);
        await ApiController.postTimerActivity(
            ref, bottleMilkActivity, TimerActivityType.bottleMilkActivity);
        break;
      case "Pumping":
        PumpingActivity pumpingActivity = PumpingActivity(
            const Uuid().v4(), startTime, type, amount, provNote);
        await ApiController.postTimerActivity(
            ref, pumpingActivity, TimerActivityType.pumpingActivity);
        break;
      case "Diaper":
        DiaperActivity diaperActivity =
            DiaperActivity(const Uuid().v4(), startTime, type, provNote);
        await ApiController.postTimerActivity(
            ref, diaperActivity, TimerActivityType.diaperActivity);
        break;
    }
  }

  Future<void> control() async {
    if(type != '' && amount != '' && activity == 'Bottle milk'){        
        await objectCreater();
        Navigator.of(context).pop();
      }else if(activity == 'Bottle milk'){
        EasyLoading.showToast("Enter all information", duration: const Duration(seconds: 1), dismissOnTap: true, toastPosition: EasyLoadingToastPosition.bottom);
      }
      if(type != '' && amount != '' && activity == 'Pumping'){        
        await objectCreater();
        Navigator.of(context).pop();
      }else if(activity == 'Pumping'){
        EasyLoading.showToast("Enter all information", duration: const Duration(seconds: 1), dismissOnTap: true, toastPosition: EasyLoadingToastPosition.bottom);
      }
      if(type != '' && activity == 'Diaper'){        
        await objectCreater();
        Navigator.of(context).pop();
      }else if(activity == 'Diaper'){
        EasyLoading.showToast("Enter type", duration: const Duration(seconds: 1), dismissOnTap: true, toastPosition: EasyLoadingToastPosition.bottom);
      }
  }
}
