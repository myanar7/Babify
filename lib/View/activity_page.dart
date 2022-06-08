import 'package:flutter/material.dart';
import 'package:flutter_application_1/View/timer_page.dart';

import 'choice_page.dart';
import 'health_page.dart';

class ActivityPage extends StatefulWidget {
  const ActivityPage({ Key? key }) : super(key: key);

  @override
  State<ActivityPage> createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add activity"), backgroundColor: Color.fromARGB(255, 253, 85, 242),),

      body: Container(
        decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.purpleAccent, Colors.white],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          stops: [0.4, 0.7],
          tileMode: TileMode.clamp,
        ),
      ),
        child: ListView(
            children: <Widget>[
              GridView.count(
                shrinkWrap: true,
                primary: false,
                padding: const EdgeInsets.all(10),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                crossAxisCount: 2,
                children: [
                  Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Color.fromARGB(255, 100, 158, 205)),
                    child: Column(
                      children: [
                        Expanded(
                          flex: 5,
                          child: IconButton(
                            iconSize: 220,
                            padding: EdgeInsets.zero,
                            constraints: BoxConstraints(),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const TimerPage(activity: 'tummy')));
                            },
                            icon: Image.asset("assets/icons/tummy.png"),
                          ),
                        ),
                        const Expanded(
                          child: Text(
                            "Tummy",
                            style: TextStyle(color: Colors.white,),
                          ),
                          flex: 1,
                        ),
                      ],
                    ),
                  ),
                  Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Color.fromARGB(255, 205, 87, 87)),
                    child: Column(
                      children: [
                        Expanded(
                          flex: 5,
                          child: IconButton(
                            iconSize: 220,
                            padding: EdgeInsets.zero,
                            constraints: BoxConstraints(),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const TimerPage(activity: 'walk')));
                            },
                            icon: Image.asset("assets/icons/walk.png"),
                          ),
                        ),
                        const Expanded(
                          child: Text(
                            "Walk",
                            style: TextStyle(color: Colors.white,),
                          ),
                          flex: 1,
                        ),
                      ],
                    ),
                  ),
                  
                  Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Color.fromARGB(255, 192, 80, 80)),
                    child: Column(
                      children: [
                        Expanded(
                          flex: 5,
                          child: IconButton(
                            iconSize: 220,
                            padding: EdgeInsets.zero,
                            constraints: BoxConstraints(),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const HealthPage(activity: 'Medication')));
                            },
                            icon: Image.asset("assets/icons/medication.png"),
                          ),
                        ),
                        const Expanded(
                          child: Text(
                            "Medication",
                            style: TextStyle(color: Colors.white,),
                          ),
                          flex: 1,
                        ),
                      ],
                    ),
                  ),
                  Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Color.fromARGB(255, 255, 0, 221)),
                    child: Column(
                      children: [
                        Expanded(
                          flex: 5,
                          child: IconButton(
                            iconSize: 220,
                            padding: EdgeInsets.zero,
                            constraints: BoxConstraints(),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const TimerPage(activity: 'bath')));
                            },
                            icon: Image.asset("assets/icons/bath.png"),
                          ),
                        ),
                        const Expanded(
                          child: Text(
                            "Bath",
                            style: TextStyle(color: Colors.white,),
                          ),
                          flex: 1,
                        ),
                      ],
                    ),
                  ),
                  Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Color.fromARGB(255, 71, 208, 235)),
                    child: Column(
                      children: [
                        Expanded(
                          flex: 5,
                          child: IconButton(
                            iconSize: 220,
                            padding: EdgeInsets.zero,
                            constraints: BoxConstraints(),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const HealthPage(activity: 'Vaccination')));
                            },
                            icon: Image.asset("assets/icons/vaccination.png"),
                          ),
                        ),
                        const Expanded(
                          child: Text(
                            "Vaccination",
                            style: TextStyle(color: Colors.white,),
                          ),
                          flex: 1,
                        ),
                      ],
                    ),
                  ),
                  Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Color.fromARGB(255, 107, 6, 60)),
                    child: Column(
                      children: [
                        Expanded(
                          flex: 5,
                          child: IconButton(
                            iconSize: 220,
                            padding: EdgeInsets.zero,
                            constraints: BoxConstraints(),
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const HealthPage(activity: 'Measure')));
                              
                              },
                            icon: Image.asset("assets/icons/measure.png"),
                          ),
                        ),
                        const Expanded(
                          child: Text(
                            "Measure",
                            style: TextStyle(color: Colors.white,),
                          ),
                          flex: 1,
                        ),
                      ],
                    ),
                  ),
                  ]
                  )
                  ]
                  ),
      ),
                
      
    );
  }
}