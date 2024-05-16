import 'dart:async';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int? _value = 1;
  int? _value2 = 1;
  int totalSeconds = 1500;
  late Timer timer;
  bool isRunning = false;
  bool isResting = false;
  List<int> times = [900, 1200, 1500, 1800, 2100];
  List<int> restTime = [300];
  int count = 0;
  int gCount = 0;

  void onTick(Timer timer) {
    setState(() {
      totalSeconds -= 100;
      if (!isResting) {
        if (totalSeconds <= 0) {
          timer.cancel();
          isRunning = false;
          isResting = true;
          count += 1;
          if (count == 4) {
            count = 0;
            gCount += 1;
          }
          if (gCount == 1) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          }
        }
      } else {
        if (totalSeconds <= 0) {
          timer.cancel();
          isRunning = false;
          isResting = false;
        }
      }
    });
  }

  String format(int seconds) {
    var duration = Duration(seconds: seconds);
    return duration.toString().split('.').first.substring(2, 7);
  }

  void onStartPressed() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      onTick,
    );
    setState(() {
      isRunning = true;
    });
  }

  void onPausedPressed() {
    timer.cancel();
    setState(() {
      isRunning = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).dialogBackgroundColor,
      body: Column(
        children: [
          Flexible(
            flex: 1,
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Text(
                'Pomodoro',
                style: TextStyle(
                  color: Theme.of(context).cardColor,
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Container(
              child: Text(
                format(totalSeconds),
                style: TextStyle(
                  color: Theme.of(context).cardColor,
                  fontSize: 50,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Container(
              child: Wrap(
                spacing: 5,
                children: isResting
                    ? List.generate(
                        restTime.length,
                        (int index) {
                          return ChoiceChip(
                            label: Text(
                              '${restTime[index] ~/ 60.toInt()}',
                              style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!
                                    .color,
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            selected: _value2 == index,
                            onSelected: (bool selected) {
                              setState(() {
                                _value2 = index;
                                totalSeconds = restTime[index];
                              });
                            },
                          );
                        },
                      ).toList()
                    : List.generate(
                        times.length,
                        (int index) {
                          return ChoiceChip(
                            label: Text(
                              '${(times[index] ~/ 60.toInt())}',
                              style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .headlineMedium!
                                    .color,
                                fontSize: 15,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            selected: _value == index,
                            onSelected: (bool selected) {
                              setState(() {
                                _value = index;
                                totalSeconds = times[index];
                              });
                            },
                          );
                        },
                      ).toList(),
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: IconButton(
              onPressed: isRunning ? onPausedPressed : onStartPressed,
              icon: isRunning
                  ? const Icon(
                      Icons.pause_circle_filled_outlined,
                      size: 70,
                    )
                  : const Icon(
                      Icons.play_circle_fill_outlined,
                      size: 70,
                    ),
              color: Theme.of(context).cardColor,
            ),
          ),
          Container(
            child: Flexible(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '$count / 4 \nROUND',
                    style: TextStyle(
                      color: Theme.of(context).cardColor,
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '$gCount / 12 \nGOAL',
                    style: TextStyle(
                      color: Theme.of(context).cardColor,
                      fontSize: 30,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
