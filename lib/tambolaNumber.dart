import 'package:flutter/material.dart';

class TambolaNumber {
  int number;
  Color color = Colors.white;
  bool called;

  TambolaNumber({required this.number, this.called = false});
  changeColor() {
    color = Colors.amber.shade700;
  }
}
