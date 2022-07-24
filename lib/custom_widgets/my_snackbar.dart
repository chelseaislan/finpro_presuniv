// @dart=2.9
// Start 30/41

import 'package:finpro_max/models/colors.dart';
import 'package:flutter/material.dart';

SnackBar mySnackbar({text, duration, background}) {
  return SnackBar(
    backgroundColor: background,
    content: Text(
      text,
      style: const TextStyle(fontFamily: "TTCommons", fontSize: 18),
    ),
    duration: Duration(seconds: duration),
    padding: const EdgeInsets.all(20),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    margin: const EdgeInsets.all(20),
    elevation: 15,
  );
}

SnackBar myLoadingSnackbar({text, duration, background}) {
  return SnackBar(
    backgroundColor: background,
    content: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: const TextStyle(fontFamily: "TTCommons", fontSize: 18),
        ),
        CircularProgressIndicator(color: pureWhite),
      ],
    ),
    duration: Duration(seconds: duration),
    padding: const EdgeInsets.all(20),
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    margin: const EdgeInsets.all(20),
    elevation: 15,
  );
}
