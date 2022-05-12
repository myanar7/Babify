import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/sleep_page.dart';
import 'package:flutter_application_1/providers/all_providers.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var _allSleepActivities = ref.watch(sleepActivityProvider);    
    return Scaffold(
      body: ListView(
        children: [
          IconButton(onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SleepPage()));
          }, icon: const Icon(Icons.add),),
          ListView.builder(shrinkWrap: true,itemCount: _allSleepActivities.length,itemBuilder: ((context, index) {
            return Dismissible(
              key: ValueKey(_allSleepActivities[index].id),
              onDismissed: (a){
                ref.read(sleepActivityProvider.notifier).remove(_allSleepActivities[index]);
              },
              child: Text(_allSleepActivities[index].second.toString()),
            );
          }),)
        ],
      )
      
    );

    
  }
}



