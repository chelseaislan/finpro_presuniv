import 'package:carousel_slider/carousel_slider.dart';
import 'package:finpro_max/custom_widgets/buttons/appbar_sidebutton.dart';
import 'package:finpro_max/custom_widgets/text_styles.dart';
import 'package:finpro_max/models/colors.dart';
import 'package:finpro_max/ui/widgets/card_swipe_widgets/card_photo.dart';
import 'package:flutter/material.dart';

class TaarufTutorialPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<String> imgList = [
      'https://i.ibb.co/3RYvRZp/1.png',
      'https://i.ibb.co/3RGch2M/2.png',
      'https://i.ibb.co/hgrYq0z/3.png',
      'https://i.ibb.co/PCHpbnL/4.png',
    ];

    return Scaffold(
      backgroundColor: primaryBlack,
      appBar: AppBarSideButton(
        appBarTitle: HeaderThreeText(
          text: "Taaruf Information",
          color: pureWhite,
        ),
        appBarColor: primaryBlack,
      ),
      body: Builder(
        builder: (context) {
          final double height = MediaQuery.of(context).size.height;
          return CarouselSlider(
            options: CarouselOptions(
              height: height,
              viewportFraction: 1.0,
              enlargeCenterPage: false,
            ),
            items: imgList
                .map(
                  (item) => Center(
                    child: CardPhotoWidget(photoLink: item),
                  ),
                )
                .toList(),
          );
        },
      ),
    );
  }
}
