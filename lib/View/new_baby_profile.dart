import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/baby_profile_page.dart';
import 'package:flutter_application_1/model/baby.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/providers/all_providers.dart';
import 'package:flutter_application_1/providers/baby_profile_manager.dart';
import 'package:flutter_riverpod/src/consumer.dart';
import 'package:flutter_application_1/widget/appbar_widget.dart';

class NewBabyProfilePage extends StatefulWidget {
  const NewBabyProfilePage({Key? key}) : super(key: key);

  @override
  _NewBabyProfilePageState createState() => _NewBabyProfilePageState();
}

class _NewBabyProfilePageState extends State<NewBabyProfilePage> {
  // One TextEditingController for each form input:

  final nameController = TextEditingController();

  TextEditingController photoPathController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime.now());
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String _getRegexString() => true ? r'[0-9]+[,.]{0,1}[0-9]*' : r'[0-9]';

    inputFormatters:
    <TextInputFormatter>[
      FilteringTextInputFormatter.allow(RegExp(_getRegexString())),
      TextInputFormatter.withFunction(
        (oldValue, newValue) => newValue.copyWith(
          text: newValue.text.replaceAll('.', ','),
        ),
      ),
    ];

    return Scaffold(
      appBar: buildAppBar(context),
      body: Container(
        //color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 8.0,
            horizontal: 32.0,
          ),
          child: Column(children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                hintText: "Name",
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: () {
                    nameController.clear();
                  },
                  icon: const Icon(Icons.clear),
                ),
              ),
            ),
            SizedBox(height: 30),
            TextField(
              controller: heightController,
              decoration: InputDecoration(
                hintText: "Height",
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: () {
                    heightController.clear();
                  },
                  icon: const Icon(Icons.clear),
                ),
              ),
            ),
            SizedBox(height: 30),
            TextField(
              controller: weightController,
              decoration: InputDecoration(
                hintText: "Weight",
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: () {
                    weightController.clear();
                  },
                  icon: const Icon(Icons.clear),
                ),
              ),
            ),
            SizedBox(height: 30),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text("${selectedDate.toLocal()}".split(' ')[0]),
                SizedBox(
                  height: 20.0,
                ),
                RaisedButton(
                  onPressed: () => _selectDate(context),
                  child: Text('Select birthdate'),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Builder(
                builder: (context) {
                  return RaisedButton(
                    onPressed: () => submitBaby(context),
                    color: Colors.indigoAccent,
                    child: Text('Submit Baby'),
                  );
                },
              ),
            ),
          ]),
        ),
      ),
    );
  }

  // You'll need the context in order for the Navigator to work.
  void submitBaby(BuildContext context) {
    //print("hereee");
    // First make sure there is some information in the form.
    // A dog needs a name, but may be location independent,
    // so we'll only abandon the save if there's no name.
    if (nameController.text.isEmpty) {
      print('Baby needs a name!');
    } else {
      // Create a new dog with the information from the form.
      var newBaby = Baby(
          id: "2",
          photoPath:
              'https://images.pexels.com/photos/1556706/pexels-photo-1556706.jpeg?cs=srgb&dl=pexels-daniel-reche-1556706.jpg&fm=jpg',
          name: nameController.text,
          birthday: selectedDate,
          height: int.parse(heightController.text),
          weight: int.parse(weightController.text));

      //print(newBaby.name);
      // Pop the page off the route stack and pass the new
      // dog back to wherever this page was created.

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => BabyProfilePage(
                    baby: newBaby,
                  )));
      //Navigator.of(context).pushNamed('/baby_profile_page');
    }
  }
}
