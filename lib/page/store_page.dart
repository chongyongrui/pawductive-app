import 'package:flutter/material.dart';
import 'package:timer/page/points_form.dart';

//incomplete

class StorePage extends StatefulWidget {
  @override
  State<StorePage> createState() => _StorePage();
}

class _StorePage extends State<StorePage> {
  @override
  Widget build(BuildContext context) {
    return Column(
        children: <Widget>[
          Container(
            color: Colors.orange[200],
            child: Row(
              children: <Widget>[
                Image.asset("assets/images/catstatic.png",
                    width: 100.0,
                    height: 100.0
                ),
                Container(
                    width: 100.0,
                    height: 100.0,
                    color: Colors.orange[200],
                    child: const Align(
                        alignment: Alignment.center,
                        child: Text("Cat",
                            style: TextStyle(fontSize: 25.0)
                        )
                    )
                ),
                Container(
                    width: 100.0,
                    height: 100.0,
                    color: Colors.orange[200],
                    child: const Align(
                        alignment: Alignment.center,
                        child: Text("200",
                            style: TextStyle(fontSize: 25.0)
                        )
                    )
                ),
                ElevatedButton.icon(
                    icon: Icon(Icons.add_sharp),
                    onPressed: null,
                    label: Text("add"),
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(
                          Colors.black),
                    )
                )


              ],
            ),
          ),
          Container(
            color: Colors.orange[200],
            child: Row(
              children: <Widget>[
                Image.asset("assets/images/llamastatic.png",
                    width: 100.0,
                    height: 100.0
                ),
                Container(
                    width: 100.0,
                    height: 100.0,
                    color: Colors.orange[200],
                    child: const Align(
                        alignment: Alignment.center,
                        child: Text("Llama",
                            style: TextStyle(fontSize: 25.0)
                        )
                    )
                ),
                Container(
                    width: 100.0,
                    height: 100.0,
                    color: Colors.orange[200],
                    child: const Align(
                        alignment: Alignment.center,
                        child: Text("200",
                            style: TextStyle(fontSize: 25.0)
                        )
                    )
                ),
                ElevatedButton.icon(
                    icon: Icon(Icons.add_sharp),
                    onPressed: null,
                    label: Text("add"),
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(
                          Colors.black),
                    )
                )


              ],
            ),
          ),
          Container(
            color: Colors.orange[200],
            child: Row(
              children: <Widget>[
                Image.asset("assets/images/catstatic.png",
                    width: 100.0,
                    height: 100.0
                ),
                Container(
                    width: 100.0,
                    height: 100.0,
                    color: Colors.orange[200],
                    child: const Align(
                        alignment: Alignment.center,
                        child: Text("Cat",
                            style: TextStyle(fontSize: 25.0)
                        )
                    )
                ),
                Container(
                    width: 100.0,
                    height: 100.0,
                    color: Colors.orange[200],
                    child: const Align(
                        alignment: Alignment.center,
                        child: Text("200",
                            style: TextStyle(fontSize: 25.0)
                        )
                    )
                ),
                ElevatedButton.icon(
                    icon: Icon(Icons.add_sharp),
                    onPressed: null,
                    label: Text("add"),
                    style: ButtonStyle(
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
                    )
                )


              ],
            ),
          ),
        ]
    );
  }
}