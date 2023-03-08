import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_custom_painter/Emoji.dart';
import 'package:flutter_custom_painter/MyPainter.dart';
import 'package:flutter_custom_painter/clock.dart';
import 'package:flutter_custom_painter/clockcircle.dart';
import 'package:flutter_custom_painter/practice.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime dateTime = DateTime.now();
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        setState(() {
          dateTime = DateTime.now();
        });
      },
    );
  }

  Color facecolor = Colors.amber;
  double timeline = 0;
  @override
  void initState() {
    super.initState();
    Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        setState(() {
          if (timeline < 1.0) {
            facecolor = Color.lerp(Colors.grey, Colors.pink, timeline)!;
            timeline += 0.1;
          } else {
            timeline = 0.0;
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Expanded(
          flex: 5,
          child: Center(
            child: Container(
              color: Colors.black,
              width: 300,
              height: 300,
              child: CustomPaint(painter: EmojiPainter(facecolor: facecolor),),
            ),
          ),
        ),
        Expanded(
          flex: 5,
          child: Center(
            child: Container(
            child: MyClock(),
            ),
          ),
        ),
      ]),
    );
  }
}

//EMOJIPAINT CLASS
// Center(
//             child: Container(
//               color: Colors.green,
//               width: 300,
//               height: 300,
//               child: CustomPaint(painter: EmojiPainter(facecolor: facecolor)),
//             ),
//           ),