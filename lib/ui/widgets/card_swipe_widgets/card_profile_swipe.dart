// @dart=2.9
// 24/41

import 'package:blur/blur.dart';
import 'package:finpro_max/models/colors.dart';
import 'package:finpro_max/ui/widgets/card_swipe_widgets/card_photo.dart';
import 'package:flutter/material.dart';

class CardProfileSwipe extends StatelessWidget {
  final double padding;
  final double photoHeight;
  final double photoWidth;
  final double clipRadius;
  final String photo;
  final double containerHeight;
  final double containerWidth;
  final Widget containerChild;
  final double blur;
  final Widget overlay;

  // for discover swipe tab page
  const CardProfileSwipe({
    this.padding,
    this.photoHeight,
    this.photoWidth,
    this.clipRadius,
    this.photo,
    this.containerHeight,
    this.containerWidth,
    this.containerChild,
    @required this.blur,
    @required this.overlay,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: secondBlack,
              blurRadius: 6.0,
              spreadRadius: 0.01,
            ),
          ],
          borderRadius: BorderRadius.circular(clipRadius),
        ),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            // background profile pic
            Blur(
              blur: blur,
              overlay: overlay,
              colorOpacity: 0,
              child: SizedBox(
                width: photoWidth,
                height: photoHeight,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(clipRadius),
                  child: CardPhotoWidget(
                    photoLink: photo,
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Colors.transparent,
                  Colors.black38,
                  Colors.black54,
                  secondBlack,
                ], stops: const [
                  0.1,
                  0.2,
                  0.4,
                  0.9
                ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
                color: secondBlack,
                borderRadius: BorderRadius.circular(clipRadius),
              ),
              width: containerWidth,
              height: containerHeight,
              child: containerChild,
            ),
          ],
        ),
      ),
    );
  }
}

class CardProfileDetail extends StatelessWidget {
  final double padding;
  final double photoHeight;
  final double photoWidth;
  final double clipRadius;
  final String photo;
  final double containerHeight;
  final double containerWidth;
  final Widget containerChild;

  const CardProfileDetail({
    this.padding,
    this.photoHeight,
    this.photoWidth,
    this.clipRadius,
    this.photo,
    this.containerHeight,
    this.containerWidth,
    this.containerChild,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: Column(
        children: [
          // background profile pic
          SizedBox(
            width: photoWidth,
            height: photoHeight * 0.35,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(clipRadius),
                topRight: Radius.circular(clipRadius),
              ),
              child: CardPhotoWidget(
                photoLink: photo,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(clipRadius),
                bottomRight: Radius.circular(clipRadius),
              ),
            ),
            width: containerWidth,
            height: containerHeight,
            child: containerChild,
          ),
        ],
      ),
    );
  }
}
