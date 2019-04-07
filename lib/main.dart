import 'package:flutter/material.dart';

import 'package:flutter_assignment_02/containers/menu_container.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        navigatorKey: navigatorKey,
        title: 'Todo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: "/",
        routes: {
          "/": (context) => MenuBarContainer(),
        });
  }
}
