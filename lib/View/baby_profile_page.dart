import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/new_baby_profile.dart';
import 'package:flutter_application_1/model/baby.dart';
import 'package:flutter_application_1/widget/appbar_widget.dart';
import 'package:flutter_application_1/widget/profile_widget.dart';
import 'package:age_calculator/age_calculator.dart';
import 'package:flutter_application_1/providers/all_providers.dart';
import 'package:flutter_application_1/providers/baby_profile_manager.dart';
import 'package:flutter_riverpod/src/consumer.dart';

class BabyProfilePage extends StatefulWidget {
  final Baby baby;

  const BabyProfilePage({Key? key, required this.baby}) : super(key: key);

  @override
  _BabyProfilePageState createState() => _BabyProfilePageState();
}

class _BabyProfilePageState extends State<BabyProfilePage> {
  List<Baby> initialBabies = [];

  Future _showNewBabyProfile() async {
    // push a new route like you did in the last section
    Baby baby = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return NewBabyProfilePage();
        },
      ),
    );
    // A null check, to make sure that the user didn't abandon the form.

    if (baby.name != null) {
      // Add a newDog to our mock dog array.
      setState(() => initialBabies.add(baby));
      //ref(babyProfileProvider.notifier).addBabyProfile(baby);
      print(initialBabies);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile page'),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          ProfileWidget(
            imagePath: widget.baby.photoPath,
            onClicked: () async {},
          ),
          buildName(),
          buildInfo(),
          IconButton(icon: Icon(Icons.add), onPressed: _showNewBabyProfile),
        ],
      ),
    );
  }

  Widget buildName() => Column(
        children: [
          Text(
            widget.baby.name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
              '\n\nHeight: ' + widget.baby.height.toString() + "\n",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              'Weight: ' + widget.baby.weight.toString(),
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
}
