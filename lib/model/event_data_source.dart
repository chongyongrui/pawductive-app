import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:timer/model/event.dart';

// class to get event details from an event of class Event0

class EventDataSource extends CalendarDataSource {
  EventDataSource (List<Event0> appointments) {
    this.appointments = appointments;
  }

  Event0 getEvent(int index) => appointments![index] as Event0;

  @override

  DateTime getStartTime(int index) => getEvent(index).from;

  @override
  DateTime getEndTime(int index) => getEvent(index).to;

  @override
  String getSubject(int index) => getEvent(index).title;

  @override
  Color getColor(int index) => getEvent(index).backgroundColor;

  @override
  bool isAllDay(int index) => getEvent(index).isAllDay;

}