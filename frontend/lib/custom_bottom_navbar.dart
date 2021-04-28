import 'package:flutter/material.dart';

import './screens/home_screen.dart';

import './constants.dart';
import './enums.dart';

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    Key key,
    @required this.selectedMenu,
  }) : super(key: key);

  final MenuState selectedMenu;

  @override
  Widget build(BuildContext context) {
    final Color inActiveIconColor = Color(0xFFB6B6B6);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20,
            color: Color(0xFFDADADA).withOpacity(0.15),
          ),
        ],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: SafeArea(
          top: false,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(
                  Icons.home,
                  color: MenuState.home == selectedMenu
                      ? kPrimaryColor
                      : Colors.black,
                ),
                onPressed: () => Navigator.pushReplacementNamed(
                    context, HomeScreen.routeName),
              ),
              IconButton(
                icon: Icon(Icons.favorite),
                color: MenuState.favourite == selectedMenu
                    ? kPrimaryColor
                    : Colors.black,
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/favorites');
                },
              ),
              IconButton(
                icon: Icon(Icons.shopping_bag),
                color: MenuState.orders == selectedMenu
                    ? kPrimaryColor
                    : Colors.black,
                onPressed: () {
                  Navigator.pushReplacementNamed(context, '/orders');
                },
              ),
              IconButton(
                  icon: Icon(
                    Icons.face,
                    color: MenuState.profile == selectedMenu
                        ? kPrimaryColor
                        : Colors.black,
                  ),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/profile');
                  }),
            ],
          )),
    );
  }
}
