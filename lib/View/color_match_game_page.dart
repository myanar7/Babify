import 'dart:math';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/utilities/keys.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class ColorGame extends StatefulWidget {
  const ColorGame({Key? key}) : super(key: key);

  createState() => ColorGameState();
}

class ColorGameState extends State<ColorGame> {
  //Map to keep track of the score
  final Map<String, bool> score = {};

  //Choices
  final Map choices = {
    '🍏': Colors.green,
    '🍎': Colors.red,
    '🍋': Colors.yellow,
    '🍊': Colors.orange,
    '🍇': Colors.purple,
    '🥥': Colors.brown
  };

  int seed = 0;

  //Play sound
  AudioCache _audioController = AudioCache();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(builder: EasyLoading.init(),home: Scaffold(
      backgroundColor: bckgrnd,
      appBar: AppBar(
        title: Text('Score ${score.length} / 6'),
        backgroundColor: apbr,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: () {
          setState(() {
            score.clear();
            seed++;
          });
        },
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: choices.keys.map((emoji) {
                  return Draggable<String>(
                    data: emoji,
                    child: Emoji(emoji: score[emoji] == true ? '✅' : emoji),
                    feedback: Emoji(emoji: emoji),
                    childWhenDragging: const Emoji(emoji: '🌱'),
                  );
                }).toList()),
          ), //end of column 1
          SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
                  choices.keys.map((emoji) => _builDragTarget(emoji)).toList()
                    ..shuffle(Random(seed)),
            ),
          )
        ],
      ),
    ));
  }

  Widget _builDragTarget(emoji) {
    return DragTarget<String>(
      builder: (BuildContext context, List<String?> incoming, List rejected) {
        if (score[emoji] == true) {
          return Container(
            color: Colors.white,
            child: Text('Correct'),
            alignment: Alignment.center,
            height: 80,
            width: 200,
          );
        } else {
          return Container(
            color: choices[emoji],
            height: 80,
            width: 200,
          );
        }
      },
      onWillAccept: (data) => data == emoji,
      onAccept: (data) {
        setState(() {
          score[emoji] = true;
          if(score.length == 6){
            EasyLoading.showSuccess('Congratulations');
          }
        });
        _audioController.play('success.mp3');
      },
      onLeave: (data) {},
    );
  }
}

class Emoji extends StatelessWidget {
  const Emoji({Key? key, required this.emoji}) : super(key: key);

  final String emoji;

  @override
  Widget build(BuildContext context) {
    return Material(
      
      color: bckgrnd,
      child: Container(
        height: 85,
        width: 100,
        child: Center(
          child: Text(
            emoji,
            style: TextStyle(color: Colors.black, fontSize: 50),
          ),
        ),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 2),
          color: bckgrnd,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}
