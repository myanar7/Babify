import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/baby_profile_page.dart';
import 'package:flutter_application_1/model/baby.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/providers/all_providers.dart';
import 'package:flutter_application_1/providers/baby_profile_manager.dart';
import 'package:flutter_application_1/services/api_controller.dart';
import 'package:flutter_application_1/utilities/keys.dart';
import 'package:flutter_riverpod/src/consumer.dart';
import 'package:flutter_application_1/widget/appbar_widget.dart';
import 'package:flutter_application_1/model/baby_account.dart';

class NewBabyProfilePage extends ConsumerStatefulWidget {
  const NewBabyProfilePage({Key? key}) : super(key: key);

  @override
  ConsumerState<NewBabyProfilePage> createState() => _NewBabyProfilePageState();
}

class _NewBabyProfilePageState extends ConsumerState<NewBabyProfilePage> {
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
        firstDate: DateTime(DateTime.now().year-3, DateTime.now().month),
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
      backgroundColor: Color.fromARGB(255, 244, 197, 243),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 5,
            horizontal: 20,
          ),
          child: Column(children: [
            Expanded(flex: 2,child: userInput(nameController, 'Name', TextInputType.text)),
            Expanded(flex:2 ,child: userInput(heightController, 'Height (cm)', TextInputType.number)),
            Expanded(flex:2, child: userInput(weightController, 'Weight (kg)', TextInputType.number)),
            Expanded(flex: 1, child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Expanded(child: SizedBox(
                  height: 10.0,
                )),
                Expanded(child: RaisedButton(
                  onPressed: () => _selectDate(context),
                  child: Text('Select birthdate'),
                  color: Colors.pink[100],
                )),
              ],
            )),
            Expanded(flex:1 ,child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Builder(
                builder: (context) {
                  return RaisedButton(
                    onPressed: () => submitBaby(context),
                    color: Colors.pink[100],
                    child: Text('Create Baby Account'),
                  );
                },
              ),
            )),
            Expanded(flex:1, child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Expanded(child: Padding(
                  padding: EdgeInsets.all(16),
                ),)
              ],
            )))
          ]),
        ),
      ),
    );
  }

  Widget userInput(TextEditingController userInput, String hintTitle,
      TextInputType keyboardType) {
    return Container(
      height: 55,
      margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
          color: Colors.white70, borderRadius: BorderRadius.circular(30)),
      child: Padding(
        padding: const EdgeInsets.only(left: 25.0, top: 15, right: 25),
        child: TextField(
          maxLength: hintTitle == 'Name' ? 20 : 3,
          controller: userInput,
          autocorrect: false,
          enableSuggestions: false,
          autofocus: false,
          decoration: InputDecoration.collapsed(
            hintText: hintTitle,
            hintStyle: TextStyle(
                fontSize: 18,
                color: Colors.grey[350],
                fontStyle: FontStyle.italic),
          ),
          keyboardType: keyboardType,
        ),
      ),
    );
  }

  // You'll need the context in order for the Navigator to work.
  void submitBaby(BuildContext context) async {
    //print("hereee");
    // First make sure there is some information in the form.
    // A dog needs a name, but may be location independent,
    // so we'll only abandon the save if there's no name.
    if (nameController.text.isEmpty) {
      print('Baby needs a name!');
    } else {
      // Create a new dog with the information from the form.

      var newBaby = await ApiController.postBaby(
          ref,
          nameController.text,
          selectedDate,
          double.parse(heightController.text),
          double.parse(weightController.text));

      //print(newBaby.name);
      // Pop the page off the route stack and pass the new
      // dog back to wherever this page was created.

      ref.read(babyProfileProvider.notifier).addBabyProfile(newBaby);
      if(ref.read(babyProfileProvider).length != 1){
        Navigator.pop(context);
      }
      //Navigator.of(context).pushNamed('/baby_profile_page');
    }
  }
}
