// @dart=2.9
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finpro_max/bloc/profile/profile_bloc.dart';
import 'package:finpro_max/bloc/profile/profile_event.dart';
import 'package:finpro_max/bloc/profile/profile_state.dart';
import 'package:finpro_max/custom_widgets/buttons/appbar_sidebutton.dart';
import 'package:finpro_max/custom_widgets/buttons/big_wide_button.dart';
import 'package:finpro_max/custom_widgets/divider.dart';
import 'package:finpro_max/custom_widgets/my_snackbar.dart';
import 'package:finpro_max/custom_widgets/text_styles.dart';
import 'package:finpro_max/models/colors.dart';
import 'package:finpro_max/models/user.dart';
import 'package:finpro_max/repositories/user_repository.dart';
import 'package:finpro_max/ui/widgets/card_swipe_widgets/card_photo.dart';
import 'package:finpro_max/ui/widgets/chatroom_widgets/image_pdf_screen.dart';
import 'package:finpro_max/ui/widgets/tabs.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class AccountStatusUpgrade extends StatefulWidget {
  final String userId;
  AccountStatusUpgrade({this.userId});

  @override
  State<AccountStatusUpgrade> createState() => _AccountStatusUpgradeState();
}

class _AccountStatusUpgradeState extends State<AccountStatusUpgrade> {
  Firestore _firestore;
  final UserRepository _userRepository = UserRepository();
  ProfileBloc _profileBloc;
  User _currentUser;
  File photoKtp, photoOtherID;

  @override
  void initState() {
    _profileBloc = ProfileBloc(userRepository: _userRepository);
    _firestore = Firestore();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: primary5,
      appBar: AppBarSideButton(
        appBarTitle: HeaderThreeText(
          text: "My Legal Documents",
          color: white,
        ),
        appBarColor: primary1,
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        bloc: _profileBloc,
        builder: (context, state) {
          if (state is ProfileInitialState) {
            _profileBloc.add(ProfileLoadedEvent(userId: widget.userId));
          }
          if (state is ProfileLoadingState) {
            return Center(child: CircularProgressIndicator(color: white));
          }
          if (state is ProfileLoadedState) {
            _currentUser = state.currentUser;
            return RefreshIndicator(
              onRefresh: () {
                return Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) =>
                        super.widget,
                    transitionDuration: Duration.zero,
                    reverseTransitionDuration: Duration.zero,
                  ),
                );
              },
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.05),
                      // banner
                      decoration: BoxDecoration(
                        color: primary1,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(size.width * 0.07),
                        ),
                      ),
                      child: DocumentColumn(
                        size: size,
                        currentUser: _currentUser,
                        text: "${_currentUser.nickname}'s KTP",
                        status: _currentUser.accountType.toUpperCase(),
                        photoLink: _currentUser.photoKtp,
                        onPressedTo: () async {
                          PickedFile getKtp = await ImagePicker().getImage(
                            source: ImageSource.camera,
                            maxWidth: 1800,
                            maxHeight: 1800,
                          );
                          if (getKtp != null) {
                            setState(
                              () {
                                photoKtp = File(getKtp.path);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  myLoadingSnackbar(
                                    text: "Uploading KTP...",
                                    duration: 15,
                                    background: primaryBlack,
                                  ),
                                );
                                StorageUploadTask storageUploadTask;
                                storageUploadTask = FirebaseStorage.instance
                                    .ref()
                                    .child(
                                        'userPhotos') // create folder userPhotos
                                    .child(_currentUser
                                        .uid) // uid as the folder name
                                    .child(
                                        'ktp_${_currentUser.name}') // uid as the file name
                                    .putFile(photoKtp);
                                storageUploadTask.onComplete.then((ref) async {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    myLoadingSnackbar(
                                      text: "Almost done...",
                                      duration: 2,
                                      background: primaryBlack,
                                    ),
                                  );
                                  ref.ref.getDownloadURL().then((url) async {
                                    await _firestore
                                        .collection('users')
                                        .document(_currentUser.uid)
                                        .updateData({
                                      'photoKtp': url,
                                      'accountType': "verifying..."
                                    });
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      mySnackbar(
                                        text:
                                            "Now your KTP is submitted for verification.",
                                        duration: 6,
                                        background: primaryBlack,
                                      ),
                                    );
                                    Navigator.pushReplacement(
                                        context, reloadAfterSave());
                                  });
                                });
                              },
                            );
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 30),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: size.width * 0.05),
                      child: DocumentColumn(
                        size: size,
                        currentUser: _currentUser,
                        text: "Additional Document",
                        status: _currentUser.accountType.toUpperCase(),
                        photoLink: _currentUser.photoOtherID,
                        onPressedTo: () async {
                          PickedFile getOtherID = await ImagePicker().getImage(
                            source: ImageSource.camera,
                            maxWidth: 1800,
                            maxHeight: 1800,
                          );
                          if (getOtherID != null) {
                            setState(
                              () {
                                photoOtherID = File(getOtherID.path);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  myLoadingSnackbar(
                                    text: "Uploading document...",
                                    duration: 15,
                                    background: primaryBlack,
                                  ),
                                );
                                StorageUploadTask storageUploadTask;
                                storageUploadTask = FirebaseStorage.instance
                                    .ref()
                                    .child(
                                        'userPhotos') // create folder userPhotos
                                    .child(_currentUser
                                        .uid) // uid as the folder name
                                    .child(
                                        'otherID_${_currentUser.name}') // uid as the file name
                                    .putFile(photoOtherID);
                                storageUploadTask.onComplete.then((ref) async {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    myLoadingSnackbar(
                                      text: "Almost done...",
                                      duration: 2,
                                      background: primaryBlack,
                                    ),
                                  );
                                  ref.ref.getDownloadURL().then((url) async {
                                    await _firestore
                                        .collection('users')
                                        .document(_currentUser.uid)
                                        .updateData({
                                      'photoOtherID': url,
                                      'accountType': "verifying..."
                                    });
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      mySnackbar(
                                        text:
                                            "Now your document is submitted for verification.",
                                        duration: 6,
                                        background: primaryBlack,
                                      ),
                                    );
                                    Navigator.pushReplacement(
                                        context, reloadAfterSave());
                                  });
                                });
                              },
                            );
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                        size.width * 0.05,
                        0,
                        size.width * 0.05,
                        20,
                      ),
                      child: BigWideButton(
                        labelText: "Back to Profile",
                        onPressedTo: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation1, animation2) =>
                                  HomeTabs(
                                      userId: widget.userId, selectedPage: 4),
                              transitionDuration: Duration.zero,
                              reverseTransitionDuration: Duration.zero,
                            ),
                            (route) => false,
                          );
                        },
                        textColor: secondBlack,
                        btnColor: gold,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }

  PageRouteBuilder<dynamic> reloadAfterSave() {
    return PageRouteBuilder(
      pageBuilder: (context, animation1, animation2) => super.widget,
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
    );
  }
}

class DocumentColumn extends StatelessWidget {
  const DocumentColumn({
    Key key,
    @required this.size,
    @required User currentUser,
    @required this.text,
    @required this.status,
    @required this.photoLink,
    @required this.onPressedTo,
  })  : _currentUser = currentUser,
        super(key: key);

  final Size size;
  final User _currentUser;
  final String text, status, photoLink;
  final Function() onPressedTo;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: size.width * 0.05),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation1, animation2) =>
                      DetailScreen(photoLink: photoLink),
                  transitionDuration: Duration.zero,
                  reverseTransitionDuration: Duration.zero,
                ),
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                color: white,
                width: size.width * 0.9,
                height: size.width * 0.6,
                child: CardPhotoWidget(
                  photoLink: photoLink,
                ),
              ),
            ),
          ),
        ),
        HeaderTwoText(
          text: text,
          color: white,
        ),
        ProfDetailText(
          text: _currentUser.name,
          color: white,
        ),
        ProfDetailText(
          text: "${_currentUser.location}, ${_currentUser.province}",
          color: white,
        ),
        const SizedBox(height: 5),
        PaddingDivider(color: white),
        ProfDetailText(
          text: status,
          color: white,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 15, bottom: 20),
          child: BigWideButton(
            labelText: "Change Document",
            onPressedTo: _currentUser.accountType == "invalid-ktp" ||
                    _currentUser.accountType == "invalid-otherid"
                ? onPressedTo
                : null,
            textColor: _currentUser.accountType == "invalid-ktp" ||
                    _currentUser.accountType == "invalid-otherid"
                ? secondBlack
                : white,
            btnColor: _currentUser.accountType == "invalid-ktp" ||
                    _currentUser.accountType == "invalid-otherid"
                ? gold
                : Colors.black26,
          ),
        ),
      ],
    );
  }
}
