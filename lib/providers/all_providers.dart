import 'package:flutter_application_1/model/photo_model.dart';
import 'package:flutter_application_1/model/sleep_activity.dart';
import 'package:flutter_application_1/providers/photo_provider.dart';
import 'package:flutter_application_1/providers/sleep_activity_manager.dart';
import 'package:flutter_application_1/providers/tummy_activity_manager.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../model/tummy_activity.dart';

final sleepActivityProvider =
    StateNotifierProvider<SleepActivityManager, List<SleepActivity>>((ref) {
  return SleepActivityManager([]);
});

final tummyActivityProvider =
    StateNotifierProvider<TummyActivityManager, List<TummyActivity>>((ref) {
  return TummyActivityManager([]);
});

final photoAlbumProvider =
    StateNotifierProvider<PhotoProviderManager, List<PhotoModel>>((ref) {
  return PhotoProviderManager([]);
});
