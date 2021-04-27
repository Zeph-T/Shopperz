import 'package:flutter/material.dart';
import './screens/cart_screen.dart';
import './screens/favorites_screen.dart';
import './screens/orders_screens.dart';
import './screens/profile_screen.dart';
import '/constants.dart';
import 'prewelcome.dart';
import 'screens/home_screen.dart';
import './screens/login_screen.dart';
import './screens/register_screen.dart';
import './screens/detail_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primaryColor: kPrimaryColor,
          accentColor: Colors.deepOrange[200],
          textTheme: TextTheme(
              headline1: TextStyle(fontWeight: FontWeight.bold, fontSize: 40))),
      home: PreWelcome(),
      routes: {
        '/login': (ctx) => LoginScreen(),
        '/register': (ctx) => Registerscreen(),
        '/home': (ctx) => HomeScreen(),
        '/details': (ctx) => DetailsScreen(),
        '/cart': (ctx) => CartScreen(),
        '/profile': (ctx) => ProfileScreen(),
        '/favorites': (ctx) => FavoritesScreen(),
        '/orders': (ctx) => OrdersScreen(),
      },
    );
  }
}
