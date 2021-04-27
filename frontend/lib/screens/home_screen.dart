import 'package:flutter/material.dart';
import 'package:shopperz/custom_bottom_navbar.dart';
import 'package:shopperz/enums.dart';

import '/components/home/body.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = "/home";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
    );
  }
}
