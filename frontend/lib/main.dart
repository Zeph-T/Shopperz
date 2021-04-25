import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/products_screen.dart';

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
        '/products': (BuildContext context) => ProductsPage(),
        '/login': (BuildContext context) => LoginScreen(),
        '/register': (BuildContext context) => Registerscreen()
      },
    );
  }
}
