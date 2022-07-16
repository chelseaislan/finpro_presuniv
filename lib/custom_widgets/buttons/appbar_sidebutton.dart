import 'package:flutter/material.dart';

class AppBarSideButton extends StatelessWidget implements PreferredSizeWidget {
  const AppBarSideButton({
    @required this.appBarTitle,
    @required this.appBarColor,
    this.onPressed,
    this.appBarIcon,
    this.tooltip,
  });

  final Widget appBarTitle;
  final Color appBarColor;
  final Function() onPressed;
  final IconData appBarIcon;
  final String tooltip;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: appBarTitle,
      backgroundColor: appBarColor,
      centerTitle: true,
      elevation: 0,
      actions: [
        IconButton(
          onPressed: onPressed,
          icon: Icon(appBarIcon),
          tooltip: tooltip,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
