import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:timer/model/event_data_source.dart';
import 'package:timer/provider/event_provider.dart';
import 'package:provider/provider.dart';
import 'package:event/event.dart';
//import 'package:event_calendar/event_calendar.dart';

class CalendarWidget extends StatelessWidget {
    @override
  Widget build(BuildContext context) {
      final events = Provider.of<EventProvider>(context).events;

    return SfCalendar(
      view: CalendarView.month,
      dataSource: EventDataSource(events),
      initialSelectedDate: DateTime.now(),
      cellBorderColor: Colors.transparent,
  /*    onLongPress: (){
        final provider = Provider.of<EventProvider>(context, listen: true);
        provider.setDate(details.date!);

        showModalBottomSheet(
            context: context,
            builder: (context) => TasksWidget(),
        )

      },

   */
    );
  }
}
