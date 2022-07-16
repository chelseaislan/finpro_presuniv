import 'package:finpro_max/custom_widgets/text_styles.dart';
import 'package:flutter/material.dart';

class CustomRadio extends StatelessWidget {
  const CustomRadio({
    @required this.text,
    @required this.color,
    @required this.radioColor,
    @required this.onRadioTap,
  });

  final String text;
  final Color color;
  final Color radioColor;
  final Function() onRadioTap;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onRadioTap,
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 15),
        child: Container(
          height: size.height * 0.06,
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: radioColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: DescText(
              text: text,
              color: color,
              align: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
