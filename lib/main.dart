import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:timer/page/Todopage.dart';
import 'package:timer/page/achievements_page.dart';
import 'package:timer/page/community_page.dart';
import 'package:timer/page/loggedin_community_page.dart';
import 'package:timer/page/profile_page.dart';
import 'package:timer/page/schedule_page.dart';
import 'package:timer/page/testpage.dart';
import 'package:timer/page/timer_page.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:timer/provider/event_provider.dart';
import 'globals.dart' as globals;
import 'package:firebase_core/firebase_core.dart';
import 'globals.dart';
import 'page/store_page.dart';
import 'package:wakelock/wakelock.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);
  await Firebase.initializeApp();
  runApp(MyApp());
  if (globalisrunning == true) {
    Wakelock.enable();
  } else {
    Wakelock.disable();
  }
}

class MyApp extends StatelessWidget {
  static final String title = 'Todo App';

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
    create: (context) => EventProvider(),
    child: MaterialApp(
      restorationScopeId: "root",
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
  int currentIndex = 2;
  final screens = [
    SchedulePage(),
    MytodolistApp(),
    TimerPage(),
    StorePage(),
    //HomePage(),
   // AchievementsPage(),
    //LoadDataFromFireBase(),
    ProfilePage(),
    CommunityPage(),



  ];
  @override
  void initState() {
    super.initState();
    Firebase.initializeApp().whenComplete(() {
      //print("initialisation completed");
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
                 "Pawductive", style: GoogleFonts.gochiHand(color: Colors.white)),
             centerTitle: true,
             backgroundColor: globalcolor2,
           ),
           body: IndexedStack(
             index: currentIndex,
             children: screens,
           ),
           bottomNavigationBar: BottomNavigationBar(

             currentIndex: currentIndex,
             onTap: (index) => setState(() {
               currentIndex = index;
                globalcolor = globalcolor;
                globalcolor2 = globalcolor2;
             }),
             items: [
               BottomNavigationBarItem(
                 icon: Icon(Icons.calendar_month),
                 label: 'Schedule',
                 backgroundColor: globalcolor2,

               ),

               BottomNavigationBarItem(
                 icon: Icon(Icons.note_outlined),
                 label: 'Notepad',
                 backgroundColor: globalcolor2,

               ),

               BottomNavigationBarItem(
                 icon: Icon(Icons.access_alarm),
                 label: 'Timer',
                 backgroundColor: globalcolor2,
               ),

               BottomNavigationBarItem(
                 icon: Icon(Icons.shop),
                 label: 'Shop',
                 backgroundColor: globalcolor2,
               ),

               BottomNavigationBarItem(
                 icon: Icon(Icons.person_outline_rounded),
                 label: 'Profile',
                 backgroundColor: globalcolor2,
               ),
               BottomNavigationBarItem(
                 icon: Icon(Icons.people_alt_outlined),
                 label: 'Community',
                 backgroundColor: globalcolor2,
               ),


             ],


           ),
         ),
      );


}



