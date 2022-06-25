import "package:flutter/material.dart";
import 'package:provider/provider.dart';
import 'package:timer/model/event.dart';
import 'package:timer/page/event_editing_page.dart';
import 'package:timer/provider/event_provider.dart';
import 'package:timer/utils.dart';

class EventViewingPage extends StatelessWidget {
  final Event0 event;

  const EventViewingPage({
    Key? key,
    required this.event,
}) : super(key: key);

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
       leading: CloseButton(),
      //actions: buildViewingActions(context,event),
      actions: <Widget>[
    IconButton(
    icon: Icon(Icons.edit),
    onPressed: () => Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => EventEditingPage(event: event),
      ),
    ),
  ),

  IconButton(
  icon: Icon(Icons.delete),
  onPressed: () {
  final provider = Provider.of<EventProvider>(context,listen: false);
  provider.deleteEvent(event);
  Navigator.pop(context);
  },
  ) ],
    ),
    body: ListView(
      padding: EdgeInsets.all(32),
      children: <Widget>[
        buildDateTime(event),
        SizedBox(height: 32),
        Text(
          event.title,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 24),
        Text(
          event.description,
          style: TextStyle(color: Colors.black, fontSize: 18),
        )
      ],
    ),
  );

  Widget buildDateTime( Event0 event) {
    return Column(
      children: [
        buildDate (event.isAllDay ? 'All-day' : 'From', event.from),
        if (!event.isAllDay) buildDate("To", event.to),
      ],
    );
  }


  Widget buildDate (String title, DateTime date) {
    return Container(
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:<Widget>[
      Column(


      children: [
        Text(title,style: TextStyle(color:Colors.black,fontSize:18),),
        SizedBox(height: 10),
        Text(Utils.toDateTime(date),textAlign: TextAlign.right,style: TextStyle(color:Colors.black,fontSize:16),),
        SizedBox(height: 20,)
        ]
    ),
    ]));
  }


}
