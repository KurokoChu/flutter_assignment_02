import 'package:flutter/material.dart';

import 'package:flutter_assignment_02/models/todo.dart';

class TaskCompletedScreen extends StatefulWidget {
  final List<Todo> tasksCompleted;
  final TodoProvider todo;

  TaskCompletedScreen({
    Key key,
    @required this.tasksCompleted,
    @required this.todo,
  }) : super(key: key);

  _TaskCompletedScreenState state;

  @override
  _TaskCompletedScreenState createState() {
    state = _TaskCompletedScreenState();
    return state;
  }
}

class _TaskCompletedScreenState extends State<TaskCompletedScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Container(
        child: FutureBuilder<List<Todo>>(
            future: widget.todo.getAllTodo(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Todo>> snapshot) {
              widget.tasksCompleted.clear();
              if (snapshot.hasData) {
                for (var items in snapshot.data) {
                  if (items.done == true) {
                    widget.tasksCompleted.add(items);
                  }
                }

                return widget.tasksCompleted.length != 0
                    ? ListView.builder(
                        padding: EdgeInsets.all(2.0),
                        itemCount: widget.tasksCompleted.length,
                        itemBuilder: (BuildContext context, int index) {
                          Todo item = widget.tasksCompleted[index];
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
                        child: Text("No data found.."),
                      );
              } else {
                return Center(
                  child: Text("No data found.."),
                );
              }
            }),
      )),
    );
  }

  deleteAll() async {
    for (var task in widget.tasksCompleted) {
      await widget.todo.delete(task.id);
    }
    setState(() {
      widget.tasksCompleted.clear();
    });
  }
}
