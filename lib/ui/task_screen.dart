import 'package:flutter/material.dart';

import 'package:flutter_assignment_02/models/todo.dart';

class TaskScreen extends StatefulWidget {
  final List<Todo> tasks;
  final TodoProvider todo;

  TaskScreen({
    Key key,
    @required this.tasks,
    @required this.todo,
  }) : super(key: key);

  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Container(
        child: FutureBuilder<List<Todo>>(
            future: widget.todo.getAllTodo(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Todo>> snapshot) {
              if (snapshot.hasData) {
                widget.tasks.clear();
                for (var task in snapshot.data) {
                  if (task.done == false) {
                    widget.tasks.add(task);
                  }
                }

                return widget.tasks.length != 0
                    ? ListView.builder(
                        padding: EdgeInsets.all(2.0),
                        itemCount: widget.tasks.length,
                        itemBuilder: (BuildContext context, int index) {
                          Todo item = widget.tasks[index];
                          return Card(
                            color: Colors.white70,
                            child: ListTile(
                              title: Text(item.title),
                              trailing: Checkbox(
                                onChanged: (bool value) {
                                  setState(() {
                                    item.done = value;
                                  });
                                  widget.todo.update(item);
                                },
                                value: item.done,
                              ),
                            ),
                          );
                        },
                      )
                    : Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("No data found.."),
                          ],
                        ),
                      );
              } else {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("No data found.."),
                    ],
                  ),
                );
              }
            }),
      ),
    ));
  }
}
