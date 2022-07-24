// @dart=2.9

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finpro_max/bloc/profile/profile_bloc.dart';
import 'package:finpro_max/bloc/profile/profile_event.dart';
import 'package:finpro_max/bloc/profile/profile_state.dart';
import 'package:finpro_max/custom_widgets/buttons/appbar_sidebutton.dart';
import 'package:finpro_max/custom_widgets/buttons/big_wide_button.dart';
import 'package:finpro_max/custom_widgets/my_snackbar.dart';
import 'package:finpro_max/custom_widgets/text_radio_field.dart';
import 'package:finpro_max/custom_widgets/text_styles.dart';
import 'package:finpro_max/models/colors.dart';
import 'package:finpro_max/models/user.dart';
import 'package:finpro_max/repositories/user_repository.dart';
import 'package:finpro_max/ui/pages/profile_tab_pages/edit_profile/edit_profile_tabs.dart';
import 'package:finpro_max/ui/widgets/tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditReligionDetails extends StatefulWidget {
  final String userId;
  final User currentUser;

  const EditReligionDetails({this.userId, this.currentUser});

  @override
  State<EditReligionDetails> createState() => _EditReligionDetailsState();
}

class _EditReligionDetailsState extends State<EditReligionDetails> {
  Firestore _firestore;
  final UserRepository _userRepository = UserRepository();
  ProfileBloc _profileBloc;
  User _currentUser;
  DropdownList _dropdownList;
  String sholat, sSunnah, fasting, fSunnah, pilgrimage, quranLevel;

  @override
  void initState() {
    _profileBloc = ProfileBloc(userRepository: _userRepository);
    _dropdownList = DropdownList();
    _firestore = Firestore();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final List relValues = [
      sholat,
      sSunnah,
      fasting,
      fSunnah,
      pilgrimage,
      quranLevel,
    ];

    final List relItems = [
      _dropdownList.sholatList.map((value) {
        return DropdownMenuItem(
          child: DescText(text: value, color: secondBlack),
          value: value,
        );
      }).toList(),
      _dropdownList.sSunnahList.map((value) {
        return DropdownMenuItem(
          child: DescText(text: value, color: secondBlack),
          value: value,
        );
      }).toList(),
      _dropdownList.fastingList.map((value) {
        return DropdownMenuItem(
          child: DescText(text: value, color: secondBlack),
          value: value,
        );
      }).toList(),
      _dropdownList.fSunnahList.map((value) {
        return DropdownMenuItem(
          child: DescText(text: value, color: secondBlack),
          value: value,
        );
      }).toList(),
      _dropdownList.pilgrimageList.map((value) {
        return DropdownMenuItem(
          child: DescText(text: value, color: secondBlack),
          value: value,
        );
      }).toList(),
      _dropdownList.quranLevelList.map((value) {
        return DropdownMenuItem(
          child: DescText(text: value, color: secondBlack),
          value: value,
        );
      }).toList(),
    ];

    final List relOnChanged = [
      (value) async {
        setState(() => sholat = value);
        debugPrint(value);
        _firestore
            .collection('users')
            .document(_currentUser.uid)
            .updateData({'sholat': value});
        ScaffoldMessenger.of(context).showSnackBar(
          mySnackbar(
            text: "Prayer details has been updated!",
            duration: 3,
            background: primaryBlack,
          ),
        );
        Navigator.pushReplacement(
          context,
          reloadAfterSave(),
        );
      },
      (value) async {
        setState(() => sSunnah = value);
        debugPrint(value);
        _firestore
            .collection('users')
            .document(_currentUser.uid)
            .updateData({'sSunnah': value});
        ScaffoldMessenger.of(context).showSnackBar(
          mySnackbar(
            text: "Sunnah Prayer details has been updated!",
            duration: 3,
            background: primaryBlack,
          ),
        );
        Navigator.pushReplacement(
          context,
          reloadAfterSave(),
        );
      },
      (value) async {
        setState(() => fasting = value);
        debugPrint(value);
        _firestore
            .collection('users')
            .document(_currentUser.uid)
            .updateData({'fasting': value});
        ScaffoldMessenger.of(context).showSnackBar(
          mySnackbar(
            text: "Fasting details has been updated!",
            duration: 3,
            background: primaryBlack,
          ),
        );
        Navigator.pushReplacement(
          context,
          reloadAfterSave(),
        );
      },
      (value) async {
        setState(() => fSunnah = value);
        debugPrint(value);
        _firestore
            .collection('users')
            .document(_currentUser.uid)
            .updateData({'fSunnah': value});
        ScaffoldMessenger.of(context).showSnackBar(
          mySnackbar(
            text: "Sunnah Fasting details has been updated!",
            duration: 3,
            background: primaryBlack,
          ),
        );
        Navigator.pushReplacement(
          context,
          reloadAfterSave(),
        );
      },
      (value) async {
        setState(() => pilgrimage = value);
        debugPrint(value);
        _firestore
            .collection('users')
            .document(_currentUser.uid)
            .updateData({'pilgrimage': value});
        ScaffoldMessenger.of(context).showSnackBar(
          mySnackbar(
            text: "Pilgrimage details has been updated!",
            duration: 3,
            background: primaryBlack,
          ),
        );
        Navigator.pushReplacement(
          context,
          reloadAfterSave(),
        );
      },
      (value) async {
        setState(() => quranLevel = value);
        debugPrint(value);
        _firestore
            .collection('users')
            .document(_currentUser.uid)
            .updateData({'quranLevel': value});
        ScaffoldMessenger.of(context).showSnackBar(
          mySnackbar(
            text: "Quran Level details has been updated!",
            duration: 3,
            background: primaryBlack,
          ),
        );
        Navigator.pushReplacement(
          context,
          reloadAfterSave(),
        );
      },
    ];

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
            text: "Religion Details",
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
              final List relHints = [
                _currentUser.sholat,
                _currentUser.sSunnah,
                _currentUser.fasting,
                _currentUser.fSunnah,
                _currentUser.pilgrimage,
                _currentUser.quranLevel,
              ];
              return ListView(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                children: [
                  SizedBox(height: size.width * 0.03),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: _dropdownList.ddHeadersA.length,
                    itemBuilder: (context, index) {
                      return dropdownField(
                        _dropdownList.ddHeadersA[index],
                        _dropdownList.ddIconsA[index],
                        relHints[index],
                        relValues[index],
                        relItems[index],
                        relOnChanged[index],
                        pureWhite,
                      );
                    },
                  ),
                  Divider(
                    color: pureWhite,
                    height: 1,
                    thickness: 0.2,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
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
          selectedPage: 1,
        );
      },
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
    );
  }
}
