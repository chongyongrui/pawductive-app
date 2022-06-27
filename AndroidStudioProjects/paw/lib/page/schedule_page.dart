import 'package:flutter/material.dart';
import 'package:timer/page/event_editing_page.dart';
import 'package:timer/page/testschedule.dart';

import 'package:timer/widget/calender_widget.dart';
/*
class SchedulePage extends StatelessWidget {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
    Scaffold(

      body: CalendarWidget(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add, color: Colors.white),
        backgroundColor: Colors.cyan,
        onPressed: () =>
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) =>
                    EventEditingPage()
                )
            ),
      ),
    );

  }
}

 */

class SchedulePage extends StatefulWidget {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(

        body: CalendarWidget(),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add, color: Colors.white),
          backgroundColor: Colors.cyan,
          onPressed: () =>
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) =>
                      EventEditingPage()
                  )
              ),
        ),
      );

  }
}


