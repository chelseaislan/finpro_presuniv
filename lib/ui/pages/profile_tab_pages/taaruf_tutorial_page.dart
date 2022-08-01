import 'package:carousel_slider/carousel_slider.dart';
import 'package:finpro_max/custom_widgets/buttons/appbar_sidebutton.dart';
import 'package:finpro_max/custom_widgets/text_styles.dart';
import 'package:finpro_max/models/colors.dart';
import 'package:finpro_max/ui/widgets/card_swipe_widgets/card_photo.dart';
import 'package:flutter/material.dart';

class TaarufTutorialPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final List<String> imgList = [
    //   'https://i.ibb.co/3RYvRZp/1.png',
    //   'https://i.ibb.co/3RGch2M/2.png',
    //   'https://i.ibb.co/hgrYq0z/3.png',
    //   'https://i.ibb.co/PCHpbnL/4.png',
    // ];

    final List<String> imgList = [
      'https://firebasestorage.googleapis.com/v0/b/finpro-max.appspot.com/o/taarufGuide%2F1.png?alt=media&token=8ee810a0-9fca-4647-81c8-ae3c8bce9d5d',
      'https://firebasestorage.googleapis.com/v0/b/finpro-max.appspot.com/o/taarufGuide%2F2.png?alt=media&token=f84ac518-75d6-458f-83fa-b0ba8bfc605a',
      'https://firebasestorage.googleapis.com/v0/b/finpro-max.appspot.com/o/taarufGuide%2F3.png?alt=media&token=0cf92f5b-d61e-48cb-b199-060f39961cc2',
      'https://firebasestorage.googleapis.com/v0/b/finpro-max.appspot.com/o/taarufGuide%2F4.png?alt=media&token=b775ec44-50b9-4b9d-9dd9-dc9933a16272',
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
