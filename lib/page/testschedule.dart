import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:timer/page/event_editing_page.dart';
import 'package:timer/widget/calender_widget.dart';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:timer/model/event_data_source.dart';
import 'package:timer/provider/event_provider.dart';
import 'package:provider/provider.dart';
import 'package:timer/widget/tasks_widget.dart';

import '../model/event.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(LoadDataFromFireBase());
}

class LoadDataFromFireBase extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FireBase',
      home: LoadDataFromFireStore1(),
    );
  }
}

class LoadDataFromFireStore1 extends StatefulWidget {
  @override
  LoadDataFromFireStoreState createState() => LoadDataFromFireStoreState();
}

class LoadDataFromFireStoreState extends State<LoadDataFromFireStore1> {
  List<Color> _colorCollection = <Color>[];
  EventDataSource? events;
  final List<String> options = <String>['Add', 'Delete', 'Update'];
  final databaseReference = FirebaseFirestore.instance;

  @override
  void initState() {
    _initializeEventColor();
    getDataFromFireStore().then((results) {
      SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
        setState(() {});
      });
    });
    super.initState();
  }

  Future<void> getDataFromFireStore() async {
    var snapShotsValue = await databaseReference
        .collection("CalendarAppointmentCollection")
        .get();

    final Random random = new Random();
    List<Event0> list = snapShotsValue.docs
        .map((e) => Event0(
        title: e.data()['Subject'],
        description: e.data()["Desc"],
        from:
        DateFormat('dd/MM/yyyy HH:mm:ss').parse(e.data()['StartTime']),
        to: DateFormat('dd/MM/yyyy HH:mm:ss').parse(e.data()['EndTime']),

        isAllDay: false))
        .toList();
    setState(() {
      events = EventDataSource(list);
    });
  }

  @override


  Widget build(BuildContext context) {
    final events = Provider.of<EventProvider>(context).events;
    final databaseReference = FirebaseFirestore.instance;

    return SfCalendar(
      view: CalendarView.month,
      allowedViews: [
        CalendarView.day,
        CalendarView.week,
        CalendarView.month,
        CalendarView.timelineDay,
        CalendarView.timelineWeek,
      ],

      dataSource: EventDataSource(events),
      initialSelectedDate: DateTime.now(),
      cellBorderColor: Colors.transparent,
      onLongPress: (details){
        final provider = Provider.of<EventProvider>(context, listen: false);
        provider.setDate(details.date!);

        showModalBottomSheet(
          context: context,
          builder: (context) => TasksWidget(),
        );
      },
    );

  }



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
}

MeetingDataSource _getCalendarDataSource([List<Meeting>? collection]) {
  List<Meeting> meetings = collection ?? <Meeting>[];
  List<CalendarResource> resourceColl = <CalendarResource>[];
  resourceColl.add(CalendarResource(
    displayName: 'John',
    id: '0001',
    color: Colors.red,
  ));
  return MeetingDataSource(meetings, resourceColl);
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source, List<CalendarResource> resourceColl) {
    appointments = source;
    resources = resourceColl;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  List<Object> getResourceIds(int index) {
    return [appointments![index].resourceId];
  }
}

getDataFromDatabase() async {
  var value = FirebaseDatabase.instance.reference();
  var getValue = await value.child('CalendarData').once();
  return getValue;
}

class Meeting {
  Meeting(
      {required this.eventName,
        required this.from,
        required this.to,
        required this.background,
        required this.isAllDay,
        required this.resourceId});

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
  String resourceId;
}