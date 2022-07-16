import 'package:finpro_max/custom_widgets/buttons/big_wide_button.dart';
import 'package:finpro_max/custom_widgets/text_styles.dart';
import 'package:finpro_max/models/colors.dart';
import 'package:flutter/material.dart';

class ModalPopupOneButton extends StatelessWidget {
  const ModalPopupOneButton({
    Key key,
    @required this.size,
    @required this.title,
    @required this.image,
    @required this.description,
    @required this.onPressed,
  }) : super(key: key);

  final Size size;
  final String title, image, description;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 23, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          HeaderThreeText(
            text: title,
            color: secondBlack,
            align: TextAlign.center,
          ),
          Image.asset(
            image,
            width: size.width * 0.8,
            height: size.width * 0.6,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: DescText(
              text: description,
              color: secondBlack,
              align: TextAlign.center,
            ),
          ),
          BigWideButton(
            labelText: "Okay",
            onPressedTo: onPressed,
            textColor: white,
            btnColor: primary1,
          ),
        ],
      ),
    );
  }
}

class ModalPopupTwoButton extends StatelessWidget {
  const ModalPopupTwoButton({
    Key key,
    @required this.size,
    @required this.title,
    @required this.image,
    @required this.description,
    @required this.labelTop,
    @required this.labelBottom,
    @required this.onPressedTop,
    @required this.onPressedBottom,
    @required this.textColorTop,
    @required this.btnTop,
    @required this.textColorBottom,
    @required this.btnBottom,
  }) : super(key: key);

  final Size size;
  final String title, image, description, labelTop, labelBottom;
  final Function() onPressedTop, onPressedBottom;
  final Color textColorTop, btnTop, textColorBottom, btnBottom;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 23, 20, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          HeaderThreeText(
            text: title,
            color: secondBlack,
            align: TextAlign.center,
          ),
          Image.asset(
            image,
            width: size.width * 0.8,
            height: size.width * 0.6,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: DescText(
              text: description,
              color: secondBlack,
              align: TextAlign.center,
            ),
          ),
          BigWideButton(
            labelText: labelTop,
            onPressedTo: onPressedTop,
            textColor: textColorTop,
            btnColor: btnTop,
          ),
          const SizedBox(height: 10),
          BigWideButton(
            labelText: labelBottom,
            onPressedTo: onPressedBottom,
            textColor: textColorBottom,
            btnColor: btnBottom,
          ),
        ],
      ),
    );
  }
}
