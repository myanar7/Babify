import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/new_baby_profile.dart';
import 'package:flutter_application_1/model/baby.dart';
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

  Future _showNewBabyProfile() async {
    // push a new route like you did in the last section
    Baby baby = await Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context) {
        return const NewBabyProfilePage();
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 227, 233, 236),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
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

          //IconButton(icon: Icon(Icons.add), onPressed: _showNewBabyProfile),
          Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(16),
                child: Text(resultText),
              ),
              // RaisedButton(
              //   onPressed: () {
              //     showAccountSelectorSheet(
              //       context: context,
              //       accountList: _allBabies,
              //       isSheetDismissible: false, //Optional
              //       initiallySelectedIndex: 2, //Optional
              //       hideSheetOnItemTap: true,
              //       showAddAccountOption: true, //Optional
              //       backgroundColor: Colors.indigo, //Optional
              //       arrowColor: Colors.white, //Optional
              //       unselectedRadioColor: Colors.white, //Optional
              //       selectedRadioColor: Colors.amber, //Optional
              //       unselectedTextColor: Colors.white, //Optional
              //       selectedTextColor: Colors.amber, //Optional
              //       //Optional
              //       tapCallback: (index) {
              //         ref
              //             .read(babyProfileProvider.notifier)
              //             .changeBabyProfile(index);
              //       },
              //       //Optional
              //       addAccountTapCallback: () {
              //         setState(() {
              //           resultText = "Add account clicked";
              //           _showNewBabyProfile();
              //         });
              //         print(resultText);
              //       },
              //     );
              //   },
              //   child: Text("Select Baby"),
              // ),
            ],
          ))
        ],
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
