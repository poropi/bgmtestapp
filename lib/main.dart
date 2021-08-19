import 'package:flutter/material.dart';

import 'PageA.dart';
import 'PageB.dart';
import 'PageC.dart';

void main() {
  runApp(MyApp());
}

// RouteObserverを利用するので、本件ではクラス外にて定義
var routeObserver = RouteObserver<PageRoute>();

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: "/pageA",
      routes: {
        "/pageA": (context) => PageA(),
        "/pageB": (context) => PageB(),
        "/pageC": (context) => PageC(),
      },
      navigatorObservers: [
        routeObserver,
      ],
    );
  }
}