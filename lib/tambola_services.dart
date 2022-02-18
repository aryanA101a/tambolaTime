import 'dart:async';

import 'package:flutter/material.dart';
import 'package:tambola_time/tambolaNumber.dart';

class TambolaServices {
  int? currentNumber;
  List<TambolaNumber> tambolaNumArr = [];
  List<int> randomNumArr = [];
  late int counter;
  Timer? timer;

  TambolaServices() {
    init();
  }

  init() {
    tambolaNumArr =
        List.generate(90, (index) => TambolaNumber(number: index + 1));

    randomNumArr = List.generate(90, (index) => index + 1);

    randomNumArr.shuffle();

    currentNumber = null;
    counter = 0;
    timer = null;
  }

  stop() {
    timer?.cancel();
  }
}
