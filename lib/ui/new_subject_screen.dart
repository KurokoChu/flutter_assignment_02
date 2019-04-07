import 'package:flutter/material.dart';

import 'package:flutter_assignment_02/models/todo.dart';

class NewSubjectScreen extends StatefulWidget {
  final TodoProvider todo;

  NewSubjectScreen({
    @required this.todo,
  });

  @override
  _NewSubjectScreenState createState() => _NewSubjectScreenState();
}

class _NewSubjectScreenState extends State<NewSubjectScreen> {
  final _formkey = GlobalKey<FormState>();
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Subject"),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Form(
          key: _formkey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                  decoration: InputDecoration(
                    labelText: "Subject",
                  ),
                  controller: _controller,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please fill subject";
                    }
                  }),
              RaisedButton(
                child: Text("Save"),
                onPressed: () async {
                  _formkey.currentState.validate();
                  if (_controller.text.length == 0) {
                    return;
                  } else {
                    await widget.todo.open("todo.db");
                    Todo data = Todo();
                    data.title = _controller.text;
                    data.done = false;
                    await widget.todo.insert(data);
                    _controller.text = "";
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
