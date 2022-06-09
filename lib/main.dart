import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/account_selector.dart';
import 'package:flutter_application_1/View/album_page.dart';
import 'package:flutter_application_1/View/color_match_game_page.dart';
import 'package:flutter_application_1/View/comment_page.dart';
import 'package:flutter_application_1/View/new_baby_profile.dart';
import 'package:flutter_application_1/View/baby_profile_page.dart';
import 'package:flutter_application_1/View/sign_in_page.dart';
import 'package:flutter_application_1/View/user_profile.dart';
import 'package:flutter_application_1/model/baby.dart';
import 'package:flutter_application_1/model/user.dart';
import 'package:flutter_application_1/providers/all_providers.dart';
import 'package:flutter_application_1/services/api_controller.dart';
import 'package:flutter_application_1/utilities/keys.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_application_1/View/entertainment_page.dart';
import 'View/home_page.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: const SignInPage(),
    );
  }
}

class MyHomePage extends ConsumerStatefulWidget {
  late final User user;

  MyHomePage({Key? key, required this.user}) : super(key: key);

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage>
    with TickerProviderStateMixin {
  late TabController _controller;

  List<Widget> list = [
    const Tab(icon: Icon(Icons.apps)),
    const Tab(icon: Icon(Icons.account_box)),
    const Tab(icon: Icon(Icons.video_collection)),
    const Tab(icon: Icon(Icons.photo)),
    const Tab(icon: Icon(Icons.comment)),
    const Tab(icon: Icon(Icons.gamepad)),
  ];

  @override
  void initState() {
    super.initState();
    // Create TabController for getting the index of current tab
    _controller = TabController(length: list.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    var _allBabies = ref.watch(babyProfileProvider);
    List accountList = createBabyAccountList(_allBabies);
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: apbr,
          leading: IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UserProfilePage(
                            user: widget.user,
                          )));
            },
          ),
          actions: [
            IconButton(
                onPressed: () {
                  if (ref.read(babyProfileProvider).isNotEmpty) {
                    showAccountSelectorSheet(
                      context: context,
                      accountList: accountList,
                      initiallySelectedIndex: Baby.currentIndex,
                      isSheetDismissible: false, //Optional
                      hideSheetOnItemTap: true,
                      showAddAccountOption: true, //Optional
                      backgroundColor: Colors.indigo, //Optional
                      arrowColor: Colors.white, //Optional
                      unselectedRadioColor: Colors.white, //Optional
                      selectedRadioColor: Colors.amber, //Optional
                      unselectedTextColor: Colors.white, //Optional
                      selectedTextColor: Colors.amber, //Optional
                      //Optional
                      tapCallback: (index) async {
                        setState(() {
                          ref
                              .read(babyProfileProvider.notifier)
                              .changeBabyProfile(index);
                        });
                        ref
                            .read(timerActivityProvider.notifier)
                            .addAllActivities(
                                await ApiController.fetchTimerActivity(
                                    ref.read(babyProfileProvider)));
                      },
                      //Optional
                      addAccountTapCallback: () {
                        setState(() {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const NewBabyProfilePage()),
                          );
                        });
                      },
                    );
                  }
                },
                icon: const Icon(Icons.person))
          ],
          bottom: TabBar(
            onTap: (index) {
              // Should not used it as it only called when tab options are clicked,
              // not when user swapped
            },
            controller: _controller,
            tabs: list,
          ),
          title: const Text('Babify App Bar'),
        ),
        body: TabBarView(
          controller: _controller,
          children: [
            HomePage(),
            if (_allBabies.isNotEmpty)
              BabyProfilePage(baby: _allBabies[Baby.currentIndex])
            else
              NewBabyProfilePage(),
            EntartainmentPage(),
            AlbumPage(),
            CommentPage(),
            ColorGame(),
          ],
        ),
      ),
    );
  }

  List createBabyAccountList(var _allBabies) {
    List<Baby> accountList = [];
    for (int i = 0; i < _allBabies.length; i++) {
      accountList.add(_allBabies[i]);
    }
    return accountList;
  }
}
