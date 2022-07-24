import 'package:finpro_max/custom_widgets/buttons/big_wide_button.dart';
import 'package:finpro_max/custom_widgets/text_styles.dart';
import 'package:finpro_max/models/colors.dart';
import 'package:finpro_max/ui/pages/profile_tab_pages/account_status_upgrade.dart';
import 'package:flutter/material.dart';

class Unverified extends StatelessWidget {
  final String userId;
  const Unverified({this.userId});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "assets/images/astronaut.png",
            width: size.width,
          ),
          SizedBox(height: size.height * 0.02),
          HeaderTwoText(
            text: "Uh-oh...",
            color: secondBlack,
            align: TextAlign.center,
          ),
          SizedBox(height: size.height * 0.01),
          DescText(
            text: "This feature is only available for verified users.",
            color: secondBlack,
            align: TextAlign.center,
          ),
          SizedBox(height: size.height * 0.02),
          BigWideButton(
            labelText: "My Legal Documents",
            onPressedTo: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) =>
                      AccountStatusUpgrade(userId: userId),
                  transitionDuration: Duration.zero,
                  reverseTransitionDuration: Duration.zero,
                ),
              );
            },
            textColor: pureWhite,
            btnColor: primary1,
          ),
        ],
      ),
    );
  }
}
