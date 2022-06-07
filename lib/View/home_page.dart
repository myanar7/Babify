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
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
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
    var sleepActivity = const TimerPage(activity: 'sleep');
    var breastFeedingActivity = const TimerPage(activity: 'breastfeeding');
    var bottleMilk = const ChoicePage(activity: 'Bottle milk');
    var pumping = const ChoicePage(activity: 'Pumping');
    var diaper = const ChoicePage(activity: 'Diaper');

    return Scaffold(
        backgroundColor: Color.fromARGB(255, 205, 202, 194),
        body: ListView(
          children: <Widget>[
            GridView.count(
              shrinkWrap: true,
              primary: false,
              padding: const EdgeInsets.all(10),
              crossAxisSpacing: 5,
              mainAxisSpacing: 10,
              crossAxisCount: 3,
              children: [
                Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Color.fromARGB(89, 139, 144, 146)),
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
                                builder: (context) => sleepActivity));
                          },
                          icon: Image.asset("assets/icons/sleep.png"),
                        ),
                      ),
                      const Expanded(
                        child: Text(
                          "Sleep",
                          style: TextStyle(color: Colors.white,),
                        ),
                        flex: 1,
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Color.fromARGB(255, 101, 201, 243)),
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
                                builder: (context) => bottleMilk));
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
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Color.fromARGB(255, 216, 44, 44)),
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
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Color.fromARGB(255, 162, 96, 94)),
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
                                builder: (context) => pumping));
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
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Color.fromARGB(255, 138, 255, 183)),
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
                                builder: (context) => diaper));
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
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Color.fromARGB(255, 209, 178, 104)),
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
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: _allTimerActivities.length,
              itemBuilder: ((context, index) {
                return Dismissible(
                    key: ValueKey(_allTimerActivities[index].id),
                    onDismissed: (a) {
                      ref
                          .read(timerActivityProvider.notifier)
                          .remove(_allTimerActivities[index]);
                    },
                    child: GestureDetector(
                      onTap: () {
                        setActivity(context, _allTimerActivities[index].id);
                      },
                      child: Text(setValue(_allTimerActivities[index])),
                    ));
              }),
            ),
          ],
        ));
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

  String setValue(Activity timerActivity) {
    if (timerActivity is SleepActivity) {
      SleepActivity a = timerActivity;
      return a.second.toString() +
          ' ' +
          a.note +
          ' sleep ' +
          a.finishTime.toString();
    } else if (timerActivity is TummyActivity) {
      return timerActivity.second.toString() +
          ' ' +
          timerActivity.note +
          ' tummy';
    } else if (timerActivity is BreastFeedingActivity) {
      return timerActivity.second.toString() +
          ' ' +
          timerActivity.note +
          ' breastfeeding';
    } else if (timerActivity is WalkActivity) {
      return timerActivity.second.toString() +
          ' ' +
          timerActivity.note +
          ' walk';
    } else if (timerActivity is BathActivity) {
      return timerActivity.second.toString() +
          ' ' +
          timerActivity.note +
          ' bath';
    } else if (timerActivity is BottleMilkActivity) {
      BottleMilkActivity a = timerActivity;
      return a.type + ' ' + a.amount + a.note + ' bottleMilk';
    } else if (timerActivity is PumpingActivity) {
      PumpingActivity a = timerActivity;
      return a.type + ' ' + a.amount + a.note + ' pumping';
    } else if (timerActivity is DiaperActivity) {
      DiaperActivity a = timerActivity;
      return a.type + ' ' + a.note + ' diaper';
    } else if (timerActivity is MedicationActivity) {
      MedicationActivity a = timerActivity;
      return a.type +
          ' ' +
          a.dose +
          ' ' +
          a.note +
          ' ' +
          a.name +
          ' medication';
    } else if (timerActivity is VaccinationActivity) {
      VaccinationActivity a = timerActivity;
      return a.name + ' ' + a.note + ' vaccination';
    } else if (timerActivity is MeasureActivity) {
      MeasureActivity a = timerActivity;
      return a.height +
          ' ' +
          a.weight +
          ' ' +
          a.head +
          ' ' +
          a.note +
          ' measure';
    }
    return '';
  }
}
