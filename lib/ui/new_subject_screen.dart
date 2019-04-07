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
  void initState() {
    super.initState();

    widget.todo.open("todo.db");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Subject"),
      ),
      body: Form(
        key: _formkey,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: ListView(
            children: <Widget>[
              TextFormField(
                  controller: _controller,
                  decoration: InputDecoration(
                    labelText: "Subject",
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please fill subject";
                    }
                  }),
              RaisedButton(
                child: Text("Save"),
                onPressed: () async {
                  if (_formkey.currentState.validate()) {
                    Todo data = Todo(title: _controller.text);
                    await widget.todo.insert(data);
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
