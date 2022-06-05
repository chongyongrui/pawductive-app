import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timer/model/event.dart';
import 'package:timer/utils.dart';
import 'package:timer/widget/calender_widget.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:event/event.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:event/event.dart';

class EventProvider extends ChangeNotifier{
  final List<Event0> _events = [];

  List<Event0> get events => _events;

  DateTime _selectedDate = DateTime.now();

  DateTime get selectedDate => _selectedDate;
  void setDate(DateTime date) => _selectedDate = date;
  List<Event0> get eventsOfSelectedDate => _events;

  void addEvent (Event0 event) {
    _events.add(event);
    notifyListeners();
  }

  void editEvent(Event0 newEvent, Event0 oldEvent) {
    final index = _events.indexOf(oldEvent);
    _events[index] = newEvent;
    notifyListeners();
  }

  void deleteEvent(Event0 event) {
    _events.remove(event);
    notifyListeners();
  }

}