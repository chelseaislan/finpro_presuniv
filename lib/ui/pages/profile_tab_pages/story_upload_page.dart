import 'dart:io';

import 'package:finpro_max/bloc/profile/profile_bloc.dart';
import 'package:finpro_max/custom_widgets/buttons/appbar_sidebutton.dart';
import 'package:finpro_max/custom_widgets/my_snackbar.dart';
import 'package:finpro_max/custom_widgets/text_styles.dart';
import 'package:finpro_max/models/colors.dart';
import 'package:finpro_max/models/user.dart';
import 'package:flutter/material.dart';

class StoryUploadPage extends StatelessWidget {
  final User _currentUser;
  final ProfileBloc _profileBloc;
  final File capturedStory;
  const StoryUploadPage({
    Key key,
    @required User currentUser,
    @required ProfileBloc profileBloc,
    @required this.capturedStory,
  })  : _profileBloc = profileBloc,
        _currentUser = currentUser,
        super(key: key);

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
              color: primaryBlack,
              border: Border.all(color: white),
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: FileImage(capturedStory),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(right: 12.5, bottom: 25),
        child: FloatingActionButton(
          tooltip: "Upload Story",
          backgroundColor: white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.send_rounded, color: primary1),
              MiniText(text: "Send", color: primary1),
            ],
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          onPressed: () {
            debugPrint("Uploading Story");
            ScaffoldMessenger.of(context).showSnackBar(
              myLoadingSnackbar(
                text: "Uploading story...",
                duration: 20,
                background: primaryBlack,
              ),
            );
          },
        ),
      ),
    );
  }
}
