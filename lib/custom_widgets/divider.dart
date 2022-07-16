// @dart=2.9
import 'package:flutter/material.dart';

class PaddingDivider extends StatelessWidget {
  final Color color;

  const PaddingDivider({this.color});
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.only(
        top: size.width * 0.02,
        bottom: size.width * 0.05,
      ),
      child: Divider(
        color: color,
        height: 1,
        thickness: 0.2,
      ),
    );
  }
}
