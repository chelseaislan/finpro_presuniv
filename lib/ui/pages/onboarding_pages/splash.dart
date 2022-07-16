// @dart=2.9
import 'package:finpro_max/models/colors.dart';
import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        // Background gradient Splash Screen
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [primary1, appBarColor],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Image.asset(
            "assets/images/logo_login.png",
            width: size.width * 0.5,
            height: size.height * 0.5,
          ),
        ),
      ),
    );
  }
}
