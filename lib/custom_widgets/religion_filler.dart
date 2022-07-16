import 'package:finpro_max/custom_widgets/text_styles.dart';
import 'package:finpro_max/models/colors.dart';
import 'package:flutter/material.dart';

class ReligionQuoteFiller extends StatelessWidget {
  const ReligionQuoteFiller({
    Key key,
    @required this.size,
    @required this.similarity,
    @required this.quote,
    @required this.author,
    @required this.image,
  }) : super(key: key);

  final Size size;
  final double similarity;
  final String quote, author, image;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.54,
      margin: const EdgeInsets.fromLTRB(5, 0, 5, 10),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: similarity < 0.4
            ? thirdBlack
            : similarity < 0.7
                ? appBarColor
                : primary1,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DescText(
            text: quote,
            color: white,
            align: TextAlign.left,
          ),
          const SizedBox(height: 10),
          HeaderThreeText(
            text: "- $author",
            color: white,
          ),
          const SizedBox(height: 15),
          Container(
            decoration: BoxDecoration(
                color: white, borderRadius: BorderRadius.circular(20)),
            child: Image.asset(
              "assets/images/$image.png",
              width: size.width * 0.68,
              height: size.width * 0.68,
            ),
          )
        ],
      ),
    );
  }
}
