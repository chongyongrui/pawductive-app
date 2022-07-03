import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Reading and Writing Files',
      home: TodoApp(storage: ToDoListStorage()),
    ),
  );
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
    return file.writeAsString('$list');
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
  String text ='';

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
          isScrollControlled:true,
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
                        enabled: _isEnable,

                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
                        autofocus: true,
                        maxLines: null,
                        decoration: InputDecoration(fillColor: Colors.grey[100])),

                  ),
                  SizedBox(height: 20),
                  RaisedButton(
                    color: Colors.blue,
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
            labelText: 'Key in your notes here, or create a to-do list!',
            border: InputBorder.none,
          ),
          enabled: false  ,
            controller: _controller,
           ),
      ),),

      floatingActionButton: FloatingActionButton(
          onPressed: () => _ShowTextEditingPanel(context),

          child: Icon(Icons.edit))
    );
  }
}



/*
class Todo {
  Todo({required this.name, required this.checked});
  final String name;
  bool checked;
}

class TodoItem extends StatefulWidget {
  TodoItem({
    required this.todo,
    required this.onTodoChanged,
  }) : super(key: ObjectKey(todo));

  final Todo todo;
  final onTodoChanged;

  @override
  State<TodoItem> createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  TextStyle? _getTextStyle(bool checked) {
    if (!checked) return null;

    return TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        widget.onTodoChanged(widget.todo);
      },
      leading: CircleAvatar(
        child: Text(widget.todo.name[0]),
      ),
      title: Text(widget.todo.name, style: _getTextStyle(widget.todo.checked)),
    );
  }
}

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => new _TodoListState();
}

class _TodoListState extends State<TodoList> with WidgetsBindingObserver{
  late TextEditingController controller;
  @override

  initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

  }


  @override
  void dispose() {

    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }


  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.inactive || state == AppLifecycleState.paused) return;

    final isBackground = state == AppLifecycleState.paused;
  }

  final TextEditingController _textFieldController = TextEditingController();
  final List<Todo> _todos = <Todo>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Todo list'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 8.0),
        children: _todos.map((Todo todo) {
          return TodoItem(
            todo: todo,
            onTodoChanged: _handleTodoChange,
          );
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => _displayDialog(),
          tooltip: 'Add Item',
          child: Icon(Icons.add)),
    );
  }

  void _handleTodoChange(Todo todo) {
    setState(() {
      todo.checked = !todo.checked;
    });
  }

  void _addTodoItem(String name) {
    setState(() {
      _todos.add(Todo(name: name, checked: false));
    });
    _textFieldController.clear();
  }

  Future<void> _displayDialog() async {

    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add a new todo item'),
          content:

          TextField(
            controller: _textFieldController,
            decoration: const InputDecoration(hintText: 'Type your new todo'),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Add'),
              onPressed: () {
                if (_textFieldController.text != "") {
                  _addTodoItem(_textFieldController.text);
                }
                Navigator.of(context).pop();
              }
                ,
            ),
          ],
        );
      },
    );
  }
}

class TodoApp extends StatelessWidget {
  @override


  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Todo list',
      home: new TodoList(),
    );
  }
}

 */

