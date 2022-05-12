import 'dart:async';

class MyTimer {
  late Timer _timer;
  Duration _duration = Duration();
  String _minutes = '';
  String _seconds = '';
  String _hour = '';

  String get hour => _hour;
  String get minutes => _minutes;
  String get seconds => _seconds;
  Timer get timer => _timer;

  buildTime() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    _minutes = twoDigits(_duration.inMinutes.remainder(60));
    _seconds = twoDigits(_duration.inSeconds.remainder(60));
    _hour = twoDigits(_duration.inHours);
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => addTime());
  }

  addTime() {
    final addSeconds = 1;
    final seconds = _duration.inSeconds + addSeconds;
    _duration = Duration(seconds: seconds);
  }

   void reset() {
    _duration = Duration();
  }
}