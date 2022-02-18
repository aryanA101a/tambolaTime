import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:tambola_time/tambola_services.dart';

class TambolaScreen extends StatefulWidget {
  TambolaScreen({Key? key}) : super(key: key);

  @override
  State<TambolaScreen> createState() => _TambolaScreenState();
}

class _TambolaScreenState extends State<TambolaScreen> {
  late FlutterTts flutterTts;
  late TambolaServices ts;
  late List<Widget> numWidget;

  start() {
    log(ts.randomNumArr.toString());

    ts.timer = Timer.periodic(Duration(milliseconds: 2000), (timer) {
      log("${ts.counter} | ${ts.randomNumArr[ts.counter]} | ${ts.tambolaNumArr[ts.randomNumArr[ts.counter] - 1]}");
      if (ts.counter == 89) {
        timer.cancel();
      }
      setState(() {
        ts.currentNumber = ts.randomNumArr[ts.counter];
        ts.tambolaNumArr[ts.randomNumArr[ts.counter] - 1].changeColor();
        ts.counter++;
      });
      flutterTts.speak(ts.currentNumber.toString());
    });
  }

  @override
  void initState() {
    super.initState();
    initTts();
    ts = TambolaServices();
  }

  initTts() async {
    flutterTts = FlutterTts();
    await flutterTts.awaitSpeakCompletion(true);
  }

  @override
  Widget build(BuildContext context) {
    // numWidget = List.generate(
    //     90,
    //     (index) => Padding(
    //           padding: const EdgeInsets.all(1),
    //           child: CircleAvatar(
    //             child: Text(
    //               ts.tambolaNumArr[index].number.toString(),
    //               style: TextStyle(color: Colors.black),
    //             ),
    //             radius: 18,
    //             backgroundColor: ts.tambolaNumArr[index].color,
    //           ),
    //         ));
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Card(
                  elevation: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Wrap(
                      children: List.generate(
                          90,
                          (index) => Padding(
                                padding: const EdgeInsets.all(1),
                                child: CircleAvatar(
                                  child: Text(
                                    ts.tambolaNumArr[index].number.toString(),
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  radius: 18,
                                  backgroundColor:
                                      ts.tambolaNumArr[index].color,
                                ),
                              )),
                    ),
                  ),
                  color: Colors.amber.shade200,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ts.timer == null
                      ? Container(
                          width: 60,
                        )
                      : MaterialButton(
                          height: 60,
                          onPressed: () {
                            setState(() {});
                            ts.timer!.isActive ? ts.stop() : start();
                          },
                          color: Colors.amber.shade700,
                          textColor: Colors.white,
                          child: Icon(ts.timer!.isActive
                              ? Icons.pause
                              : Icons.play_arrow),
                          padding: EdgeInsets.all(4),
                          shape: CircleBorder(),
                        ),
                  MaterialButton(
                    height: 90,
                    onPressed: () {
                      start();
                    },
                    color: Colors.amber.shade700,
                    textColor: Colors.white,
                    child: Text(
                      ts.currentNumber != null
                          ? ts.currentNumber.toString()
                          : "Start",
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                    padding: EdgeInsets.all(4),
                    shape: CircleBorder(),
                  ),
                  MaterialButton(
                    height: 60,
                    onPressed: () {
                      setState(() {});
                      ts.timer?.cancel();
                      ts.init();
                    },
                    color: Colors.amber.shade700,
                    textColor: Colors.white,
                    child: Icon(Icons.stop),
                    padding: EdgeInsets.all(4),
                    shape: CircleBorder(),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
