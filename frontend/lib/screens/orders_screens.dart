import 'package:flutter/material.dart';
import '../custom_bottom_navbar.dart';
import '../enums.dart';
import '../models/Orders.dart';

import '../components/orders/body.dart';

class OrdersScreen extends StatelessWidget {
  static String routeName = "/orders";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Body(),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.orders),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Your Orders",
            style: TextStyle(color: Colors.black),
          ),
          Text(
            " ${demoOrders.length} items",
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );
  }
}
