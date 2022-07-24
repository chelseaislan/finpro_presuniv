import 'package:blur/blur.dart';
import 'package:finpro_max/custom_widgets/text_styles.dart';
import 'package:finpro_max/models/colors.dart';
import 'package:finpro_max/models/user.dart';
import 'package:finpro_max/ui/widgets/card_swipe_widgets/card_photo.dart';
import 'package:flutter/material.dart';

class ComparisonWidget extends StatelessWidget {
  const ComparisonWidget({
    Key key,
    @required this.size,
    @required this.similarity,
    @required User currentUser,
    @required User user,
    @required this.rTotal,
    @required this.pTotal,
  })  : _currentUser = currentUser,
        _user = user,
        super(key: key);

  final Size size;
  final double similarity;
  final User _currentUser;
  final User _user;
  final int rTotal;
  final int pTotal;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.35,
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
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: MediaQuery.of(context).size.width * 0.1,
                backgroundColor: pureWhite,
                child: ClipOval(
                  child: SizedBox(
                    height: size.height * 0.085,
                    width: size.height * 0.085,
                    child: CardPhotoWidget(
                      photoLink: _currentUser.photo,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              CircleAvatar(
                radius: MediaQuery.of(context).size.width * 0.1,
                backgroundColor: pureWhite,
                child: ClipOval(
                  child: Blur(
                    colorOpacity: 0,
                    blur: _user.blurAvatar == true ? 3 : 0,
                    overlay: _user.blurAvatar == true
                        ? CircleAvatar(
                            maxRadius: 25,
                            backgroundColor: pureWhite,
                            child: Container(
                              padding: const EdgeInsets.all(10),
                              child: Image.asset("assets/images/love.png"),
                            ))
                        : Container(),
                    child: SizedBox(
                      height: size.height * 0.085,
                      width: size.height * 0.085,
                      child: CardPhotoWidget(
                        photoLink: _user.photo,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          ChatText(
            text: "According to the data, you and ${_user.nickname} share",
            color: pureWhite,
            align: TextAlign.center,
          ),
          HeaderOneText(
            // text: "${similarity * 100}% similarities",
            text:
                "${double.parse((similarity * 100).toStringAsFixed(2))}% similarities",
            color: pureWhite,
            align: TextAlign.center,
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              DescText(
                text: "Religion Details",
                color: pureWhite,
              ),
              DescText(
                text: "Personal Details",
                color: pureWhite,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              HeaderTwoText(
                text: "$rTotal out of 6",
                color: pureWhite,
              ),
              HeaderTwoText(
                text: "$pTotal out of 11",
                color: pureWhite,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Image.asset(
            "assets/images/header-logo-white.png",
            fit: BoxFit.cover,
            width: 100,
            height: 20,
          )
        ],
      ),
    );
  }
}
