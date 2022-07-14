
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:timer/globals.dart';
//class called "event0" to contain the different elements

List<Color> _colorCollection = <Color>[];
void _initializeEventColor() {
  _colorCollection.add(const Color(0xFF0F8644));
  _colorCollection.add(const Color(0xFF8B1FA9));
  _colorCollection.add(const Color(0xFFD20100));
  _colorCollection.add(const Color(0xFFFC571D));
  _colorCollection.add(const Color(0xFF36B37B));
  _colorCollection.add(const Color(0xFF01A1EF));
  _colorCollection.add(const Color(0xFF3D4FB5));
  _colorCollection.add(const Color(0xFFE47C73));
  _colorCollection.add(const Color(0xFF636363));
  _colorCollection.add(const Color(0xFF0A8043));
}

class Event0 {

  final String title;
  final String description;
  final DateTime from;
  final DateTime to;
  final Color backgroundColor;
  final bool isAllDay;

   Event0({
    required this.title,
    required this.description,
    required this.from,
    required this.to,
     this.backgroundColor = Colors.blue,
    this.isAllDay = false,
  });
}