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
            textColor: pureWhite,
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

class ModalPopupFourButton extends StatelessWidget {
  const ModalPopupFourButton({
    Key key,
    @required this.size,
    @required this.title,
    @required this.image,
    @required this.description,
    @required this.label1,
    @required this.label2,
    @required this.label3,
    @required this.label4,
    @required this.onPressed1,
    @required this.onPressed2,
    @required this.onPressed3,
    @required this.onPressed4,
    @required this.textColor1,
    @required this.btn1,
    @required this.textColor2,
    @required this.btn2,
    @required this.textColor3,
    @required this.btn3,
    @required this.textColor4,
    @required this.btn4,
  }) : super(key: key);

  final Size size;
  final String title, image, description, label1, label2, label3, label4;
  final Function() onPressed1, onPressed2, onPressed3, onPressed4;
  final Color textColor1,
      btn1,
      textColor2,
      btn2,
      textColor3,
      btn3,
      textColor4,
      btn4;

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
            labelText: label1,
            onPressedTo: onPressed1,
            textColor: textColor1,
            btnColor: btn1,
          ),
          const SizedBox(height: 10),
          BigWideButton(
            labelText: label2,
            onPressedTo: onPressed2,
            textColor: textColor2,
            btnColor: btn2,
          ),
          const SizedBox(height: 10),
          BigWideButton(
            labelText: label3,
            onPressedTo: onPressed3,
            textColor: textColor3,
            btnColor: btn3,
          ),
          const SizedBox(height: 10),
          BigWideButton(
            labelText: label4,
            onPressedTo: onPressed4,
            textColor: textColor4,
            btnColor: btn4,
          ),
        ],
      ),
    );
  }
}
