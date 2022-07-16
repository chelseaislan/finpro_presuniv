import 'package:flutter/material.dart';

class BigTextButton extends StatelessWidget {
  const BigTextButton(
      {@required this.labelText,
      @required this.onPressedTo,
      @required this.labelColor});

  final String labelText;
  final Function() onPressedTo;
  final Color labelColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.06,
      child: TextButton(
        onPressed: onPressedTo,
        child: Text(
          labelText,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: labelColor,
          ),
        ),
      ),
    );
  }
}

class SmallTextButton extends StatelessWidget {
  const SmallTextButton(
      {@required this.labelText,
      @required this.onPressedTo,
      @required this.labelColor});

  final String labelText;
  final Function() onPressedTo;
  final Color labelColor;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressedTo,
      child: Text(
        labelText,
        style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: labelColor,
            decoration: TextDecoration.underline),
      ),
    );
  }
}
