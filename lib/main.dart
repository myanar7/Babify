import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/album_page.dart';
import 'package:flutter_application_1/View/comment_page.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

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
        primarySwatch: Colors.amber,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late TabController _controller;

  List<Widget> list = [
    const Tab(icon: Icon(Icons.card_travel)),
    const Tab(icon: Icon(Icons.add_shopping_cart)),
    const Tab(icon: Icon(Icons.photo)),
    const Tab(icon: Icon(Icons.comment)),
  ];

  @override
  void initState() {
    super.initState();
    // Create TabController for getting the index of current tab
    _controller = TabController(length: list.length, vsync: this);

    _controller.addListener(() {
      setState(() {});
      print("Selected Index: " + _controller.index.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            onTap: (index) {
              // Should not used it as it only called when tab options are clicked,,
              // not when user swapped
            },
            controller: _controller,
            tabs: list,
          ),
          title: const Text('Tabs Demo'),
        ),
        body: TabBarView(
          controller: _controller,
          children: const [HomePage(), HomePage(), AlbumPage(), CommentPage()],
        ),
      ),
    );
  }
}
