import 'package:flutter/material.dart';

import 'package:flutter_assignment_02/ui/task_screen.dart';
import 'package:flutter_assignment_02/ui/task_completed_screen.dart';
import 'package:flutter_assignment_02/ui/new_subject_screen.dart';
import 'package:flutter_assignment_02/models/todo.dart';

class MenuBarContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MenuBar();
  }
}

class MenuBar extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<MenuBar> with SingleTickerProviderStateMixin {
  final PageStorageBucket bucket = PageStorageBucket();

  final Key keyOne = PageStorageKey('pageOne');
  final Key keyTwo = PageStorageKey('pageTwo');

  int currentTabIndex = 0;
  List<Widget> pages;
  TaskScreen pageOne;
  TaskCompletedScreen pageTwo;
  Widget currentPage;
  List actionButtons;

  static TodoProvider todo = TodoProvider();

  @override
  void initState() {
    super.initState();

    pageOne = TaskScreen(
      key: keyOne,
      todo: todo,
    );
    pageTwo = TaskCompletedScreen(
      key: keyTwo,
      todo: todo,
    );
    pages = [pageOne, pageTwo];
    currentPage = pageOne;
  }

  @override
  Widget build(BuildContext context) {
    List actionButtons = <Widget>[
      IconButton(
        icon: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => NewSubjectScreen(todo: todo)));
        },
      ),
      IconButton(
        icon: Icon(Icons.delete),
        onPressed: () {
          pageTwo.state.deleteAll();
        },
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("Todo"),
        actions: <Widget>[actionButtons[currentTabIndex]],
      ),
      body: PageStorage(
        child: currentPage,
        bucket: bucket,
      ),
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Theme.of(context).accentColor,
        currentIndex: currentTabIndex,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            title: Text('Task'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.done_all),
            title: Text('Completed'),
          ),
        ],
        onTap: (int index) {
          setState(() {
            currentTabIndex = index;
            currentPage = pages[index];
          });
        },
      ),
    );
  }
}
