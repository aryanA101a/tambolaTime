import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tambola_time/tambolaNumber.dart';

class TambolaServices {
  int? currentNumber;
  List<TambolaNumber> tambolaNumArr = [];
  List<int> randomNumArr = [];
  late int counter;
  Timer? timer;
  //constructor
  TambolaServices() {
    init();
  }

  //initialize/reset every thing
  init() {
    //create a list of integers from 1 to 90
    tambolaNumArr =
        List.generate(90, (index) => TambolaNumber(number: index + 1));

    //create a list of integers from 1 to 90
    randomNumArr = List.generate(90, (index) => index + 1);

    //randomize the array
    randomNumArr.shuffle();

    currentNumber = null;
    counter = 0;
    timer = null;
  }

  stop() {
    timer?.cancel();
  }
}
