import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:timer/achievements.dart';
//import 'package:timer/home_page.dart';
import 'package:timer/page/achievements_page.dart';
import 'package:timer/page/schedule_page.dart';
import 'package:timer/page/timer_page.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'globals.dart' as globals;

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  home: MainPage(),
));

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
    AchievementsPage()


  ];

  @override
  Widget build(BuildContext) => WillPopScope(

    onWillPop:() async {
      final difference = DateTime.now().difference(timeBackPressed);
      final isExitWarning = difference >= Duration(seconds:2);

      timeBackPressed = DateTime.now();

      if (isExitWarning){
        final message = "Focus on your work! Are you sure you want to exit?";
        Fluttertoast.showToast(msg: message,fontSize: 18);
        return false;
      } else {
        Fluttertoast.cancel();
        return true;
      }
    },

     child: Scaffold(
          appBar: AppBar(
            title: Text("Pawductive", style: GoogleFonts.chewy( color: Colors.white)),
            centerTitle: true,
          ),
        body: IndexedStack(
          index: currentIndex ,
          children: screens,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (index)=> setState(() => currentIndex = index),
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month),
              label: 'Schedule',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.access_alarm),
              label: 'Timer',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.star_outline_rounded),
              label: 'Achievements',
            ),
          ],


        ),
      ),
  );
}

















/*void main() => runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    ));

class MainPage extends StatefulWidget {

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 1;

  //pages
  final screens = [
    Center(child: Text('Schedule', style: TextStyle(fontSize: 60))),
    MainPage(),
    Center(child: Text('Achievements', style: TextStyle(fontSize: 60))),
  ];


  double percent = 0;
  static int TimeInMin = 25;
  int TimeInSec = TimeInMin * 60;

  late Timer timer;

  _StartTimer(){
    TimeInMin = 25;
    int Time = TimeInMin * 60 ;
    double SecPercent = (Time/100);
    timer = Timer.periodic(Duration(seconds:1), (timer) {
      setState((){
        if (Time > 0) {
          Time--;
          if (Time % 60 == 0){
            TimeInMin--;
          } if (Time % SecPercent ==0){
              if (percent<1){
                percent += 0.01;
            }else{
                percent = 1;
              }
          }

        }else{
          percent = 0;
          TimeInMin = 25;
          timer.cancel();
        }
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(


        //navigation bar stuff

          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) => setState(() => currentIndex = index),
            currentIndex : currentIndex,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_month),
                label: 'Schedule',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.access_alarm),
                label: 'Timer',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.star_outline_rounded),
                label: 'Achievements',
              ),
            ],
          ),








          body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0xff1542bf), Color(0xff51a8ff)],
                begin: FractionalOffset(0.5, 1)
            )
        ),
        width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                  Padding(
                  padding  : EdgeInsets.only(top:18.0),
                    child: Text(
                      "Pawductive Timer",
                      style: GoogleFonts.chewy(

                          color: Colors.white,
                        fontSize: 40.0,
                      )
                    ),
                  ),

                //corgi pic
                Column(
                  children: [
                    Image.asset('assets/images/butt.gif',
                    width: 100,
                      height:100,),
                  ],
                ),



                Expanded(
                  child: CircularPercentIndicator(

                    circularStrokeCap: CircularStrokeCap.round,
                    percent: percent,
                    animation: true,
                    animateFromLastPercent: true,
                    radius: 100.0,
                    lineWidth: 20.0,
                    progressColor: Colors.white,
                    center: Text(
                      "$TimeInMin",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 80.0
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 10.0),
                Expanded(
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(topRight: Radius.circular(30.0),topLeft: Radius.circular(30.0))
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Column(
                                    children: <Widget> [
                                      Text(
                                        "Study Timer",
                                        style: TextStyle(
                                          fontSize: 20.0,
                                        )
                                      ),
                                      SizedBox(height: 10.0),
                                      Text(
                                        "25",
                                        style: TextStyle(
                                          fontSize: 30.0,
                                        ),
                                      )
                                    ]
                                  )
                                ),
                                Expanded(
                                    child: Column(
                                        children: <Widget> [
                                          Text(
                                              "Pause Time",
                                              style: TextStyle(
                                                fontSize: 20.0,
                                              )
                                          ),
                                          SizedBox(height: 10.0),
                                          Text(
                                            "5",
                                            style: TextStyle(
                                              fontSize: 30.0,
                                            ),
                                          )
                                        ]
                                    )
                                ),
                              ]
                            )
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(vertical:28.0),
                            child: RaisedButton(
                              onPressed: _StartTimer,
                              color: Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100.0),
                              ),

                            child: Padding(
                                padding: EdgeInsets.all(20.0),
                              child: Text("Start Timer",
                              style: GoogleFonts.chewy(
                                color: Colors.white,
                                fontSize: 22.0
                              )
                              )
                            )
                          ),
                          )
                        ]

                    )
                  )
                )
                )
              ],

            ),
          )

      ),

    );
  }
}
*/