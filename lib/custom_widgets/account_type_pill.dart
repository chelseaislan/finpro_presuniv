import 'package:finpro_max/models/colors.dart';
import 'package:finpro_max/custom_widgets/text_styles.dart';
import 'package:flutter/material.dart';

class AccountTypePill extends StatelessWidget {
  const AccountTypePill({@required this.pillStatus, @required this.pillColor});

  final String pillStatus;
  final Color pillColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 10),
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 12),
        decoration: BoxDecoration(
          color: pillColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: SmallText(
          text: pillStatus,
          color: secondBlack,
          align: TextAlign.center,
        ),
      ),
    );
  }
}
