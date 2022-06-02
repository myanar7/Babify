import 'package:flutter_application_1/model/measure_activity.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
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
import '../model/vaccination_activity.dart';

class HealthPage extends ConsumerStatefulWidget {
  final String activity;
  const HealthPage({Key? key, required this.activity}) : super(key: key);

  @override
  ConsumerState<HealthPage> createState() => _HealthPageState();
}

class _HealthPageState extends ConsumerState<HealthPage> {
  String provNote = '';
  String type = '';
  String note = '';
  String amount = '';
  String name = '';
  String height = '';
  String weight = '';
  String head = '';
  late DateTime startTime;
  Color color = Colors.amber;
  var colorController = false;
  var colorController2 = false;
  String activity = '';
  String choice1 = ' ';
  String choice2= '';
  
  
  @override
  void initState() {
    
    super.initState();
    activity = widget.activity;
    switch(activity){
      case 'Medication':
      choice1 = 'ml';
      choice2 = 'dose';
      break;
      case 'Vaccination':
      color = const Color.fromARGB(255, 71, 208, 235);
      break;
      case 'Measure':
      color = Color.fromARGB(255, 244, 255, 183);
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
            activity == 'Medication'?
            Expanded(flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  choiceButton(choice1),
                  choiceButton2(choice2),
                ],
              ),
            ): const SizedBox(),

            
            Expanded(
              flex: 1,
              child: Container(
                  child: setButton(context),
                  ),
            ),
            
            Expanded(
              flex: 2,
              child: Center(
                child: Column(
                  children: [
                    Expanded(
                    child: activity == 'Measure' ? SizedBox():
                    Container(
                        width: 200,
                        child: inputField(context),
                        ),),
                    Expanded(
                    child: activity == 'Medication' ?
                    Container(
                        width: 150,
                        child: inputField2(context),
                        ):const SizedBox()),
                    Expanded(
                    child: activity == 'Measure' ?
                    Container(
                        width: 150,
                        child: inputField3(context),
                        ):const SizedBox(),),
                    Expanded(
                    child: activity == 'Measure' ?
                    Container(
                        width: 150,
                        child: inputField4(context),
                        ):const SizedBox(),),
                    Expanded(
                    child: activity == 'Measure' ?
                    Container(
                        width: 150,
                        child: inputField5(context),
                        ):const SizedBox(),),
                  ],
                ),
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
              style: const TextStyle(fontSize: 16),
            ),
          )),
    );
  }

  

 

  inputField(BuildContext context) {
    return TextField(
        keyboardType: TextInputType.text,
        onChanged: (String value){
          name = value;
        },
        decoration: const InputDecoration(
          hintText: 'Enter name',
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            
            borderRadius: BorderRadius.all(Radius.circular(18)),
          )

        ),
      
    );
  }

    inputField2(BuildContext context) {
    return TextField(
        keyboardType: TextInputType.number,
        onChanged: (String value){
          amount = value;
        },
        decoration: const InputDecoration(
          hintText: 'Enter ',
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            
            borderRadius: BorderRadius.all(Radius.circular(18)),
          )

        ),
      
    );
  }

  inputField3(BuildContext context) {
    return TextField(
        keyboardType: TextInputType.number,
        onChanged: (String value){
          weight = value;
        },
        decoration: const InputDecoration(
          hintText: 'Enter weight -kg',
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            
            borderRadius: BorderRadius.all(Radius.circular(18)),
          )

        ),
      
    );
  }

  inputField4(BuildContext context) {
    return TextField(
        keyboardType: TextInputType.number,
        onChanged: (String value){
          height = value;
        },
        decoration: const InputDecoration(
          hintText: 'Enter height -cm',
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            
            borderRadius: BorderRadius.all(Radius.circular(18)),
          )

        ),
      
    );
  }

   inputField5(BuildContext context) {
    return TextField(
        keyboardType: TextInputType.number,
        onChanged: (String value){
          head = value;
        },
        decoration: const InputDecoration(
          hintText: 'Enter head -cm',
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
      case "Medication":
      MedicationActivity medicationActivity = MedicationActivity(const Uuid().v4(), startTime, type, amount,name, provNote);
      ref.read(timerActivityProvider.notifier).addActivity(medicationActivity);
      break;
      case "Vaccination":
      VaccinationActivity vaccinationActivity = VaccinationActivity(const Uuid().v4(), startTime, name, provNote);
      ref.read(timerActivityProvider.notifier).addActivity(vaccinationActivity);
      break;    
      case "Measure":
      MeasureActivity measureActivity = MeasureActivity(const Uuid().v4(), startTime, height, weight,head, provNote);
      ref.read(timerActivityProvider.notifier).addActivity(measureActivity);
      break;   
  
    }
  }
}