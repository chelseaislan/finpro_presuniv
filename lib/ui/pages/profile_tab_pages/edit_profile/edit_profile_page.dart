// @dart=2.9
import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:finpro_max/bloc/profile/profile_bloc.dart';
import 'package:finpro_max/bloc/profile/profile_event.dart';
import 'package:finpro_max/bloc/profile/profile_state.dart';
import 'package:finpro_max/custom_widgets/buttons/appbar_sidebutton.dart';
import 'package:finpro_max/custom_widgets/buttons/big_wide_button.dart';
import 'package:finpro_max/custom_widgets/divider.dart';
import 'package:finpro_max/custom_widgets/modal_popup.dart';
import 'package:finpro_max/custom_widgets/my_snackbar.dart';
import 'package:finpro_max/custom_widgets/text_styles.dart';
import 'package:finpro_max/models/colors.dart';
import 'package:finpro_max/models/user.dart';
import 'package:finpro_max/repositories/user_repository.dart';
import 'package:finpro_max/ui/pages/profile_tab_pages/edit_profile/edit_profile_tabs.dart';
import 'package:finpro_max/ui/widgets/card_swipe_widgets/card_photo.dart';
import 'package:finpro_max/ui/widgets/onboarding_widgets/complete_profile_form.dart';
import 'package:finpro_max/ui/widgets/tabs.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EditProfile extends StatefulWidget {
  final String userId;
  const EditProfile({this.userId});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  Firestore _firestore;
  final UserRepository _userRepository = UserRepository();
  ProfileBloc _profileBloc;
  User _currentUser;
  File photo;
  // String userId;

  // the textfield controllers
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _currentJobController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _jobPositionController = TextEditingController();
  final TextEditingController _hobbyController = TextEditingController();
  final TextEditingController _aboutController = TextEditingController();

  @override
  void initState() {
    _profileBloc = ProfileBloc(userRepository: _userRepository);
    _firestore = Firestore();
    super.initState();
    _animationController = BottomSheet.createAnimationController(this);
    _animationController.duration = const Duration(seconds: 0);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primary1, appBarColor],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBarSideButton(
          appBarTitle: HeaderThreeText(
            text: "Basic Details",
            color: pureWhite,
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
              return Center(child: CircularProgressIndicator(color: pureWhite));
            }
            if (state is ProfileLoadedState) {
              _currentUser = state.currentUser;
              final List header = [
                "Nickname",
                "Company / Organization",
                "Job Position",
                "City (Province in Additional Details)",
                "Hobby",
                "About Me",
              ];

              final List hintText = [
                "nickname",
                "company",
                "position",
                "city",
                "hobby",
                "description about yourself",
              ];

              final List descText = [
                _currentUser.nickname,
                _currentUser.currentJob,
                _currentUser.jobPosition,
                _currentUser.location,
                _currentUser.hobby,
                "Describe a bit about yourself!",
              ];

              final List controller = [
                _nicknameController,
                _currentJobController,
                _jobPositionController,
                _locationController,
                _hobbyController,
                _aboutController,
              ];

              final List onSaved = [
                () {
                  _nicknameController.text == null ||
                          _nicknameController.text == ""
                      ? Fluttertoast.showToast(
                          msg: "Please input your nickname.")
                      : setState(() {
                          _firestore
                              .collection('users')
                              .document(_currentUser.uid)
                              .updateData(
                                  {'nickname': _nicknameController.text});
                          ScaffoldMessenger.of(context).showSnackBar(
                            mySnackbar(
                              text: "Nickname has been updated!",
                              duration: 3,
                              background: primaryBlack,
                            ),
                          );
                          Navigator.pop(context);
                          Navigator.pushReplacement(context, reloadAfterSave());
                        });
                },
                () {
                  _currentJobController.text == null ||
                          _currentJobController.text == ""
                      ? Fluttertoast.showToast(
                          msg: "Please input your current company.")
                      : setState(() {
                          _firestore
                              .collection('users')
                              .document(_currentUser.uid)
                              .updateData(
                                  {'currentJob': _currentJobController.text});
                          ScaffoldMessenger.of(context).showSnackBar(
                            mySnackbar(
                              text: "Company has been updated!",
                              duration: 3,
                              background: primaryBlack,
                            ),
                          );
                          Navigator.pop(context);
                          Navigator.pushReplacement(context, reloadAfterSave());
                        });
                },
                () {
                  _jobPositionController.text == null ||
                          _jobPositionController.text == ""
                      ? Fluttertoast.showToast(
                          msg: "Please input your job position.")
                      : setState(() {
                          _firestore
                              .collection('users')
                              .document(_currentUser.uid)
                              .updateData(
                                  {'jobPosition': _jobPositionController.text});
                          ScaffoldMessenger.of(context).showSnackBar(
                            mySnackbar(
                              text: "Job position has been updated!",
                              duration: 3,
                              background: primaryBlack,
                            ),
                          );
                          Navigator.pop(context);
                          Navigator.pushReplacement(context, reloadAfterSave());
                        });
                },
                () {
                  _locationController.text == null ||
                          _locationController.text == ""
                      ? Fluttertoast.showToast(
                          msg: "Please input your current city.")
                      : setState(() {
                          _firestore
                              .collection('users')
                              .document(_currentUser.uid)
                              .updateData(
                                  {'location': _locationController.text});
                          ScaffoldMessenger.of(context).showSnackBar(
                            mySnackbar(
                              text: "Current city has been updated!",
                              duration: 3,
                              background: primaryBlack,
                            ),
                          );
                          Navigator.pop(context);
                          Navigator.pushReplacement(context, reloadAfterSave());
                        });
                },
                () {
                  _hobbyController.text == null || _hobbyController.text == ""
                      ? Fluttertoast.showToast(msg: "Please input your hobby.")
                      : setState(() {
                          _firestore
                              .collection('users')
                              .document(_currentUser.uid)
                              .updateData({'hobby': _hobbyController.text});
                          ScaffoldMessenger.of(context).showSnackBar(
                            mySnackbar(
                              text: "Hobby has been updated!",
                              duration: 3,
                              background: primaryBlack,
                            ),
                          );
                          Navigator.pop(context);
                          Navigator.pushReplacement(context, reloadAfterSave());
                        });
                },
                () {
                  _aboutController.text == null || _aboutController.text == ""
                      ? Fluttertoast.showToast(
                          msg: "Please describe a bit about yourself.")
                      : setState(() {
                          _firestore
                              .collection('users')
                              .document(_currentUser.uid)
                              .updateData({'aboutMe': _aboutController.text});
                          ScaffoldMessenger.of(context).showSnackBar(
                            mySnackbar(
                              text: "Description has been updated!",
                              duration: 3,
                              background: primaryBlack,
                            ),
                          );
                          Navigator.pop(context);
                          Navigator.pushReplacement(context, reloadAfterSave());
                        });
                },
              ];
              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              GestureDetector(
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.circular(size.width * 0.03),
                                  child: Container(
                                    color: pureWhite,
                                    width: size.width * 0.43,
                                    height: size.width * 0.43,
                                    child: CardPhotoWidget(
                                        photoLink: _currentUser.photo),
                                  ),
                                ),
                                onTap: () async {
                                  try {
                                    FilePickerResult getAvatar =
                                        await FilePicker.platform
                                            .pickFiles(type: FileType.image);
                                    if (getAvatar != null) {
                                      File file =
                                          File(getAvatar.files.single.path);
                                      setState(
                                        () {
                                          photo = file;
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            myLoadingSnackbar(
                                              text: "Uploading avatar...",
                                              duration: 9,
                                              background: primaryBlack,
                                            ),
                                          );
                                          StorageUploadTask storageUploadTask;
                                          storageUploadTask = FirebaseStorage
                                              .instance
                                              .ref()
                                              .child(
                                                  'userPhotos') // create folder userPhotos
                                              .child(_currentUser
                                                  .uid) // uid as the folder name
                                              .child(
                                                  'avatar_${_currentUser.name}') // uid as the file name
                                              .putFile(photo);
                                          storageUploadTask.onComplete.then(
                                            (ref) async {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                myLoadingSnackbar(
                                                  text: "Almost done...",
                                                  duration: 2,
                                                  background: primaryBlack,
                                                ),
                                              );
                                              ref.ref
                                                  .getDownloadURL()
                                                  .then((url) async {
                                                await _firestore
                                                    .collection('users')
                                                    .document(_currentUser.uid)
                                                    .updateData(
                                                        {'photoUrl': url});
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  mySnackbar(
                                                    text:
                                                        "Avatar has been updated!",
                                                    duration: 6,
                                                    background: primaryBlack,
                                                  ),
                                                );
                                                Navigator.pushReplacement(
                                                    context, reloadAfterSave());
                                              });
                                            },
                                          );
                                        },
                                      );
                                    }
                                  } catch (e) {
                                    showModalBottomSheet(
                                      transitionAnimationController:
                                          _animationController,
                                      context: context,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(10),
                                        ),
                                      ),
                                      builder: (context) {
                                        return ModalPopupOneButton(
                                          size: size,
                                          title: "Storage Permission Denied",
                                          image: "assets/images/404.png",
                                          description:
                                              "To upload pictures and documents, please enable permission to read external storage.",
                                          onPressed: () =>
                                              AppSettings.openAppSettings(),
                                        );
                                      },
                                    );
                                  }
                                },
                              ),
                              MiniPill(size: size, text: "Avatar"),
                            ],
                          ),
                          Container(
                            width: size.width * 0.43,
                            height: size.width * 0.43,
                            decoration: BoxDecoration(
                              color: pureWhite,
                              borderRadius:
                                  BorderRadius.circular(size.width * 0.03),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const UploadPlaceholder(
                                  iconData: Icons.blur_circular_outlined,
                                  text: "Blur avatar?",
                                ),
                                Switch(
                                  value: _currentUser.blurAvatar,
                                  onChanged: (value) {
                                    setState(() {
                                      _firestore
                                          .collection('users')
                                          .document(_currentUser.uid)
                                          .updateData({
                                        'blurAvatar': value,
                                      });
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        mySnackbar(
                                          text: "Blur has been updated!",
                                          duration: 3,
                                          background: primaryBlack,
                                        ),
                                      );
                                      Navigator.pushReplacement(
                                          context, reloadAfterSave());
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      PaddingDivider(color: pureWhite),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          HeaderFourText(
                              text: "Full Legal Name", color: pureWhite),
                          DescText(text: _currentUser.name, color: pureWhite),
                          SizedBox(height: size.width * 0.04),
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: header.length,
                            itemBuilder: (context, index) {
                              return ProfileEditableColumns(
                                header: header[index],
                                descText: descText[index],
                                hintText: hintText[index],
                                controller: controller[index],
                                animationController: _animationController,
                                onSaved: onSaved[index],
                              );
                            },
                          ),
                          PaddingDivider(color: pureWhite),
                          BigWideButton(
                            labelText: "Back to Profile",
                            onPressedTo: () {
                              Navigator.pushAndRemoveUntil(
                                context,
                                PageRouteBuilder(
                                  pageBuilder:
                                      (context, animation1, animation2) =>
                                          HomeTabs(
                                              userId: widget.userId,
                                              selectedPage: 4),
                                  transitionDuration: Duration.zero,
                                  reverseTransitionDuration: Duration.zero,
                                ),
                                (route) => false,
                              );
                            },
                            textColor: secondBlack,
                            btnColor: gold,
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  PageRouteBuilder<dynamic> reloadAfterSave() {
    return PageRouteBuilder(
      pageBuilder: (context, animation1, animation2) {
        return EditProfileTabs(
          userId: widget.userId,
          selectedPage: 0,
        );
      },
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
    );
  }
}

class ProfileEditableColumns extends StatelessWidget {
  const ProfileEditableColumns({
    Key key,
    @required this.header,
    @required this.descText,
    @required this.hintText,
    @required this.controller,
    @required this.animationController,
    @required this.onSaved,
  }) : super(key: key);

  final String header;
  final String descText;
  final String hintText;
  final TextEditingController controller;
  final AnimationController animationController;
  final Function() onSaved;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeaderFourText(text: header, color: pureWhite),
                DescText(
                  text: descText,
                  color: pureWhite,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            BigWideButtonIcon(
              labelText: "",
              textColor: secondBlack,
              btnColor: gold,
              iconData: Icons.edit_note_outlined,
              onPressedTo: () {
                showModalBottomSheet(
                  transitionAnimationController: animationController,
                  context: context,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                  ),
                  isScrollControlled: true,
                  builder: (context) {
                    return Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          HeaderThreeText(
                            text: "Input new $hintText:",
                            color: secondBlack,
                          ),
                          const SizedBox(height: 10),
                          Padding(
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  flex: 9,
                                  child: TextFormField(
                                    // autofocus: true,
                                    textCapitalization:
                                        TextCapitalization.sentences,
                                    controller: controller, // 2
                                    decoration: InputDecoration(
                                      hintText: "New $hintText",
                                      isDense: true,
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(
                                            width: 3, color: lightGrey2),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(
                                            width: 3, color: lightGrey3),
                                      ),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  flex: 3,
                                  child: BigWideButton(
                                    labelText: "Save",
                                    onPressedTo: onSaved,
                                    textColor: pureWhite,
                                    btnColor: primary1,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
        SizedBox(height: size.width * 0.05),
      ],
    );
  }
}
