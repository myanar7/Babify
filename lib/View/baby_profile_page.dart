import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/new_baby_profile.dart';
import 'package:flutter_application_1/model/baby.dart';
import 'package:flutter_application_1/services/api_controller.dart';
import 'package:flutter_application_1/utilities/keys.dart';
import 'package:flutter_application_1/widget/profile_widget.dart';
import 'package:age_calculator/age_calculator.dart';
import 'package:flutter_application_1/providers/all_providers.dart';
// ignore: implementation_imports
import 'package:flutter_riverpod/src/consumer.dart';
import 'package:flutter_application_1/View/account_selector.dart';

class BabyProfilePage extends ConsumerStatefulWidget {
  late final Baby baby;

  BabyProfilePage({Key? key, required this.baby}) : super(key: key);

  @override
  ConsumerState<BabyProfilePage> createState() => _BabyProfilePageState();
}

class _BabyProfilePageState extends ConsumerState<BabyProfilePage> {
  String resultText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bckgrnd,
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 20.0,
              ),
            ),
            ProfileWidget(
              imagePath: widget.baby.photoPath,
            ),
            buildName(),
            buildInfo(),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(16),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Builder(
                builder: (context) {
                  return RaisedButton(
                    onPressed: () {
                      ApiController.removeBaby(widget.baby.id);
                      ref
                          .read(babyProfileProvider.notifier)
                          .removeBabyProfile(widget.baby.id);
                      Baby.currentIndex = 0;
                    },
                    color: Colors.red,
                    child: const Text(
                      'Delete Baby',
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildName() => Column(
        children: [
          Text(
            widget.baby.name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 6),
          Text(
            AgeCalculator.age(widget.baby.birthday).toString(),
            style: TextStyle(color: Colors.grey),
          )
        ],
      );

  Widget buildInfo() => Container(
        padding: EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '\n\nHeight: ' + widget.baby.height.toString() + " cm\n",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'Weight: ' + widget.baby.weight.toString() + " kg",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
}
