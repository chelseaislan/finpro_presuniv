// @dart=2.9
// selected, discover, searchpro

import 'package:finpro_max/models/colors.dart';
import 'package:finpro_max/ui/widgets/card_swipe_widgets/card_likedislike_icon.dart';
import 'package:flutter/material.dart';

class FloatingDoubleButtons extends StatelessWidget {
  const FloatingDoubleButtons({
    Key key,
    @required this.size,
    @required this.onDislikeTap,
    @required this.onLikeTap,
  });

  final Size size;
  final Function() onDislikeTap;
  final Function() onLikeTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        size.width * 0.25,
        0,
        size.width * 0.25,
        size.width * 0.07,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(size.width * 0.08),
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 6.0,
              spreadRadius: 0.01,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            iconWidget(
              "assets/images/close.png",
              size.width * 0.16,
              size.height * 0.1,
              onDislikeTap,
            ),
            SizedBox(width: size.width * 0.05),
            iconWidget(
              "assets/images/heart.png",
              size.width * 0.16,
              size.height * 0.1,
              onLikeTap,
            ),
          ],
        ),
      ),
    );
  }
}
