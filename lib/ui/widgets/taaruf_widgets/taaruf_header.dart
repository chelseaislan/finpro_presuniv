import 'package:finpro_max/custom_widgets/text_styles.dart';
import 'package:finpro_max/models/colors.dart';
import 'package:finpro_max/ui/widgets/card_swipe_widgets/card_photo.dart';
import 'package:flutter/material.dart';

class TaarufHeader extends StatelessWidget {
  final String header;
  final String description;
  final String photoLink;

  const TaarufHeader({
    Key key,
    @required this.size,
    this.header,
    this.description,
    this.photoLink,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
      // banner
      decoration: BoxDecoration(
        color: primary1,
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(size.width * 0.07),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: size.width * 0.05),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                  color: white,
                  width: size.width * 0.9,
                  height: size.width * 0.6,
                  child: CardPhotoWidget(photoLink: photoLink)),
            ),
          ),
          HeaderTwoText(text: header, color: white),
          DescText(text: description, color: white),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
