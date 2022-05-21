import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:timer/page/event_editing_page.dart';
import 'package:timer/provider/event_provider.dart';
import 'package:timer/widget/calender_widget.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:event/event.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
      create: (context) => EventProvider(),
      child:Scaffold(

        body: CalendarWidget(),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add, color: Colors.white) ,
          backgroundColor: Colors.cyan,
          onPressed: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => EventEditingPage())
      ),
        ),
      ),
  );

}
