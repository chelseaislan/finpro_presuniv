import 'package:finpro_max/models/colors.dart';
import 'package:finpro_max/custom_widgets/account_type_pill.dart';
import 'package:finpro_max/custom_widgets/text_styles.dart';
import 'package:finpro_max/ui/widgets/card_swipe_widgets/card_photo.dart';
import 'package:finpro_max/ui/widgets/chatroom_widgets/image_pdf_screen.dart';
import 'package:flutter/material.dart';

class ProfileOverviewWidget extends StatelessWidget {
  const ProfileOverviewWidget({
    @required this.photo,
    @required this.name,
    @required this.accountType,
    @required this.location,
    @required this.currentJob,
    @required this.taarufWith,
    this.pillColor,
  });

  final String photo;
  final String name;
  final String location;
  final String accountType;
  final String currentJob;
  final String taarufWith;
  final Color pillColor;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [appBarColor, primary1],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(
            size.width * 0.07,
          ),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation1, animation2) =>
                            DetailScreen(photoLink: photo),
                        transitionDuration: Duration.zero,
                        reverseTransitionDuration: Duration.zero,
                      ),
                    );
                  },
                  child: CircleAvatar(
                    radius: MediaQuery.of(context).size.width * 0.16,
                    backgroundColor: pureWhite,
                    child: ClipOval(
                      child: SizedBox(
                        height: size.height * 0.135,
                        width: size.height * 0.135,
                        child: CardPhotoWidget(photoLink: photo),
                      ),
                    ),
                  ),
                ),
                accountType == "verified" || accountType == "married"
                    ? Icon(
                        Icons.verified_rounded,
                        color: pureWhite,
                        size: 18,
                      )
                    : const Icon(
                        Icons.verified_rounded,
                        color: Colors.transparent,
                        size: 18,
                      ),
              ],
            ),
          ),
          HeaderTwoText(
            text: name,
            color: pureWhite,
            align: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
          DescText(
            text: currentJob,
            color: pureWhite,
            align: TextAlign.center,
          ),
          DescText(
            text: location,
            color: pureWhite,
            align: TextAlign.center,
          ),
          DescText(
            text: taarufWith,
            color: pureWhite,
            align: TextAlign.center,
          ),
          AccountTypePill(
            pillStatus: accountType == "verified"
                ? "Verified User"
                : accountType == "married"
                    ? "Married with MusliMatch App"
                    : "Unverified User",
            pillColor: accountType == "verified"
                ? gold
                : accountType == "married"
                    ? gold
                    : pureWhite,
          ),
        ],
      ),
    );
  }
}
