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
import 'package:fluttertoast/fluttertoast.dart';

class EditAdditionals extends StatefulWidget {
  final String userId;
  final User currentUser;

  const EditAdditionals({this.userId, this.currentUser});

  @override
  State<EditAdditionals> createState() => _EditAdditionalsState();
}

class _EditAdditionalsState extends State<EditAdditionals> {
  Firestore _firestore;
  final UserRepository _userRepository = UserRepository();
  ProfileBloc _profileBloc;
  User _currentUser;
  DropdownList _dropdownList;
  String province,
      education,
      marriageStatus,
      haveKids,
      childPreference,
      salaryRange,
      financials;

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
    final List addValues = [
      province,
      education,
      marriageStatus,
      haveKids,
      childPreference,
      salaryRange,
      financials,
    ];

    final List addItems = [
      _dropdownList.provinceList.map((value) {
        return DropdownMenuItem(
          child: DescText(text: value, color: secondBlack),
          value: value,
        );
      }).toList(),
      _dropdownList.eduList.map((value) {
        return DropdownMenuItem(
          child: DescText(text: value, color: secondBlack),
          value: value,
        );
      }).toList(),
      _dropdownList.marriageStatusList.map((value) {
        return DropdownMenuItem(
          child: DescText(text: value, color: secondBlack),
          value: value,
        );
      }).toList(),
      _dropdownList.haveKidsList.map((value) {
        return DropdownMenuItem(
          child: DescText(text: value, color: secondBlack),
          value: value,
        );
      }).toList(),
      _dropdownList.childPrefList.map((value) {
        return DropdownMenuItem(
          child: DescText(text: value, color: secondBlack),
          value: value,
        );
      }).toList(),
      _dropdownList.salaryRangeList.map((value) {
        return DropdownMenuItem(
          child: DescText(text: value, color: secondBlack),
          value: value,
        );
      }).toList(),
      _dropdownList.financialsList.map((value) {
        return DropdownMenuItem(
          child: DescText(text: value, color: secondBlack),
          value: value,
        );
      }).toList(),
    ];

    final List addOnChanged = [
      (value) async {
        setState(() => province = value);
        debugPrint(value);
        _firestore
            .collection('users')
            .document(_currentUser.uid)
            .updateData({'province': value});
        ScaffoldMessenger.of(context).showSnackBar(
          mySnackbar(
            text:
                "Province has been updated, now the search results are based on your new province ($value).",
            duration: 6,
            background: primaryBlack,
          ),
        );
        Navigator.pushReplacement(
          context,
          reloadAfterSave(),
        );
      },
      (value) async {
        setState(() => education = value);
        debugPrint(value);
        _firestore
            .collection('users')
            .document(_currentUser.uid)
            .updateData({'education': value});
        ScaffoldMessenger.of(context).showSnackBar(
          mySnackbar(
            text: "Education details has been updated!",
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
        setState(() => marriageStatus = value);
        debugPrint(value);
        _firestore
            .collection('users')
            .document(_currentUser.uid)
            .updateData({'marriageStatus': value});
        ScaffoldMessenger.of(context).showSnackBar(
          mySnackbar(
            text: "Marriage status has been updated!",
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
        setState(() => haveKids = value);
        debugPrint(value);
        _firestore
            .collection('users')
            .document(_currentUser.uid)
            .updateData({'haveKids': value});
        ScaffoldMessenger.of(context).showSnackBar(
          mySnackbar(
            text: "Children status has been updated!",
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
        setState(() => childPreference = value);
        debugPrint(value);
        _firestore
            .collection('users')
            .document(_currentUser.uid)
            .updateData({'childPreference': value});
        ScaffoldMessenger.of(context).showSnackBar(
          mySnackbar(
            text: "Child preference has been updated!",
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
        setState(() => salaryRange = value);
        debugPrint(value);
        _firestore
            .collection('users')
            .document(_currentUser.uid)
            .updateData({'salaryRange': value});
        ScaffoldMessenger.of(context).showSnackBar(
          mySnackbar(
            text: "Salary range has been updated!",
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
        setState(() => financials = value);
        debugPrint(value);
        _firestore
            .collection('users')
            .document(_currentUser.uid)
            .updateData({'financials': value});
        ScaffoldMessenger.of(context).showSnackBar(
          mySnackbar(
            text: "Debt status has been updated!",
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
          appBarTitle: const Text("Additional Details"),
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
              final List _addHints = [
                _currentUser.province,
                _currentUser.education,
                _currentUser.marriageStatus,
                _currentUser.haveKids,
                _currentUser.childPreference,
                _currentUser.salaryRange,
                _currentUser.financials,
              ];
              return ListView(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                children: [
                  SizedBox(height: size.width * 0.03),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: _dropdownList.ddHeadersB.length,
                    itemBuilder: (context, index) {
                      return dropdownField(
                        _dropdownList.ddHeadersB[index],
                        _dropdownList.ddIconsB[index],
                        _addHints[index],
                        addValues[index],
                        addItems[index],
                        addOnChanged[index],
                        white,
                      );
                    },
                  ),
                  Divider(
                    color: white,
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
          selectedPage: 2,
        );
      },
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
    );
  }
}
