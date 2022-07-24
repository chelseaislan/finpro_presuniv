import 'package:finpro_max/custom_widgets/buttons/big_wide_button.dart';
import 'package:finpro_max/models/colors.dart';
import 'package:flutter/material.dart';

class TaarufButtons extends StatelessWidget {
  final Function() onPressedTop, onPressedBottom;
  // final String selectedUser;
  const TaarufButtons({
    Key key,
    @required this.size,
    @required this.onPressedTop,
    @required this.onPressedBottom,
    // this.selectedUser,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        BigWideButton(
          labelText: "Go Home",
          onPressedTo: onPressedTop,
          textColor: pureWhite,
          btnColor: primary1,
        ),
        const SizedBox(height: 10),
        BigWideButton(
          labelText: "Cancel Taaruf",
          onPressedTo: onPressedBottom,
          textColor: pureWhite,
          btnColor: primary2,
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
