import 'package:carousel_slider/carousel_slider.dart';
import 'package:finpro_max/custom_widgets/buttons/appbar_sidebutton.dart';
import 'package:finpro_max/custom_widgets/text_styles.dart';
import 'package:finpro_max/models/colors.dart';
import 'package:finpro_max/ui/widgets/card_swipe_widgets/card_photo.dart';
import 'package:flutter/material.dart';

class AppTutorialPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<String> imgList = [
      'https://i.ibb.co/JjcqfMJ/01-Intro.png',
      'https://i.ibb.co/7tdhQyZ/02-Like.png',
      'https://i.ibb.co/frYFS2g/03-Dislike.png',
      'https://i.ibb.co/4W4K1zR/04-View-Info-A.png',
      'https://i.ibb.co/89hKnGV/05-View-Info-B.png',
      'https://i.ibb.co/26SgdNk/06-Filter.png',
      'https://i.ibb.co/xgfXJV4/07-Filter-2.png',
      'https://i.ibb.co/0tk6Rq2/08-Filter-3.png',
      'https://i.ibb.co/RzfRqxJ/09-Profile.png',
      'https://i.ibb.co/x5MMLDj/10-Profile-2.png',
      'https://i.ibb.co/4P35ThV/11-Profile-3.png',
      'https://i.ibb.co/CsGZ34w/12-Match.png',
      'https://i.ibb.co/JWLPdvr/13-Chatroom.png',
      'https://i.ibb.co/jMNcVhT/14-Chatroom-2.png',
      'https://i.ibb.co/HpLw0Xp/15-Taaruf.png',
      'https://i.ibb.co/wSKLFQs/16-Taaruf-2.png',
      'https://i.ibb.co/WnH0zDq/17-Ending.png',
    ];

    return Scaffold(
      backgroundColor: primaryBlack,
      appBar: AppBarSideButton(
        appBarTitle: HeaderThreeText(
          text: "Application Tutorial",
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
