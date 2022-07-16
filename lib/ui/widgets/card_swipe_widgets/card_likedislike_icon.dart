// @dart=2.9
import 'package:flutter/material.dart';

Widget iconWidget(icon, width, height, onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Image.asset(
      icon,
      width: width,
      height: height,
    ),
  );
}
