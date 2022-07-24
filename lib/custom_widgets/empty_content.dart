// @dart=2.9
import 'package:finpro_max/custom_widgets/buttons/big_wide_button.dart';
import 'package:finpro_max/custom_widgets/text_styles.dart';
import 'package:finpro_max/models/colors.dart';
import 'package:flutter/material.dart';

class EmptyContent extends StatelessWidget {
  const EmptyContent({
    Key key,
    @required this.size,
    @required this.asset,
    @required this.header,
    @required this.description,
    @required this.buttonText,
    @required this.onPressed,
  }) : super(key: key);

  final Size size;
  final String asset;
  final String header;
  final String description;
  final String buttonText;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            asset,
            width: size.width,
          ),
          SizedBox(height: size.height * 0.02),
          HeaderTwoText(
            text: header,
            color: secondBlack,
            align: TextAlign.center,
          ),
          SizedBox(height: size.height * 0.01),
          DescText(
            text: description,
            color: secondBlack,
            align: TextAlign.center,
          ),
          SizedBox(height: size.height * 0.02),
          BigWideButton(
            labelText: buttonText,
            onPressedTo: onPressed,
            textColor: pureWhite,
            btnColor: primary1,
          ),
        ],
      ),
    );
  }
}
