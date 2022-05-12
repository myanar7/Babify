import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/my_timer.dart';
import 'package:flutter_application_1/providers/all_providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SleepPage extends ConsumerStatefulWidget {
  const SleepPage({Key? key}) : super(key: key);

  @override
  ConsumerState<SleepPage> createState() => _SleepPageState();
}

class _SleepPageState extends ConsumerState<SleepPage> {
  MyTimer timer = MyTimer();
  DateTime startTime = DateTime.now();
  var _dateController = true;
  var _controller = false;

  @override
  void initState() {
    super.initState();
    timer.reset();
  }

  @override
  Widget build(BuildContext context) {
    timer.buildTime();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add sleep'),
      ),
      body: ListView(
        children: [
          Text( timer.hour + ':' + timer.minutes + ':' + timer.seconds,
            style: TextStyle(fontSize: 80),
          ),
          _controller
              ? ElevatedButton(
                  onPressed: () {
                    timer.timer.cancel();
                    _controller = false;
                    setState(() {});
                  },
                  child: Text('Stop'))
              : ElevatedButton(
                  onPressed: () {
                    timer.startTimer();
                    _controller = true;
                    if (_dateController) {
                      _dateController = false;
                      startTime = DateTime.now();
                    }
                    setState(() {});
                  },
                  child: Text('Start')),
          ElevatedButton(
              onPressed: () {
                int second = timer.duration.inSeconds;
                timer.reset();
                _controller = false;
                timer.timer.cancel();
                setState(() {});
                _dateController = true;
                DateTime endTime = DateTime.now();
                ref
                    .read(sleepActivityProvider.notifier)
                    .addSleepActivity(startTime, endTime, second);
              },
              child: Text('Cancel'))
        ],
      ),
    );
  }
}
