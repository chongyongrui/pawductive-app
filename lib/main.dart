import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:timer/page/achievements_page.dart';
import 'package:timer/page/profile_page.dart';
import 'package:timer/page/schedule_page.dart';
import 'package:timer/page/timer_page.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:timer/provider/event_provider.dart';
import 'globals.dart' as globals;
import 'package:firebase_core/firebase_core.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static final String title = 'Todo App';

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
    create: (context) => EventProvider(),
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      home:MainPage(),
    ),
  );
}

class MainPage extends StatefulWidget {

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  DateTime timeBackPressed = DateTime.now();
  int currentIndex = 1;
  final screens = [
    SchedulePage(),
    TimerPage(),
    AchievementsPage(),
    ProfilePage()


  ];
  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      print("initialisation completed");
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) => WillPopScope (


         onWillPop: () async {
           final difference = DateTime.now().difference(timeBackPressed);
           final isExitWarning = difference >= Duration(seconds: 2);

           timeBackPressed = DateTime.now();

           if (isExitWarning) {
             final message = "Focus on your work! Are you sure you want to exit?";
             Fluttertoast.showToast(msg: message, fontSize: 18);
             return false;
           } else {
             Fluttertoast.cancel();
             return true;
           }
         },

         child: Scaffold(
           appBar: AppBar(
             title: Text(
                 "Pawductive", style: GoogleFonts.chewy(color: Colors.white)),
             centerTitle: true,
           ),
           body: IndexedStack(
             index: currentIndex,
             children: screens,
           ),
           bottomNavigationBar: BottomNavigationBar(


             currentIndex: currentIndex,
             onTap: (index) => setState(() => currentIndex = index),
             items: [
               BottomNavigationBarItem(
                 icon: Icon(Icons.calendar_month),
                 label: 'Schedule',
                 backgroundColor: Colors.blue,

               ),
               BottomNavigationBarItem(
                 icon: Icon(Icons.access_alarm),
                 label: 'Timer',
                 backgroundColor: Colors.blue,
               ),
               BottomNavigationBarItem(
                 icon: Icon(Icons.star_outline_rounded),
                 label: 'Achievements',
                 backgroundColor: Colors.blue,
               ),
               BottomNavigationBarItem(
                 icon: Icon(Icons.person_outline_rounded),
                 label: 'Profile',
                 backgroundColor: Colors.blue,
               ),


             ],


           ),
         ),
      );
}

