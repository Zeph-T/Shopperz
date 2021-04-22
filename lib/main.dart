import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.cyan[400],
          accentColor: Colors.deepOrange[200],
          textTheme: TextTheme(
              headline1: TextStyle(fontWeight: FontWeight.bold, fontSize: 40))),
      home: Registerscreen(),
      routes: {
        '/login': (ctx) => LoginScreen(),
        '/register': (ctx) => Registerscreen()
      },
    );
  }
}
