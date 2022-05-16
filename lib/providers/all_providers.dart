import 'package:flutter_application_1/model/photo_model.dart';
import 'package:flutter_application_1/providers/photo_provider.dart';
import 'package:flutter_application_1/providers/timer_activity_manager.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../model/timer_activity.dart';




final photoAlbumProvider =
    StateNotifierProvider<PhotoProviderManager, List<PhotoModel>>((ref) {
  return PhotoProviderManager([]);
});

final timerActivityProvider =
    StateNotifierProvider<TimerActivityManager, List<TimerActivity>>((ref) {
  return TimerActivityManager([]);
});