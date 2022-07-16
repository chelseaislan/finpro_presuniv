import 'package:flutter/material.dart';

class BigWideButton extends StatelessWidget {
  const BigWideButton(
      {@required this.labelText,
      @required this.onPressedTo,
      @required this.textColor,
      @required this.btnColor});

  final String labelText;
  final Function() onPressedTo;
  final Color textColor;
  final Color btnColor;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.06,
      child: ElevatedButton(
        onPressed: onPressedTo,
        child: Text(
          labelText,
          style: TextStyle(
            fontSize: 20,
            color: textColor,
          ),
        ),
        style: ElevatedButton.styleFrom(
          primary: btnColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}

class BigWideButtonIcon extends StatelessWidget {
  const BigWideButtonIcon(
      {@required this.labelText,
      @required this.onPressedTo,
      @required this.textColor,
      @required this.btnColor,
      @required this.iconData});

  final String labelText;
  final Function() onPressedTo;
  final Color textColor;
  final Color btnColor;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.06,
      child: ElevatedButton.icon(
        onPressed: onPressedTo,
        label: Text(
          labelText,
          style: TextStyle(
            fontSize: 20,
            color: textColor,
          ),
        ),
        style: ElevatedButton.styleFrom(
          primary: btnColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        icon: Icon(iconData, color: textColor),
      ),
    );
  }
}
