// @dart=2.9
// Start 30/41

import 'package:flutter/material.dart';

void pageTurn(Widget pageName, context) {
  Navigator.push(
    context,
    PageRouteBuilder(
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
      pageBuilder: (context, animation1, animation2) {
        return pageName;
      },
    ),
  );
}
