import 'package:finpro_max/custom_widgets/buttons/big_wide_button.dart';
import 'package:finpro_max/custom_widgets/divider.dart';
import 'package:finpro_max/custom_widgets/text_styles.dart';
import 'package:finpro_max/models/colors.dart';
import 'package:finpro_max/ui/widgets/card_swipe_widgets/card_photo.dart';
import 'package:flutter/material.dart';

class FourthCard extends StatelessWidget {
  const FourthCard({
    @required this.size,
    this.step,
    this.desc,
    this.selectedDate,
    this.onTapTop,
    this.onTapBottom,
  });

  final Size size;
  final String step, desc, selectedDate;
  final Function() onTapTop, onTapBottom;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.75,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: primary1,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset(
            "assets/images/calendar.png",
            height: size.width * 0.67,
          ),
          const SizedBox(height: 10),
          HeaderTwoText(
            text: "Let's go to the $step step!",
            color: pureWhite,
            align: TextAlign.center,
          ),
          const SizedBox(height: 10),
          DescText(
            text: desc,
            color: pureWhite,
            align: TextAlign.center,
          ),
          const SizedBox(height: 10),
          DescText(
            text: "Selected date:",
            color: pureWhite,
            align: TextAlign.center,
          ),
          HeaderTwoText(
            text: selectedDate,
            color: pureWhite,
            align: TextAlign.center,
          ),
          const SizedBox(height: 15),
          BigWideButton(
            labelText: "Select a date",
            onPressedTo: onTapTop,
            textColor: secondBlack,
            btnColor: gold,
          ),
          const SizedBox(height: 15),
          BigWideButton(
            labelText: "Continue",
            onPressedTo: onTapBottom,
            textColor: pureWhite,
            btnColor: primary5,
          ),
        ],
      ),
    );
  }
}

class ThirdCard extends StatelessWidget {
  const ThirdCard({
    @required this.size,
    this.image,
    this.title,
    this.topDesc,
    this.bottomDesc,
    this.label,
    this.onTap,
  });

  final Size size;
  final String image, title, topDesc, bottomDesc, label;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.75,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: primary1,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset(
            "assets/images/$image.png",
            height: size.width * 0.67,
          ),
          const SizedBox(height: 10),
          HeaderTwoText(
            text: title,
            color: pureWhite,
            align: TextAlign.center,
          ),
          const SizedBox(height: 10),
          DescText(
            text: topDesc,
            color: pureWhite,
            align: TextAlign.center,
          ),
          const SizedBox(height: 10),
          DescText(
            text: bottomDesc,
            color: pureWhite,
            align: TextAlign.center,
          ),
          const SizedBox(height: 15),
          BigWideButton(
            labelText: label,
            onPressedTo: onTap,
            textColor: secondBlack,
            btnColor: gold,
          ),
          const SizedBox(height: 10),
          PaddingDivider(color: pureWhite),
          SmallText(
            text: "Swipe right or left to continue",
            color: pureWhite,
          ),
        ],
      ),
    );
  }
}

class SecondCard extends StatelessWidget {
  const SecondCard({
    @required this.size,
    this.image,
    this.title,
    this.description,
    this.topLabel,
    this.bottomLabel,
    this.onTapTop,
    this.onTapBottom,
  });

  final Size size;
  final String image, title, description, topLabel, bottomLabel;
  final Function() onTapTop, onTapBottom;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.75,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: primary1,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset(
            "assets/images/$image.png",
            height: size.width * 0.6,
          ),
          HeaderTwoText(
            text: title,
            color: pureWhite,
            align: TextAlign.center,
          ),
          const SizedBox(height: 5),
          DescText(
            text: description,
            color: pureWhite,
            align: TextAlign.center,
          ),
          const SizedBox(height: 15),
          BigWideButton(
            labelText: topLabel,
            onPressedTo: onTapTop,
            textColor: pureWhite,
            btnColor: primary5,
          ),
          const SizedBox(height: 10),
          BigWideButton(
            labelText: bottomLabel,
            onPressedTo: onTapBottom,
            textColor: pureWhite,
            btnColor: primary5,
          ),
          const SizedBox(height: 10),
          PaddingDivider(color: pureWhite),
          SmallText(
            text: "Swipe right for top button\nSwipe left for bottom button",
            color: pureWhite,
          ),
        ],
      ),
    );
  }
}

class FirstCard extends StatelessWidget {
  const FirstCard({
    this.size,
    this.photoCU,
    this.photoSU,
    this.title,
    this.topDesc,
    this.bottomDesc,
    this.topLabel,
    this.bottomLabel,
    this.onTapTop,
    this.onTapBottom,
  });

  final Size size;
  final String photoCU,
      photoSU,
      title,
      topDesc,
      bottomDesc,
      topLabel,
      bottomLabel;
  final Function() onTapTop, onTapBottom;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.75,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: primary1,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: MediaQuery.of(context).size.width * 0.13,
                backgroundColor: pureWhite,
                child: ClipOval(
                  child: SizedBox(
                    height: size.height * 0.11,
                    width: size.height * 0.11,
                    child: CardPhotoWidget(photoLink: photoCU),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              CircleAvatar(
                radius: MediaQuery.of(context).size.width * 0.13,
                backgroundColor: pureWhite,
                child: ClipOval(
                  child: SizedBox(
                    height: size.height * 0.11,
                    width: size.height * 0.11,
                    child: CardPhotoWidget(
                      photoLink: photoSU,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          HeaderTwoText(
            text: title,
            color: pureWhite,
            align: TextAlign.center,
          ),
          const SizedBox(height: 10),
          DescText(
            text: topDesc,
            color: pureWhite,
            align: TextAlign.center,
          ),
          const SizedBox(height: 5),
          DescText(
            text: bottomDesc,
            color: pureWhite,
            align: TextAlign.center,
          ),
          const SizedBox(height: 15),
          BigWideButton(
            labelText: topLabel,
            onPressedTo: onTapTop,
            textColor: pureWhite,
            btnColor: primary5,
          ),
          const SizedBox(height: 15),
          BigWideButton(
            labelText: bottomLabel,
            onPressedTo: onTapBottom,
            textColor: pureWhite,
            btnColor: primary5,
          ),
          const SizedBox(height: 10),
          PaddingDivider(color: pureWhite),
          SmallText(
            text: "Swipe right for top button\nSwipe left for bottom button",
            color: pureWhite,
          ),
        ],
      ),
    );
  }
}
