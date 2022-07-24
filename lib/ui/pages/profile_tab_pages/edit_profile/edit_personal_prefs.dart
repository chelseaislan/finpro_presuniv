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

class EditPersonalPrefs extends StatefulWidget {
  final String userId;
  final User currentUser;

  const EditPersonalPrefs({this.userId, this.currentUser});

  @override
  State<EditPersonalPrefs> createState() => _EditPersonalPrefsState();
}

class _EditPersonalPrefsState extends State<EditPersonalPrefs> {
  Firestore _firestore;
  final UserRepository _userRepository = UserRepository();
  ProfileBloc _profileBloc;
  User _currentUser;
  DropdownList _dropdownList;
  String personality, pets, smoke, tattoo, target;

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
    final List perValues = [
      personality,
      pets,
      smoke,
      tattoo,
      target,
    ];

    final List perItems = [
      _dropdownList.personalityList.map((value) {
        return DropdownMenuItem(
          child: DescText(text: value, color: secondBlack),
          value: value,
        );
      }).toList(),
      _dropdownList.petsList.map((value) {
        return DropdownMenuItem(
          child: DescText(text: value, color: secondBlack),
          value: value,
        );
      }).toList(),
      _dropdownList.smokeList.map((value) {
        return DropdownMenuItem(
          child: DescText(text: value, color: secondBlack),
          value: value,
        );
      }).toList(),
      _dropdownList.tattooList.map((value) {
        return DropdownMenuItem(
          child: DescText(text: value, color: secondBlack),
          value: value,
        );
      }).toList(),
      _dropdownList.targetList.map((value) {
        return DropdownMenuItem(
          child: DescText(text: value, color: secondBlack),
          value: value,
        );
      }).toList(),
    ];

    final List perOnChanged = [
      (value) async {
        setState(() => personality = value);
        debugPrint(value);
        _firestore
            .collection('users')
            .document(_currentUser.uid)
            .updateData({'personality': value});
        ScaffoldMessenger.of(context).showSnackBar(
          mySnackbar(
            text: "Personality details has been updated!",
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
        setState(() => pets = value);
        debugPrint(value);
        _firestore
            .collection('users')
            .document(_currentUser.uid)
            .updateData({'pets': value});
        ScaffoldMessenger.of(context).showSnackBar(
          mySnackbar(
            text: "Pet preference has been updated!",
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
        setState(() => smoke = value);
        debugPrint(value);
        _firestore
            .collection('users')
            .document(_currentUser.uid)
            .updateData({'smoke': value});
        ScaffoldMessenger.of(context).showSnackBar(
          mySnackbar(
            text: "Smoking status has been updated!",
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
        setState(() => tattoo = value);
        debugPrint(value);
        _firestore
            .collection('users')
            .document(_currentUser.uid)
            .updateData({'tattoo': value});
        ScaffoldMessenger.of(context).showSnackBar(
          mySnackbar(
            text: "Tattoo status has been updated!",
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
        setState(() => target = value);
        debugPrint(value);
        _firestore
            .collection('users')
            .document(_currentUser.uid)
            .updateData({'target': value});
        ScaffoldMessenger.of(context).showSnackBar(
          mySnackbar(
            text: "Marriage target has been updated!",
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
            text: "Personal Preferences",
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
              final List _currentUserHints = [
                _currentUser.personality,
                _currentUser.pets,
                _currentUser.smoke,
                _currentUser.tattoo,
                _currentUser.target,
              ];
              return ListView(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                children: [
                  SizedBox(height: size.width * 0.03),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: _dropdownList.ddHeadersC.length,
                    itemBuilder: (context, index) {
                      return dropdownField(
                        _dropdownList.ddHeadersC[index],
                        _dropdownList.ddIconsC[index],
                        _currentUserHints[index],
                        perValues[index],
                        perItems[index],
                        perOnChanged[index],
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
          selectedPage: 3,
        );
      },
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
    );
  }
}
