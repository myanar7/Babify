import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/providers/all_providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SleepPage extends ConsumerStatefulWidget {
  const SleepPage({Key? key}) : super(key: key);

  @override
  ConsumerState<SleepPage> createState() => _SleepPageState();
}

class _SleepPageState extends ConsumerState<SleepPage> {
  Duration duration = Duration();
  DateTime startTime = DateTime.now();
  var _dateController = true;
  var _controller = false;
  Timer? timer;

  @override
  void initState() {
    
    super.initState();
    reset();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add sleep'),
      ),
      body: ListView(
        children: [
          buildTime(),
          _controller
              ? ElevatedButton(onPressed: () {
                timer?.cancel();
                _controller = false;
                setState(() {
                  
                });
              }, child: Text('Stop'))
              : ElevatedButton(onPressed: () {
                startTimer();
                _controller = true;
                if(_dateController){
                  _dateController = false;
                  startTime = DateTime.now();
                }
                setState(() {
                  
                });
                
              }, child: Text('Start')),
          ElevatedButton(onPressed: () {
            int second = duration.inSeconds;
            reset();
            _controller = false;
            timer?.cancel();
            setState(() {
              
            });
            _dateController = true;
            DateTime endTime = DateTime.now();
            ref.read(sleepActivityProvider.notifier).addSleepActivity(startTime, endTime, second);
          }, child: Text('Cancel'))
        ],
      ),
    );
  }

  buildTime() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    final hour = twoDigits(duration.inHours);
    return Text(
      '$hour:$minutes:$seconds',
      style: const TextStyle(fontSize: 80), 
    );
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) => addTime());
  }

  addTime() {
    final addSeconds = 1;
    setState(() {
      final seconds = duration.inSeconds + addSeconds;
      duration = Duration(seconds: seconds);
    });
  }

  void reset() {
    setState(() {
      duration = Duration();
    });
  }
}
