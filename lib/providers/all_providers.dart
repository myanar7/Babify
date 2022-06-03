import 'package:flutter_application_1/model/photo_model.dart';
import 'package:flutter_application_1/providers/photo_provider.dart';
import 'package:flutter_application_1/providers/timer_activity_manager.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import '../model/timer_activity.dart';
import 'package:web_socket_channel/io.dart';
import 'package:flutter_application_1/providers/baby_profile_manager.dart';
import 'package:flutter_application_1/model/baby.dart';

final photoAlbumProvider =
    StateNotifierProvider<PhotoProviderManager, List<PhotoModel>>((ref) {
  return PhotoProviderManager([]);
});

final timerActivityProvider =
    StateNotifierProvider<TimerActivityManager, List<Activity>>((ref) {
  return TimerActivityManager([]);
});
final babyProfileProvider =
    StateNotifierProvider<BabyProfileManager, List<Baby>>((ref) {
  return BabyProfileManager([]);
});
final commentProvider = StreamProvider.autoDispose<List<String>>((ref) async* {
  // https://www.piesocket.com/websocket-tester to test your Web Socket Connection
  // Open the connection
  final channel = IOWebSocketChannel.connect(
      'wss://demo.piesocket.com/v3/channel_1?api_key=VCXCEuvhGcBDP7XhiJJUDvR1e1D3eiVjgZ9VRiaV&notify_self');

  // Close the connection when the stream is destroyed
  ref.onDispose(() => channel.sink.close());

  // Parse the value received and emit a Message instance
  List<String> _list =
      []; // for now this list is empty initially but when we re done with this part previous messages list must be taken from database
  await for (final value in channel.stream) {
    _list.add(value.toString());
    yield _list;
  }
});
