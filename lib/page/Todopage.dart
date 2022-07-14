import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:timer/globals.dart';


void main() {
  runApp(const MytodolistApp());
}

class MytodolistApp extends StatelessWidget {
  const MytodolistApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // This will be displayed on the screen
  String? _content;

  // Find the Documents path
  Future<String> _getDirPath() async {
    final dir = await getApplicationDocumentsDirectory();
    return dir.path;
  }

  // This function is triggered when the "Read" button is pressed
  Future<void> _readData() async {
    final dirPath = await _getDirPath();
    final myFile = File('$dirPath/data.txt');
    final data = await myFile.readAsString(encoding: utf8);
    setState(() {
      _content = data;

      if (_content != null || _content != "") {
        globalnotepad = _content.toString();
      }

      print(globalnotepad);
    });
  }

  // TextField controller

  // This function is triggered when the "Write" buttion is pressed
  Future<void> _writeData() async {
    final _dirPath = await _getDirPath();

    final _myFile = File('$_dirPath/data.txt');
    // If data.txt doesn't exist, it will be created automatically

    await _myFile.writeAsString(_textController.text);
    //_textController.clear();
    if (_content != null || _content != "") {
      globalnotepad = _content.toString();
    }

    print(globalnotepad);
  }

  @override
  final _textController = TextEditingController(text: globalnotepad);
  bool _isEditingText = false;

  void initState() {
    super.initState();
    _readData();

    setState(() {
      globalnotepad = _content.toString();
      final _textController = TextEditingController(text: globalnotepad);
      final ScrollController _scrollController = ScrollController();
      final FocusNode _focusNode = FocusNode();
    });
  }

  @override
  FocusNode nodeFirst = FocusNode();
  Widget _editTextField() {
    if (_isEditingText)
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body:  TextField(

              scrollPadding: EdgeInsets.all(1.0),
              keyboardType: TextInputType.multiline,
              maxLines: null,
              //grow automatically

              autofocus: true,
              controller: _textController,
              //onSubmitted: currentIsComposing ? _handleSubmitted : null,

            ),
            floatingActionButton: FloatingActionButton(
            onPressed: () {
              setState((){
              _writeData();
              _isEditingText = false;
            });}
            ,child: Icon(Icons.done_outline_outlined))
        ),
      );
    return InkWell(
        onTap: () {
          setState(() {
            _isEditingText = true;
          });
        },


        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child:
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              globalnotepad,
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
              ),
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    void _ShowTextEditingPanel(BuildContext context) {
      showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (context) {
            return Column(children: [
              FractionallySizedBox(
                heightFactor: 0.9,
                child: Column(
                  children: <Widget>[
                    Container(
                        padding:
                        EdgeInsets.symmetric(vertical: 20, horizontal: 20),

                        child: new SingleChildScrollView(
                            scrollDirection: Axis.vertical, //.horizontal
                            child: new Container(
                              color: globalcolor,
                              padding: new EdgeInsets.all(7.0),
                              child: new ConstrainedBox(
                                constraints: new BoxConstraints(
                                  maxHeight: 55.0,
                                ),
                                child: new SingleChildScrollView(
                                  scrollDirection: Axis.vertical,
                                  reverse: true,

                                  // here's the actual text box
                                  child: new TextField(
                                    keyboardType: TextInputType.multiline,
                                    maxLines: null,
                                    //grow automatically
                                    //focusNode: mrFocus,
                                    controller: _textController,
                                    //onSubmitted: currentIsComposing ? _handleSubmitted : null,
                                    decoration: new InputDecoration.collapsed(
                                      hintText: 'Please enter a lot of text',
                                    ),
                                  ),
                                  // ends the actual text box
                                ),
                              ),

                              /*
                        TextFormField(
                          maxLines: null, //wrap text
                          autofocus: true,
                          autocorrect: true,
                            controller: _textController,
                            //enabled: _isEnable,

                            keyboardType: TextInputType.multiline,
                            textInputAction: TextInputAction.newline,
                            decoration: InputDecoration(fillColor: Colors.grey[100]),
                        ),
                      ),

                         */
                            ))),
                    //SizedBox(height: 20),


                    RaisedButton(
                        color: globalcolor,
                        child: Text(
                          "Update",
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          _writeData();
                          Navigator.pop(context);
                        }),
                  ],
                ),
              ),
            ]);
          });
    }

    return Scaffold(
        resizeToAvoidBottomInset: false,
      appBar: AppBar(
          backgroundColor: globalcolor,
          title: const Text('Notepad'),
          actions: <Widget>[
        TextButton.icon(
            icon: Icon(Icons.copy_all_outlined),
            label: Text("copy text"),
            style: ButtonStyle(
                foregroundColor:
                MaterialStateProperty.all<Color>(Colors.black)),
            onPressed: () {
              Clipboard.setData(ClipboardData(text: _content));
            }),
        TextButton.icon(
          icon: Icon(Icons.refresh),
          label: Text("refresh"),
          style: ButtonStyle(
              foregroundColor:
              MaterialStateProperty.all<Color>(Colors.black)),
          onPressed: () => _readData(),
        ),
      ]),
      body:
        /*
            TextField(
              controller: _textController,
              decoration: const InputDecoration(labelText: 'Enter your name'),
            ),
            ElevatedButton(
              child: const Text('Save to file'),
              onPressed: _writeData,
            ),

             */



      Container(
        child: _editTextField(),
      ));

    /*
            ElevatedButton(
              child: const Text('Read my name from the file'),
              onPressed: _readData,
            )

             */

  }
/*

class MytodolistApp extends StatelessWidget {
  const MytodolistApp({super.key});

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return TodoApp(storage: ToDoListStorage()
    );
  }
}


class ToDoListStorage {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();


    return directory.path;

  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/todolist.txt');
  }

  Future<String> readlist() async {
    try {
      final file = await _localFile;

      // Read the file
      final contents = await file.readAsString();

      return contents;
    } catch (e) {
      // If encountering an error, return 0
      return "error";
    }
  }

  Future<File> writelist(String list) async {
    final file = await _localFile;

    // Write the file
    return file;
  }
}


class TodoApp extends StatefulWidget {
  const TodoApp({super.key, required this.storage});

  final ToDoListStorage storage;

  @override
  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  String text ='' ;

  @override
  void initState() {
    super.initState();
    widget.storage.readlist().then((value) {
      setState(() {
        text = value;
      });
    });
  }

  TextEditingController _controller =
  TextEditingController();

  bool _isEnable = false;

  @override
  Widget build(BuildContext context) {
    void _ShowTextEditingPanel(BuildContext context) {
      showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (context) {
            return FractionallySizedBox(
              heightFactor: 0.9,
              child:


              Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    child: TextField(
                      controller: _controller,
                      //enabled: _isEnable,

                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
                        autofocus: true,
                        maxLines: null,
                        decoration: InputDecoration(fillColor: Colors.grey[100])


                    ),

                  ),
                  SizedBox(height: 20),
                  RaisedButton(
                      color: globalcolor,
                      child: Text(
                        "Update",
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () async {
                        Navigator.pop(context);
                      }

                  ),
                ],
              ),


            );
          });
    }

    return Scaffold(
        appBar: new AppBar(
          title: new Text('Notepad'),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child:
          new SingleChildScrollView(
            scrollDirection: Axis.vertical,
            reverse: true,
            child:


            TextField(
              decoration: InputDecoration(
                //labelText: 'Key in your notes here, or create a to-do list!',
                border: InputBorder.none,
              ),
              enabled: false,
              controller: _controller,
            ),
          ),),

        floatingActionButton: FloatingActionButton(
            onPressed: () => _ShowTextEditingPanel(context),

            child: Icon(Icons.edit))
    );
  }
}


 */

}
