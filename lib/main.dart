// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables

import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StopWatchApp(),
    );
  }
}

class StopWatchApp extends StatefulWidget {
  const StopWatchApp({Key? key}) : super(key: key);

  @override
  State<StopWatchApp> createState() => _StopWatchAppState();
}

class _StopWatchAppState extends State<StopWatchApp> {
  Duration duration = Duration(seconds: 0);
  int numberOfSeconds = 10;
  Timer? repeatedFunction;

  bool isTimerRunning = false;

  startTimer() {
    repeatedFunction = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        int newDuration = duration.inSeconds + 1;
        duration = Duration(seconds: newDuration);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 51, 0, 0.8),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(15, 15, 15, 15),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Color.fromRGBO(0, 204, 255, 0.8),
                    borderRadius: BorderRadius.circular(12)),
                child: Column(
                  children: [
                    Text(duration.inHours.toString().padLeft(2, "0"),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 75,
                        )),
                    Text("hour",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                        )),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(0, 15, 0, 15),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Color.fromRGBO(0, 204, 255, 0.8),
                    borderRadius: BorderRadius.circular(12)),
                child: Column(
                  children: [
                    Text(
                        duration.inMinutes
                            .remainder(60)
                            .toString()
                            .padLeft(2, "0"),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 75,
                        )),
                    Text("Min",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                        )),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(15, 15, 15, 15),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Color.fromRGBO(0, 204, 255, 0.8),
                    borderRadius: BorderRadius.circular(12)),
                child: Column(
                  children: [
                    Text(
                        duration.inSeconds
                            .remainder(60)
                            .toString()
                            .padLeft(2, "0"),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 75,
                        )),
                    Text("Sec",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                        )),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 44,
          ),
          (isTimerRunning)
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (repeatedFunction!.isActive) {
                          setState(() {
                            repeatedFunction!.cancel();
                          });
                        } else
                          startTimer();
                      },
                      child: Text(
                        (repeatedFunction!.isActive) ? "STOP" : "resume",
                        style: TextStyle(fontSize: 19),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Color.fromRGBO(0, 255, 51, 0.8)),
                        padding: MaterialStateProperty.all(EdgeInsets.all(14)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9))),
                      ),
                    ),
                    SizedBox(
                      width: 44,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        repeatedFunction!.cancel();
                        duration = Duration(seconds: 0);

                        setState(() {
                          isTimerRunning = false;
                        });
                      },
                      child: Text(
                        "CANCEL",
                        style: TextStyle(fontSize: 19),
                      ),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Color.fromRGBO(0, 255, 51, 0.8)),
                        padding: MaterialStateProperty.all(EdgeInsets.all(14)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9))),
                      ),
                    ),
                  ],
                )
              : ElevatedButton(
                  onPressed: () {
                    startTimer();
                    setState(() {
                      isTimerRunning = true;
                    });
                  },
                  child: Text(
                    "START TIMER",
                    style: TextStyle(fontSize: 19),
                  ),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Color.fromRGBO(51, 0, 255, 0.8)),
                    padding: MaterialStateProperty.all(EdgeInsets.all(14)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(9))),
                  ),
                ),
        ],
      ),
    );
  }
}
