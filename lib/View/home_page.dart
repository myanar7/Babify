import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/activity_page.dart';
import 'package:flutter_application_1/View/choice_page.dart';
import 'package:flutter_application_1/View/timer_page.dart';
import 'package:flutter_application_1/model/bath_activity.dart';
import 'package:flutter_application_1/model/bottlemilk_activity.dart';
import 'package:flutter_application_1/model/breastfeeding_activity.dart';
import 'package:flutter_application_1/model/diaper_activity.dart';
import 'package:flutter_application_1/model/measure_activity.dart';
import 'package:flutter_application_1/model/medication_activity.dart';
import 'package:flutter_application_1/model/sleep_activity.dart';
import 'package:flutter_application_1/model/timer_activity.dart';
import 'package:flutter_application_1/model/tummy_activity.dart';
import 'package:flutter_application_1/model/vaccination_activity.dart';
import 'package:flutter_application_1/model/walk_activity.dart';
import 'package:flutter_application_1/services/api_controller.dart';
import 'package:flutter_application_1/utilities/keys.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../model/pumping_activity.dart';
import '../providers/all_providers.dart';
import 'health_page.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  String provNote = '';
  String printValue = '';
  var _allTimerActivities = [];
  @override
  void initState() {
    super.initState();
    _fetchAllActivitesFromApi(); // bunu öyle bi yere koymalı ki hem ref.watchtan sonra olacak hem de initStatede olacak ya da bi
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void _fetchAllActivitesFromApi() async {
    ref.read(timerActivityProvider.notifier).addAllActivities(
        await ApiController.fetchTimerActivity(ref.read(babyProfileProvider)));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    _allTimerActivities = ref.watch(timerActivityProvider);
    _allTimerActivities.sort(((a, b) => b.startTime.compareTo(a.startTime)));
    var sleepActivity = const TimerPage(activity: 'sleep');
    var breastFeedingActivity = const TimerPage(activity: 'breastfeeding');
    var bottleMilk = const ChoicePage(activity: 'Bottle milk');
    var pumping = const ChoicePage(activity: 'Pumping');
    var diaper = const ChoicePage(activity: 'Diaper');

    return Scaffold(
      backgroundColor: bckgrnd,
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: grid(context, sleepActivity, bottleMilk,
                breastFeedingActivity, pumping, diaper),
          ),
          Expanded(flex: 1, child: listVi())
        ],
      ),
    );
  }

  GridView listVi() {
    return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: 1 / 0.15,
            ),
            itemCount: _allTimerActivities.length,
            padding: EdgeInsets.all(0),
            itemBuilder: (BuildContext ctx, index) {
              return Dismissible(
                  key: ValueKey(_allTimerActivities[index].id),
                  onDismissed: (a) {
                    ref
                        .read(timerActivityProvider.notifier)
                        .remove(_allTimerActivities[index]);
                    ApiController.removeTimerActivity(
                        _allTimerActivities[index].id);
                  },
                  child:  setValue(_allTimerActivities[index]),
                  );
    }) 
    
    
    
    
    /*ListView.builder(
            shrinkWrap: true,
            itemCount: _allTimerActivities.length,
            itemBuilder: ((context, index) {
              return Dismissible(
                  key: ValueKey(_allTimerActivities[index].id),
                  onDismissed: (a) {
                    ref
                        .read(timerActivityProvider.notifier)
                        .remove(_allTimerActivities[index]);
                    ApiController.removeTimerActivity(
                        _allTimerActivities[index].id);
                  },
                  child: GestureDetector(
                    onTap: () {
                      setActivity(context, _allTimerActivities[index].id);
                    },
                    child: setValue(_allTimerActivities[index]),
                  ));
            }),
          )*/
        ;
  }

  GridView grid(
      BuildContext context,
      TimerPage sleepActivity,
      ChoicePage bottleMilk,
      TimerPage breastFeedingActivity,
      ChoicePage pumping,
      ChoicePage diaper) {
    return GridView.count(
            shrinkWrap: true,
            primary: false,
            padding: const EdgeInsets.all(10),

            crossAxisSpacing: 5,
            mainAxisSpacing: 10,
            crossAxisCount: 3,
            children: [
              Expanded(
                flex: 5,
                child: IconButton(
                  iconSize: 220,
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => sleepActivity));
                  },
                  icon: Image.asset("assets/icons/sleep.png"),
                ),
              ),
              const Expanded(
                child: Text(
                  "Sleep",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                flex: 1,
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color.fromARGB(255, 101, 201, 243)),
          child: Column(
            children: [
              Expanded(
                flex: 5,
                child: IconButton(
                  iconSize: 220,
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => bottleMilk));
                  },
                  icon: Image.asset("assets/icons/milk.png"),
                ),
              ),
              const Expanded(
                child: Text(
                  "Bottle Milk",
                  style: TextStyle(color: Colors.white),
                ),
                flex: 1,
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color.fromARGB(255, 216, 44, 44)),
          child: Column(
            children: [
              Expanded(
                flex: 5,
                child: IconButton(
                  iconSize: 220,
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => breastFeedingActivity));
                  },
                  icon: Image.asset("assets/icons/breastfeeding.png"),
                ),
              ),
              const Expanded(
                child: Text(
                  "Breastfeeding",
                  style: TextStyle(color: Colors.white),
                ),
                flex: 1,
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color.fromARGB(255, 162, 96, 94)),
          child: Column(
            children: [
              Expanded(
                flex: 5,
                child: IconButton(
                  iconSize: 220,
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => pumping));
                  },
                  icon: Image.asset("assets/icons/pumping.png"),
                ),
              ),
              const Expanded(
                child: Text(
                  "Pumping",
                  style: TextStyle(color: Colors.white),
                ),
                flex: 1,
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color.fromARGB(255, 138, 255, 183)),
          child: Column(
            children: [
              Expanded(
                flex: 5,
                child: IconButton(
                  iconSize: 220,
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                  onPressed: () {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => diaper));
                  },
                  icon: Image.asset("assets/icons/diaper.png"),
                ),
              ),
              const Expanded(
                child: Text(
                  "Diaper",
                  style: TextStyle(color: Colors.white),
                ),
                flex: 1,
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color.fromARGB(255, 209, 178, 104)),
          child: Column(
            children: [
              Expanded(
                flex: 5,
                child: IconButton(
                  iconSize: 220,
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const ActivityPage()));
                  },
                  icon: Image.asset("assets/icons/add.png"),
                ),
              ),
              const Expanded(
                child: Text(
                  "Add Activity",
                  style: TextStyle(color: Colors.white),
                ),
                flex: 1,
              ),
            ],
          ),
        ),
      ],
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

  Container setValue(Activity timerActivity) {
    if (timerActivity is SleepActivity) {
      SleepActivity a = timerActivity;
      String path = "assets/icons/sleep.png";
      return printTimerActivity(
          timerActivity, a.finishTime, a.second, path, "Sleep");
    } else if (timerActivity is TummyActivity) {
      TummyActivity a = timerActivity;
      String path = "assets/icons/tummy.png";
      return printTimerActivity(
          timerActivity, a.finishTime, a.second, path, "Tummy");
    } else if (timerActivity is WalkActivity) {
      WalkActivity a = timerActivity;
      String path = "assets/icons/walk.png";
      return printTimerActivity(
          timerActivity, a.finishTime, a.second, path, "Walk");
    } else if (timerActivity is BathActivity) {
      BathActivity a = timerActivity;
      String path = "assets/icons/bath.png";
      return printTimerActivity(
          timerActivity, a.finishTime, a.second, path, "Bath");
    } else if (timerActivity is BreastFeedingActivity) {
      BreastFeedingActivity a = timerActivity;
      String path = "assets/icons/breastfeeding.png";
      return printTimerActivity(
          timerActivity, a.finishTime, a.second, path, "BreastFeed");
    } else if (timerActivity is BottleMilkActivity) {
      BottleMilkActivity a = timerActivity;
      String path = "assets/icons/milk.png";
      return printChoiceActivity(
          timerActivity, a.type, a.amount, path, "Bottle");
    } else if (timerActivity is PumpingActivity) {
      PumpingActivity a = timerActivity;
      String path = "assets/icons/pumping.png";
      return printChoiceActivity(timerActivity, a.type, a.amount, path, "Pump");
    } else if (timerActivity is DiaperActivity) {
      DiaperActivity a = timerActivity;
      String path = "assets/icons/diaper.png";
      return printChoiceActivity(timerActivity, a.type, "", path, "Diaper");
    } else if (timerActivity is MedicationActivity) {
      MedicationActivity a = timerActivity;
      String path = "assets/icons/medication.png";
      return printHealthActivity(
          timerActivity, a.name, a.dose, a.type, path, "Medication");
    } else if (timerActivity is VaccinationActivity) {
      VaccinationActivity a = timerActivity;
      String path = "assets/icons/vaccination.png";
      return printHealthActivity(
          timerActivity, a.name, "", "", path, "Vaccination");
    } else if (timerActivity is MeasureActivity) {
      MeasureActivity a = timerActivity;
      String path = "assets/icons/measure.png";
      return printHealthActivity(
          timerActivity, a.weight, a.height, a.head, path, "Measure");
    }
    return Container();
  }

  Container printTimerActivity(
      Activity a, DateTime finishTime, int second, String path, String info) {
    var startMinute = a.startTime.minute.toString();
    var finishMinute = finishTime.minute.toString();
    if (a.startTime.minute < 10) {
      startMinute = "0" + a.startTime.minute.toString();
    }
    if (finishTime.minute < 10) {
      finishMinute = "0" + finishTime.minute.toString();
    }
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(color: Colors.black))),
      height: 55,
      child: Row(
        children: [
          Expanded(child: Image.asset(path), flex: 1),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: Text(info + " " + second.toString() + "min"),
                ),
                Expanded(
                  child: Text(
                    a.startTime.hour.toString() +
                        ":" +
                        startMinute +
                        " to " +
                        finishTime.hour.toString() +
                        ":" +
                        finishMinute + " - " + a.startTime.day.toString() +
                    "/" + a.startTime.month.toString() + '/' + a.startTime.year.toString() ,
                    style: const TextStyle(fontWeight: FontWeight.w200),
                  ),
                ),
                Expanded(
                  child: Text(
                    a.note,
                    style: const TextStyle(fontWeight: FontWeight.w200),
                  ),
                ),
              ],
            ),
            flex: 5,
          ),
          const Expanded(
            child: SizedBox(),
            flex: 1,
          )
        ],
      ),
    );
  }

  Container printChoiceActivity(
      Activity a, String type, String amount, String path, String info) {
    var startMinute = a.startTime.minute.toString();
    if (a.startTime.minute < 10) {
      startMinute = "0" + a.startTime.minute.toString();
    }
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(color: Colors.black))),
      height: 55,
      child: Row(
        children: [
          Expanded(child: Image.asset(path), flex: 1),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: Text(info != 'Diaper'
                      ? info + " (" + type + "):" + " " + amount + " ml"
                      : info + ": " + type),
                ),
                Expanded(
                  child: Text(
                    a.startTime.hour.toString() + ":" + startMinute + " - " + a.startTime.day.toString() +
                    "/" + a.startTime.month.toString() + '/' + a.startTime.year.toString() ,
                    style: const TextStyle(fontWeight: FontWeight.w200),
                  ),
                ),
                Expanded(
                  child: Text(
                    a.note,
                    style: const TextStyle(fontWeight: FontWeight.w200),
                  ),
                ),
              ],
            ),
            flex: 7,
          ),
          const Expanded(
            child: SizedBox(),
            flex: 1,
          )
        ],
      ),
    );
  }

  Container printHealthActivity(Activity a, String input1, String input2,
      String input3, String path, String info) {
    var startMinute = a.startTime.minute.toString();
    if (a.startTime.minute < 10) {
      startMinute = "0" + a.startTime.minute.toString();
    }
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(color: Colors.black))),
      height: 55,
      child: Row(
        children: [
          Expanded(child: Image.asset(path), flex: 1),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      info == 'Medication'
                          ? info + ": " + input1 + ": " + input2 + input3
                          : info == 'Vaccination'
                              ? info + ": " + input1
                              : "Weight:" +
                                  input1 +
                                  "kg Height:" +
                                  input2 +
                                  "cm Head:" +
                                  input3 +
                                  "cm",
                    ),
                  ),
                  flex: 1,
                ),
                Expanded(
                  child: Text(
                    a.startTime.hour.toString() + ":" + startMinute + " - " + a.startTime.day.toString() +
                    "/" + a.startTime.month.toString() + '/' + a.startTime.year.toString() ,
                    style: const TextStyle(fontWeight: FontWeight.w200),
                  ),
                ),
                Expanded(
                  child: Text(
                    a.note,
                    style: const TextStyle(fontWeight: FontWeight.w200),
                  ),
                ),
              ],
            ),
            flex: 7,
          ),
          const Expanded(
            child: SizedBox(),
            flex: 1,
          )
        ],
      ),
    );
  }
}
