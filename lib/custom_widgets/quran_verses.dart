import 'package:finpro_max/custom_widgets/text_styles.dart';
import 'package:finpro_max/models/colors.dart';
import 'package:flutter/material.dart';

class QuranOne extends StatelessWidget {
  const QuranOne({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SmallText(
      text:
          "Al Hujurat (49)-13: O humanity! Indeed, We created you from a male and a female, and made you into peoples and tribes so that you may ˹get to know one another˺. Surely the most noble of you in the sight of Allah is the most righteous among you. Allah is truly All-Knowing, All-Aware.",
      color: white,
      align: TextAlign.justify,
    );
  }
}

class QuranTwo extends StatelessWidget {
  const QuranTwo({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SmallText(
      text:
          "An Nur (24)-32: Marry off the ˹free˺ singles among you, as well as the righteous of your bondmen and bondwomen. If they are poor, Allah will enrich them out of His bounty. For Allah is All-Bountiful, All-Knowing.",
      color: white,
      align: TextAlign.justify,
    );
  }
}

class QuranFive extends StatelessWidget {
  const QuranFive({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SmallText(
      text:
          "Ar Rum (30)-21: And one of His signs is that He created for you spouses from among yourselves so that you may find comfort in them. And He has placed between you compassion and mercy. Surely in this are signs for people who reflect.",
      color: white,
      align: TextAlign.justify,
    );
  }
}
