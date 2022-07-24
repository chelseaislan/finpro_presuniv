// @dart=2.9
// for selected detail, matched detail, discover detail
// listview (3 + current profile)

import 'package:blur/blur.dart';
import 'package:finpro_max/custom_widgets/account_type_pill.dart';
import 'package:finpro_max/custom_widgets/text_styles.dart';
import 'package:finpro_max/models/colors.dart';
import 'package:finpro_max/models/user.dart';
import 'package:finpro_max/ui/widgets/card_swipe_widgets/card_photo.dart';
import 'package:flutter/material.dart';

class ProfileHeaderContainer extends StatelessWidget {
  const ProfileHeaderContainer({
    Key key,
    @required this.size,
    @required this.currentUser,
    @required this.blur,
    @required this.overlay,
  }) : super(key: key);

  final Size size;
  final User currentUser;
  final double blur;
  final Widget overlay;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primary1, primary5],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(size.width * 0.07),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Blur(
                  blur: blur,
                  overlay: overlay,
                  colorOpacity: 0,
                  child: Container(
                    color: pureWhite,
                    width: size.width * 0.9,
                    height: size.width * 0.9,
                    child: CardPhotoWidget(photoLink: currentUser.photo),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  right: size.width * 0.03,
                  bottom: size.width * 0.01,
                ),
                child: AccountTypePill(
                  pillStatus: currentUser.accountType == "verified"
                      ? "Verified User"
                      : currentUser.accountType == "married"
                          ? "Married with MusliMatch App"
                          : "Unverified User",
                  pillColor: currentUser.accountType == "verified"
                      ? gold
                      : currentUser.accountType == "married"
                          ? gold
                          : pureWhite,
                ),
              ),
            ],
          ),
          SizedBox(height: size.width * 0.06),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.02,
            ),
            child: Column(
              // 3 texts
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    HeaderOneText(
                      text:
                          "${currentUser.nickname}, ${(DateTime.now().year - currentUser.dob.toDate().year).toString()}",
                      color: pureWhite,
                      align: TextAlign.left,
                    ),
                    Icon(
                      Icons.verified_rounded,
                      color: currentUser.accountType == "verified" ||
                              currentUser.accountType == "married"
                          ? pureWhite
                          : Colors.transparent,
                      size: 30,
                    ),
                  ],
                ),
                DescText(
                  text:
                      "${currentUser.jobPosition} at ${currentUser.currentJob}",
                  color: pureWhite,
                  align: TextAlign.left,
                ),
                DescText(
                  text: "${currentUser.location}, ${currentUser.province}",
                  color: pureWhite,
                  align: TextAlign.left,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
