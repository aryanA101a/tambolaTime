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
  late FlutterTts flutterTts; //textToSpeech instance variable declaration
  late TambolaServices ts; //tambolaservices instance variable declaration

  //start tambola
  start() {
    // log(ts.randomNumArr.toString());

    ts.timer = Timer.periodic(Duration(milliseconds: 2000), (timer) {
      // log("${ts.counter} | ${ts.randomNumArr[ts.counter]} | ${ts.tambolaNumArr[ts.randomNumArr[ts.counter] - 1]}");
      //end after counter=n-1
      if (ts.counter == 89) {
        timer.cancel();
      }
      //change ui state
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

    //initialize ts variable
    ts = TambolaServices();
  }

  //initialize TextToSpeech
  initTts() async {
    flutterTts = FlutterTts();
    await flutterTts.awaitSpeakCompletion(true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
//______________________________TambolaBoard__________________________________

            Center(
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: Card(
                  color: Colors.amber.shade200,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
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
                ),
              ),
            ),
//_________________________________ButtonRow________________________________________
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
                          color: Colors.white,
                          textColor: Colors.white,
                          child: Icon(
                            ts.timer!.isActive ? Icons.pause : Icons.play_arrow,
                            color: Colors.amber.shade700,
                          ),
                          padding: EdgeInsets.all(4),
                          shape: CircleBorder(),
                        ),
                  MaterialButton(
                    height: 90,
                    onPressed: () {
                      ts.timer == null ? start() : () {};
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
                      setState(() {
                        ts.timer?.cancel();
                        ts.init();
                      });
                    },
                    color: Colors.white,
                    textColor: Colors.white,
                    child: Icon(
                      Icons.stop,
                      color: Colors.amber.shade700,
                    ),
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
