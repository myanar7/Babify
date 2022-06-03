import 'package:flutter/material.dart';
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
    ref
        .read(timerActivityProvider.notifier)
        .addAllActivities(await ApiController.fetchTimerActivity());
  }

  @override
  Widget build(BuildContext context) {
    _allTimerActivities = ref.watch(timerActivityProvider);
    var sleepActivity = const TimerPage(activity: 'sleep');
    var tummyActivity = const TimerPage(activity: 'tummy');
    var walkActivity = const TimerPage(activity: 'walk');
    var breastFeedingActivity = const TimerPage(activity: 'breastfeeding');
    var bathActivity = const TimerPage(activity: 'bath');
    var bottleMilk = const ChoicePage(activity: 'Bottle milk');
    var pumping = const ChoicePage(activity: 'Pumping');
    var diaper = const ChoicePage(activity: 'Diaper');
    var medication = const HealthPage(
      activity: 'Medication',
    );
    var vaccination = const HealthPage(
      activity: 'Vaccination',
    );
    var measure = const HealthPage(
      activity: 'Measure',
    );

    return Scaffold(
        body: ListView(
      children: <Widget>[
        GridView.count(
          shrinkWrap: true,
          primary: false,
          padding: const EdgeInsets.all(20),
          crossAxisSpacing: 25,
          mainAxisSpacing: 25,
          crossAxisCount: 3,
          children: [
            IconButton(
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => sleepActivity));
              },
              icon: Image.asset("assets/icons/sleep.png"),
            ),
            IconButton(
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => tummyActivity));
              },
              icon: Image.asset("assets/icons/tummy.png"),
            ),
            IconButton(
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(),
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => breastFeedingActivity));
              },
              icon: Image.asset("assets/icons/breastfeeding.png"),
            ),
            IconButton(
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => walkActivity));
              },
              icon: Image.asset("assets/icons/walk.png"),
            ),
            IconButton(
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => bathActivity));
              },
              icon: Image.asset("assets/icons/bath.png"),
            ),
            IconButton(
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => bottleMilk));
              },
              icon: Image.asset("assets/icons/milk.png"),
            ),
            IconButton(
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => pumping));
              },
              icon: Image.asset("assets/icons/pumping.png"),
            ),
            IconButton(
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => diaper));
              },
              icon: Image.asset("assets/icons/diaper.png"),
            ),
            IconButton(
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => medication));
              },
              icon: Image.asset("assets/icons/medication.png"),
            ),
            IconButton(
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => vaccination));
              },
              icon: Image.asset("assets/icons/vaccination.png"),
              color: Colors.white,
              iconSize: 100,
            ),
            IconButton(
              padding: EdgeInsets.zero,
              constraints: BoxConstraints(),
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => measure));
              },
              icon: Image.asset("assets/icons/measure.png"),
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
