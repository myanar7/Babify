import 'package:uuid/uuid.dart';

class Baby {
  String id;
  String photoPath;
  String name;
  DateTime birthday; // get age using AgeCalculator.age(birthday)
  double height;
  double weight;
  static int currentIndex = 0;

  Baby({
    required this.id,
    required this.photoPath,
    required this.name,
    required this.birthday,
    required this.height,
    required this.weight,
  });

  factory Baby.create({
    required photoPath,
    required name,
    required birthday,
    required height,
    required weight,
  }) {
    return Baby(
        id: const Uuid().v4(),
        photoPath: photoPath,
        name: name,
        birthday: birthday,
        height: height,
        weight: weight);
  }
  void setBaby(Baby baby) {
    id = baby.id;
    photoPath = baby.photoPath;
    name = baby.name;
    birthday = baby.birthday;
    height = baby.height;
    weight = baby.weight;
  }

  factory Baby.fromJson(Map<String, dynamic> json) {
    return Baby(
        id: json['id'].toString(),
        photoPath: json['photoURL'],
        name: json['name'],
        birthday: DateTime.parse(json['birthDay']),
        height: json['height'],
        weight: json['weight']);
  }
}
