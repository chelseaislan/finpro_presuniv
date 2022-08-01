import 'package:carousel_slider/carousel_slider.dart';
import 'package:finpro_max/custom_widgets/buttons/appbar_sidebutton.dart';
import 'package:finpro_max/custom_widgets/text_styles.dart';
import 'package:finpro_max/models/colors.dart';
import 'package:finpro_max/ui/widgets/card_swipe_widgets/card_photo.dart';
import 'package:flutter/material.dart';

class AppTutorialPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final List<String> imgList = [
    //   'https://i.ibb.co/JjcqfMJ/01-Intro.png',
    //   'https://i.ibb.co/7tdhQyZ/02-Like.png',
    //   'https://i.ibb.co/frYFS2g/03-Dislike.png',
    //   'https://i.ibb.co/4W4K1zR/04-View-Info-A.png',
    //   'https://i.ibb.co/89hKnGV/05-View-Info-B.png',
    //   'https://i.ibb.co/26SgdNk/06-Filter.png',
    //   'https://i.ibb.co/xgfXJV4/07-Filter-2.png',
    //   'https://i.ibb.co/0tk6Rq2/08-Filter-3.png',
    //   'https://i.ibb.co/RzfRqxJ/09-Profile.png',
    //   'https://i.ibb.co/x5MMLDj/10-Profile-2.png',
    //   'https://i.ibb.co/4P35ThV/11-Profile-3.png',
    //   'https://i.ibb.co/CsGZ34w/12-Match.png',
    //   'https://i.ibb.co/JWLPdvr/13-Chatroom.png',
    //   'https://i.ibb.co/jMNcVhT/14-Chatroom-2.png',
    //   'https://i.ibb.co/HpLw0Xp/15-Taaruf.png',
    //   'https://i.ibb.co/wSKLFQs/16-Taaruf-2.png',
    //   'https://i.ibb.co/WnH0zDq/17-Ending.png',
    // ];

    final List<String> imgList = [
      'https://firebasestorage.googleapis.com/v0/b/finpro-max.appspot.com/o/appGuide%2F01-Intro.png?alt=media&token=0380ef6e-febe-45c1-8177-3984e4398f0c',
      'https://firebasestorage.googleapis.com/v0/b/finpro-max.appspot.com/o/appGuide%2F02-Like.png?alt=media&token=e5a0d7cc-44aa-44e7-95c0-c82beb57311d',
      'https://firebasestorage.googleapis.com/v0/b/finpro-max.appspot.com/o/appGuide%2F03-Dislike.png?alt=media&token=093c08a7-3a2a-4fe6-addf-d4823ae3f126',
      'https://firebasestorage.googleapis.com/v0/b/finpro-max.appspot.com/o/appGuide%2F04-View-Info-A.png?alt=media&token=f838e795-2061-44eb-bddd-e46689f50cce',
      'https://firebasestorage.googleapis.com/v0/b/finpro-max.appspot.com/o/appGuide%2F05-View-Info-B.png?alt=media&token=d234255b-b719-4743-8354-1902ae32d9d0',
      'https://firebasestorage.googleapis.com/v0/b/finpro-max.appspot.com/o/appGuide%2F06-Filter.png?alt=media&token=99cfc348-0f8b-4b0c-bb8f-f039b59ffdad',
      'https://firebasestorage.googleapis.com/v0/b/finpro-max.appspot.com/o/appGuide%2F07-Filter-2.png?alt=media&token=cba09deb-08dd-45a5-8463-598f6fb9586d',
      'https://firebasestorage.googleapis.com/v0/b/finpro-max.appspot.com/o/appGuide%2F08-Filter-3.png?alt=media&token=3571c45b-98bd-4e28-a644-02db46b543ba',
      'https://firebasestorage.googleapis.com/v0/b/finpro-max.appspot.com/o/appGuide%2F09-Profile.png?alt=media&token=20cd25d6-6d63-49f8-966b-89e95fc88021',
      'https://firebasestorage.googleapis.com/v0/b/finpro-max.appspot.com/o/appGuide%2F10-Profile-2.png?alt=media&token=202c6a87-9c8f-49c9-9e85-68b8c4d4d40e',
      'https://firebasestorage.googleapis.com/v0/b/finpro-max.appspot.com/o/appGuide%2F11-Profile-3.png?alt=media&token=dbdf5491-2d0d-4a38-91a8-f7c688dd13f8',
      'https://firebasestorage.googleapis.com/v0/b/finpro-max.appspot.com/o/appGuide%2F12-Match.png?alt=media&token=ed6ec43e-f1c9-44ab-997b-0d9e651eca59',
      'https://firebasestorage.googleapis.com/v0/b/finpro-max.appspot.com/o/appGuide%2F13-Chatroom.png?alt=media&token=4207e773-8019-414e-891b-1e309122b0a3',
      'https://firebasestorage.googleapis.com/v0/b/finpro-max.appspot.com/o/appGuide%2F14-Chatroom-2.png?alt=media&token=5a913c4d-bbb7-490f-be46-fb0a73923ef3',
      'https://firebasestorage.googleapis.com/v0/b/finpro-max.appspot.com/o/appGuide%2F15-Taaruf.png?alt=media&token=1e1750fc-5111-4ff3-8e8a-cc601d767b41',
      'https://firebasestorage.googleapis.com/v0/b/finpro-max.appspot.com/o/appGuide%2F16-Taaruf-2.png?alt=media&token=3b5240b9-726d-4b12-88a2-e648cdc27299',
      'https://firebasestorage.googleapis.com/v0/b/finpro-max.appspot.com/o/appGuide%2F17-Ending.png?alt=media&token=b394f3f8-afc7-4863-957e-c78c3a4ac50a',
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
