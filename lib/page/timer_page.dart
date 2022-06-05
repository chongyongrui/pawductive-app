import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:timer/globals.dart';





class _IntegerExample extends StatefulWidget {
  @override
  __IntegerExampleState createState() => __IntegerExampleState();
}

class __IntegerExampleState extends State<_IntegerExample> {



  @override
  Widget build(BuildContext context) {

    return Column(

      children: <Widget>[
        SizedBox(height: 16),
        Text('Time Chosen:', style: Theme.of(context).textTheme.headline6),
        NumberPicker(
          value: globalTimechosen,
          minValue: 0,
          maxValue: 200,
          step: 10,
          haptics: true,
          onChanged: (value) => setState(() => globalTimechosen = value),
        ),
        SizedBox(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.remove),
              onPressed: () => setState(() {
                final newValue = globalTimechosen - 10;
               globalTimechosen = newValue.clamp(0, 200);
              }),
            ),
            Text('$globalTimechosen Minutes'),
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () => setState(() {
                final newValue = globalTimechosen + 10;
                globalTimechosen = newValue.clamp(0, 200);
              }),
            ),

          ],
        ),
        SizedBox(height: 32),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RaisedButton(
                onPressed: () {
                 // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>picktime()));

                  Navigator.pop(context);

                },

                color: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100.0),
                ),

                child: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text("Set Minutes",
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        )
                    )


                )
            ),
          ],
        )

      ],
    );
  }
}

class picktime extends StatefulWidget {
  @override
  _picktimeState createState() => _picktimeState();
}

class _picktimeState extends State<picktime> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Set your time'),
          backgroundColor: Colors.blueAccent),
      body: Center(

        child:

        _IntegerExample(),


      ),

    );
  }
}




class TimerPage extends StatefulWidget {
  
  @override
  _TimerPageState createState() => _TimerPageState();



}

class _TimerPageState extends State<TimerPage> with WidgetsBindingObserver
{
   initState(){
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose(){
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state){
    super.didChangeAppLifecycleState(state);

   if (state== AppLifecycleState.inactive || state == AppLifecycleState.detached) return;

    final isBackground = state == AppLifecycleState.paused;

    if (isBackground) {
      _stopTimer();
    } else {
      _StartTimer();
    }
  }



  double percent = 0;
  int TimeInMin = globalTimechosen;
  int TimeInSec = globalTimechosen * 60;
  int points = 0;
  int timechosen = globalTimechosen;
  bool isrunning = false;

  late Timer timer;
  String message = "Time is up!";

  _StartTimer(){

    setState ((){
      TimeInMin = globalTimechosen;
    });
    isrunning = true;

      int TimeInSec = TimeInMin * 60;
      int Time = TimeInMin * 60;
      //double SecPercent = (Time / 100);
      double SecPercent = (1/TimeInSec);
      timer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {

          if (Time > 0 && isrunning == true) {
            Time--;
            if (Time % 60 == 0) {
              TimeInMin--;
            }

            if (Time % 2 == 0) {
              points++;
              print(TimeInMin);
              print(globalTimechosen);
            }


            if ((percent + SecPercent) <1) {
              percent += SecPercent;
            } else{
              percent = 1;
            }

          } else {
            percent = 0;
            TimeInMin = timechosen;
            timer.cancel();
            Alert(
              context: context,
              type: AlertType.success,
              title: "Time is up",
              desc: "Hope you kept your focus!",
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
        });
      });

  }

  _resetTimer(){
    setState ((){
      TimeInMin= globalTimechosen;
      TimeInSec =  globalTimechosen * 60;
    });
    percent = 0;
    isrunning = false;
    //Alert(context: context, title: "Timer reset successful", desc: "Press start whenever ready").show();
    Alert(
      context: context,
      //type: AlertType.success,
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
                                                      RaisedButton(
                                                          onPressed: () {

                                                            Navigator.of(context).push(MaterialPageRoute(builder: (context)=> picktime()));
                                                            setState ((){
                                                              TimeInMin = globalTimechosen;
                                                            });

                                                          },



                                                          color: Colors.blue,
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(100.0),

                                                          ),

                                                          child: Padding(
                                                              padding: EdgeInsets.all(15.0),
                                                              child: Text("Set Minutes",
                                                                  style: TextStyle(
                                                                    fontSize: 20.0,
                                                                    color: Colors.white,
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
                                                      Text(
                                                          "Points Earned",
                                                          style: TextStyle(
                                                            fontSize: 20.0,
                                                          )
                                                      ),
                                                      SizedBox(height: 10.0),
                                                      Text(
                                                        "$points",
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