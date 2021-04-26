import 'package:flutter/material.dart';

// import '../../../size_config.dart';
import 'icon_btn_with_counter.dart';
import 'search_feild.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SearchField(),
          IconBtnWithCounter(
            svgSrc: "dummy",
            numOfitem: 3,
            press: () {},
          ),
        ],
      ),
    );
  }
}
