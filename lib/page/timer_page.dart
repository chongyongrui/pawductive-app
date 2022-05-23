import 'dart:async';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:rflutter_alert/rflutter_alert.dart';


/*void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  home: MainPage(),
));
*/



class TimerPage extends StatefulWidget {
  
  @override
  _TimerPageState createState() => _TimerPageState();



}

class _TimerPageState extends State<TimerPage> {


  double percent = 0;
  static int TimeInMin = 1;
  int TimeInSec = TimeInMin * 60;
  int points = 0;
  int timechosen = 1;
  bool isrunning = false;

  late Timer timer;
  String message = "Time is up!";

  _StartTimer(){

    isrunning = true;

      int TimeInSec = TimeInMin * 60;
      int Time = TimeInMin * 60;
      //double SecPercent = (Time / 100);
      double SecPercent = (1/TimeInSec);
      timer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
         /* if (Time == 0) {
            print(TimeInMin);
            print(TimeInSec);
            isrunning == false;
            _resetTimer();
         }

          */
          if (Time > 0 && isrunning == true) {
            Time--;
            print(TimeInMin);
            print(TimeInSec);
            if (Time % 60 == 0) {
              TimeInMin--;
              points ++;
              print(TimeInMin);
              print(TimeInSec);
            }

           /*
            if (Time % SecPercent == 0) {
              print(TimeInMin);
              print(TimeInSec);
              if (percent < 1) {
                percent += 0.01;
              } else {
                percent = 1;
              }
            } */

            if ((percent + SecPercent) <1) {
              percent += SecPercent;
            } else{
              percent = 1;
            }

          } else {
            print(TimeInMin);
            print(TimeInSec);
            percent = 0;
            TimeInMin = timechosen;
            timer.cancel();
          }
        });
      });

  }

  _resetTimer(){
    percent = 0;
    isrunning = false;
    //Alert(context: context, title: "Timer reset successful", desc: "Press start whenever ready").show();
    Alert(
      context: context,
      type: AlertType.success,
      title: "Timer reset successful",
      desc: "Press start whenever ready",
      buttons: [
        DialogButton(
          child: Text(
            "Close",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () => Navigator.pop(context),
          width: 120,
        )
      ],
    ).show();
  }

  _stopTimer(){
    timer.cancel();
    isrunning = false;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

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

                ),


                //corgi pic
                Column(
                  children: [
                    Image.asset('assets/images/butt.gif',
                      width: 130,
                      height: 130,),
                  ],
                ),

                Padding(
                  padding  : EdgeInsets.only(top:20.0),

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
                      TimeInMin.toString(),
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
                                                          "Minutes set",
                                                          style: TextStyle(
                                                            fontSize: 20.0,
                                                          )
                                                      ),
                                                      SizedBox(height: 10.0),
                                                      Text(
                                                        timechosen.toString(),
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
                                                          "Points Earned",
                                                          style: TextStyle(
                                                            fontSize: 20.0,
                                                          )
                                                      ),
                                                      SizedBox(height: 10.0),
                                                      Text(
                                                        points.toString(),
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

                                  Expanded(
                                      child: Row(
                                          children: <Widget>[
                                            Expanded(
                                                child: Column(
                                                    children: <Widget> [
                                                 RaisedButton(
                                                onPressed: _StartTimer,
                                                    color: Colors.blue,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(100.0),
                                                    ),

                                                    child: Padding(
                                                        padding: EdgeInsets.all(15.0),
                                                        child: Text("Start",
                                                            style: GoogleFonts.chewy(
                                                                color: Colors.white,
                                                                fontSize: 22.0
                                                            )
                                                        )
                                                    )
                                                 )]
                                                )
                                            ),




                                            Expanded(
                                                child: Column(
                                                    children: <Widget> [
                                                      RaisedButton(
                                                          onPressed: _stopTimer,
                                                          color: Colors.blue,
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(100.0),
                                                          ),

                                                          child: Padding(
                                                              padding: EdgeInsets.all(15.0),
                                                              child: Text("Stop",
                                                                  style: GoogleFonts.chewy(
                                                                      color: Colors.white,
                                                                      fontSize: 22.0
                                                                  )
                                                              )
                                                          )
                                                      )
                                                    ]
                                                )
                                            ),

                                            Expanded(
                                                child: Column(
                                                    children: <Widget> [
                                                      RaisedButton(
                                                          onPressed: _resetTimer,
                                                          color: Colors.blue,
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(100.0),
                                                          ),

                                                          child: Padding(
                                                              padding: EdgeInsets.all(15.0),
                                                              child: Text("Reset",
                                                                  style: GoogleFonts.chewy(
                                                                      color: Colors.white,
                                                                      fontSize: 22.0
                                                                  )
                                                              )
                                                          )
                                                      )
                                                    ]
                                                )
                                            ),


                                          ]
                                      )
                                  ),



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

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}