import 'package:flutter/material.dart';

import 'profile_menu.dart';
import 'profile_pic.dart';

class Body extends StatelessWidget {
  final snackBar = SnackBar(content: Text('LogOut Successfull!'));
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          ProfilePic(),
          SizedBox(height: 20),
          ProfileMenu(
            text: "My Account",
            icon: Icons.face,
            press: () => {},
          ),
          ProfileMenu(
            text: "My Orders",
            icon: Icons.shopping_bag,
            press: () {},
          ),
          ProfileMenu(
            text: "Favorites",
            icon: Icons.favorite,
            press: () {},
          ),
          ProfileMenu(
            text: "Contact",
            icon: Icons.phone,
            press: () {},
          ),
          ProfileMenu(
            text: "Log Out",
            icon: Icons.logout,
            press: () {
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              Future.delayed(Duration(seconds: 2));
              Navigator.pushReplacementNamed(context, '/home');
            },
          ),
        ],
      ),
    );
  }
}
