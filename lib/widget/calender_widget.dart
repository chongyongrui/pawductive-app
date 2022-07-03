import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:timer/model/event_data_source.dart';
import 'package:timer/provider/event_provider.dart';
import 'package:provider/provider.dart';
import 'package:timer/widget/tasks_widget.dart';
import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:googleapis/calendar/v3.dart' as googleAPI;
import 'package:http/io_client.dart';
import 'package:http/http.dart';
import 'package:googleapis_auth/googleapis_auth.dart';
/*
//void main() => runApp(GoogleCalendarEvents());

class GoogleCalendarEvents extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Event Calendar',
      home: CalendarEvents(),
    );
  }
}

class CalendarEvents extends StatefulWidget {
  @override
  CalendarEventsState createState() => CalendarEventsState();
}

class CalendarEventsState extends State<CalendarEvents> {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId:
    'OAuth Client ID',
    scopes: <String>[
      'https://www.googleapis.com/auth/calendar',
      'https://www.googleapis.com/auth/calendar.events',
      'https://www.googleapis.com/auth/calendar.events.readonly',
      'https://www.googleapis.com/auth/calendar.readonly',
      'https://www.googleapis.com/auth/calendar.settings.readonly'


    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text('Event Calendar'),
      ),
      body: Container(
        child: FutureBuilder(
          future: getGoogleEventsData(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return Container(
                child: Stack(
                  children: [
                    Container(
                      child: SfCalendar(
                        view: CalendarView.month,
                        initialDisplayDate: DateTime.now(),
                        dataSource: GoogleDataSource(events: snapshot.data),
                        monthViewSettings: MonthViewSettings(
                            appointmentDisplayMode:
                            MonthAppointmentDisplayMode.appointment),
                      ),
                    ),
                    snapshot.data != null
                        ? Container()
                        : Center(
                      child: CircularProgressIndicator(),
                    )
                  ],
                ));
          },
        ),
      ),
    );
  }

  @override
  void dispose(){
    if(_googleSignIn.currentUser != null) {
      _googleSignIn.disconnect();
      _googleSignIn.signOut();
    }

    super.dispose();
  }

  Future<List<googleAPI.Event>> getGoogleEventsData() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    final GoogleAPIClient httpClient =
    GoogleAPIClient(await googleUser!.authHeaders);
    final googleAPI.CalendarApi calendarAPI = googleAPI.CalendarApi(httpClient);
    final googleAPI.Events calEvents = await calendarAPI.events.list(
      "primary",
    );
    final List<googleAPI.Event> appointments = <googleAPI.Event>[];
    if (calEvents != null && calEvents.items != null) {
      for (int i = 0; i < calEvents.items!.length; i++) {
        final googleAPI.Event event = calEvents.items![i];
        if (event.start == null) {
          continue;
        }
        appointments.add(event);
      }
    }
    return appointments;
  }
}

class GoogleDataSource extends CalendarDataSource {
  GoogleDataSource({List<googleAPI.Event>? events}) {
    this.appointments = events;
  }

  @override
  DateTime getStartTime(int index) {
    final googleAPI.Event event = appointments![index];
    return event.start!.date ?? event.start!.dateTime!.toLocal();
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].start.date != null;
  }

  @override
  DateTime getEndTime(int index) {
    final googleAPI.Event event = appointments![index];
    return event.endTimeUnspecified != null
        ? (event.start!.date ?? event.start!.dateTime!.toLocal())
        : (event.end!.date != null
        ? event.end!.date!.add(Duration(days: -1))
        : event.end!.dateTime!.toLocal());
  }

  @override
  String getLocation(int index) {
    return appointments![index].location;
  }

  @override
  String getNotes(int index) {
    return appointments![index].description;
  }

  @override


  String getSubject(int index) {
    final googleAPI.Event event = appointments![index];

    if (event.summary == null || event.summary!.isEmpty ) {
      return  'No Title';
    } else {
      return (event.summary).toString();
    }

    /*
    return event.summary == null || event.summary.isEmpty
        ? 'No Title'
        : event.summary;

     */
  }


}

class GoogleAPIClient extends IOClient {
  Map<String, String> _headers;

  GoogleAPIClient(this._headers) : super();

  @override
  Future<IOStreamedResponse> send(BaseRequest request) =>
      super.send(request..headers.addAll(_headers));

  @override
  Future<Response> head(Uri url, {Map<String, String>? headers}) =>
      super.head(url, headers: headers!..addAll(_headers));
}

 */





class CalendarWidget extends StatelessWidget {

    @override
  Widget build(BuildContext context) {
      final events = Provider.of<EventProvider>(context).events;

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
}


