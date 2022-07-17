import 'package:finpro_max/custom_widgets/buttons/appbar_sidebutton.dart';
import 'package:finpro_max/models/colors.dart';
import 'package:finpro_max/ui/widgets/card_swipe_widgets/card_photo.dart';
import 'package:flutter/material.dart';

class StoryUploadPage extends StatelessWidget {
  const StoryUploadPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: primary5,
      appBar: AppBarSideButton(
        appBarTitle: const Text("Upload Story"),
        appBarColor: primary5,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ClipRRect(
          child: Container(
            height: size.height * 0.85,
            decoration: BoxDecoration(
              color: primary1,
              border: Border.all(color: white),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Image.asset("assets/images/chat-bg.jpg"),
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 12.5, bottom: 25),
        child: FloatingActionButton(
          tooltip: "Upload Story",
          backgroundColor: white,
          child: Icon(Icons.send_rounded, color: primary1),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
    );
  }
}
