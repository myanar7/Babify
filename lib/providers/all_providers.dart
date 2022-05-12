import 'package:flutter_application_1/model/photo_model.dart';
import 'package:flutter_application_1/model/sleep_activity.dart';
import 'package:flutter_application_1/providers/photo_provider.dart';
import 'package:flutter_application_1/providers/sleep_activity_manager.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final sleepActivityProvider =
    StateNotifierProvider<SleepActivityManager, List<SleepActivity>>((ref) {
  return SleepActivityManager([]);
});
final photoAlbumProvider =
    StateNotifierProvider<PhotoProviderManager, List<PhotoModel>>((ref) {
  return PhotoProviderManager([]);
});
