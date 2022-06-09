import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/new_baby_profile.dart';
import 'package:flutter_application_1/model/baby.dart';
import 'package:flutter_application_1/utilities/keys.dart';
import 'package:flutter_application_1/widget/profile_widget.dart';
import 'package:age_calculator/age_calculator.dart';
import 'package:flutter_application_1/providers/all_providers.dart';
import 'package:flutter_application_1/services/api_controller.dart';
import 'package:flutter_riverpod/src/consumer.dart';
import 'package:flutter_application_1/View/account_selector.dart';

import '../model/user.dart';
import '../widget/appbar_widget.dart';

class UserProfilePage extends ConsumerStatefulWidget {
  late final User user;

  UserProfilePage({Key? key, required this.user}) : super(key: key);

  @override
  ConsumerState<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends ConsumerState<UserProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      backgroundColor: bckgrnd,
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          ProfileWidget(
            imagePath: widget.user.photoPath,
          ),
          const SizedBox(height: 24),
          buildInfo(),
          const SizedBox(height: 24),
          const SizedBox(height: 24),
          const SizedBox(height: 48),
        ],
      ),
    );
  }

  Widget buildInfo() => Container(
        padding: EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          children: [
            Text(widget.user.username, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            //Text(
            //widget.user.email,
            //style: const TextStyle(color: Colors.grey),
//),
            const Text(
              "Babies: ",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            for (var baby in ref.read(babyProfileProvider))
              Text(
                baby.name.toString(),
                style: const TextStyle(fontSize: 16),
              )
          ],
        ),
      );
}
