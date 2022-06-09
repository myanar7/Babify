import 'dart:io';

import 'package:flutter_application_1/model/baby.dart';

class User {
  String id;
  String photoPath;
  final String username;
  final String email;
  List<Baby> babies = [];

  User({
    required this.id,
    required this.photoPath,
    required this.username,
    required this.email,
  });
}
