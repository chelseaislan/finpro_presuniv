// // @dart=2.9
// import 'dart:io';

// import 'package:app_settings/app_settings.dart';
// import 'package:finpro_max/custom_widgets/text_radio_field.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:file_picker/file_picker.dart';
// import 'package:finpro_max/bloc/profile/profile_bloc.dart';
// import 'package:finpro_max/bloc/profile/profile_event.dart';
// import 'package:finpro_max/bloc/profile/profile_state.dart';
// import 'package:finpro_max/custom_widgets/buttons/appbar_sidebutton.dart';
// import 'package:finpro_max/custom_widgets/buttons/big_wide_button.dart';
// import 'package:finpro_max/custom_widgets/divider.dart';
// import 'package:finpro_max/custom_widgets/modal_popup.dart';
// import 'package:finpro_max/custom_widgets/text_styles.dart';
// import 'package:finpro_max/models/colors.dart';
// import 'package:finpro_max/models/user.dart';
// import 'package:finpro_max/repositories/user_repository.dart';
// import 'package:finpro_max/ui/widgets/card_swipe_widgets/card_photo.dart';
// import 'package:finpro_max/ui/widgets/onboarding_widgets/complete_profile_form.dart';
// import 'package:finpro_max/ui/widgets/tabs.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:fluttertoast/fluttertoast.dart';

// class EditProfile extends StatefulWidget {
//   final String userId;
//   const EditProfile({this.userId});

//   @override
//   State<EditProfile> createState() => _EditProfileState();
// }

// class _EditProfileState extends State<EditProfile>
//     with TickerProviderStateMixin {
//   AnimationController _animationController;
//   Firestore _firestore;
//   final UserRepository _userRepository = UserRepository();
//   ProfileBloc _profileBloc;
//   User _currentUser;
//   File photo;
//   DropdownList _dropdownList;
//   String sholat, sSunnah, fasting, fSunnah, pilgrimage, quranLevel;
//   String province, education, marriageStatus, haveKids, childPreference;
//   String salaryRange, financials, personality, pets, smoke, tattoo, target;
//   // String userId;

//   // the textfield controllers
//   final TextEditingController _nicknameController = TextEditingController();
//   final TextEditingController _currentJobController = TextEditingController();
//   final TextEditingController _locationController = TextEditingController();
//   final TextEditingController _jobPositionController = TextEditingController();
//   final TextEditingController _hobbyController = TextEditingController();
//   final TextEditingController _aboutController = TextEditingController();

//   @override
//   void initState() {
//     _profileBloc = ProfileBloc(userRepository: _userRepository);
//     _dropdownList = DropdownList();
//     _firestore = Firestore();
//     super.initState();
//     _animationController = BottomSheet.createAnimationController(this);
//     _animationController.duration = const Duration(seconds: 0);
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;

//     // tab 2 values
//     final List relValues = [
//       sholat,
//       sSunnah,
//       fasting,
//       fSunnah,
//       pilgrimage,
//       quranLevel,
//     ];
//     final List relItems = [
//       _dropdownList.sholatList.map((value) {
//         return DropdownMenuItem(
//           child: DescText(text: value, color: secondBlack),
//           value: value,
//         );
//       }).toList(),
//       _dropdownList.sSunnahList.map((value) {
//         return DropdownMenuItem(
//           child: DescText(text: value, color: secondBlack),
//           value: value,
//         );
//       }).toList(),
//       _dropdownList.fastingList.map((value) {
//         return DropdownMenuItem(
//           child: DescText(text: value, color: secondBlack),
//           value: value,
//         );
//       }).toList(),
//       _dropdownList.fSunnahList.map((value) {
//         return DropdownMenuItem(
//           child: DescText(text: value, color: secondBlack),
//           value: value,
//         );
//       }).toList(),
//       _dropdownList.pilgrimageList.map((value) {
//         return DropdownMenuItem(
//           child: DescText(text: value, color: secondBlack),
//           value: value,
//         );
//       }).toList(),
//       _dropdownList.quranLevelList.map((value) {
//         return DropdownMenuItem(
//           child: DescText(text: value, color: secondBlack),
//           value: value,
//         );
//       }).toList(),
//     ];
//     final List relOnChanged = [
//       (value) async {
//         setState(() => sholat = value);
//         debugPrint(value);
//         _firestore
//             .collection('users')
//             .document(_currentUser.uid)
//             .updateData({'sholat': value});
//         Fluttertoast.showToast(msg: "Property has been updated");
//         Navigator.pushReplacement(
//           context,
//           reloadAfterSave(),
//         );
//       },
//       (value) async {
//         setState(() => sSunnah = value);
//         debugPrint(value);
//         _firestore
//             .collection('users')
//             .document(_currentUser.uid)
//             .updateData({'sSunnah': value});
//         Fluttertoast.showToast(msg: "Property has been updated");
//         Navigator.pushReplacement(
//           context,
//           reloadAfterSave(),
//         );
//       },
//       (value) async {
//         setState(() => fasting = value);
//         debugPrint(value);
//         _firestore
//             .collection('users')
//             .document(_currentUser.uid)
//             .updateData({'fasting': value});
//         Fluttertoast.showToast(msg: "Property has been updated");
//         Navigator.pushReplacement(
//           context,
//           reloadAfterSave(),
//         );
//       },
//       (value) async {
//         setState(() => fSunnah = value);
//         debugPrint(value);
//         _firestore
//             .collection('users')
//             .document(_currentUser.uid)
//             .updateData({'fSunnah': value});
//         Fluttertoast.showToast(msg: "Property has been updated");
//         Navigator.pushReplacement(
//           context,
//           reloadAfterSave(),
//         );
//       },
//       (value) async {
//         setState(() => pilgrimage = value);
//         debugPrint(value);
//         _firestore
//             .collection('users')
//             .document(_currentUser.uid)
//             .updateData({'pilgrimage': value});
//         Fluttertoast.showToast(msg: "Property has been updated");
//         Navigator.pushReplacement(
//           context,
//           reloadAfterSave(),
//         );
//       },
//       (value) async {
//         setState(() => quranLevel = value);
//         debugPrint(value);
//         _firestore
//             .collection('users')
//             .document(_currentUser.uid)
//             .updateData({'quranLevel': value});
//         Fluttertoast.showToast(msg: "Property has been updated");
//         Navigator.pushReplacement(
//           context,
//           reloadAfterSave(),
//         );
//       },
//     ];

//     // tab 3 values
//     final List addValues = [
//       province,
//       education,
//       marriageStatus,
//       haveKids,
//       childPreference,
//       salaryRange,
//       financials,
//     ];
//     final List addItems = [
//       _dropdownList.provinceList.map((value) {
//         return DropdownMenuItem(
//           child: DescText(text: value, color: secondBlack),
//           value: value,
//         );
//       }).toList(),
//       _dropdownList.eduList.map((value) {
//         return DropdownMenuItem(
//           child: DescText(text: value, color: secondBlack),
//           value: value,
//         );
//       }).toList(),
//       _dropdownList.marriageStatusList.map((value) {
//         return DropdownMenuItem(
//           child: DescText(text: value, color: secondBlack),
//           value: value,
//         );
//       }).toList(),
//       _dropdownList.haveKidsList.map((value) {
//         return DropdownMenuItem(
//           child: DescText(text: value, color: secondBlack),
//           value: value,
//         );
//       }).toList(),
//       _dropdownList.childPrefList.map((value) {
//         return DropdownMenuItem(
//           child: DescText(text: value, color: secondBlack),
//           value: value,
//         );
//       }).toList(),
//       _dropdownList.salaryRangeList.map((value) {
//         return DropdownMenuItem(
//           child: DescText(text: value, color: secondBlack),
//           value: value,
//         );
//       }).toList(),
//       _dropdownList.financialsList.map((value) {
//         return DropdownMenuItem(
//           child: DescText(text: value, color: secondBlack),
//           value: value,
//         );
//       }).toList(),
//     ];
//     final List addOnChanged = [
//       (value) async {
//         setState(() => province = value);
//         debugPrint(value);
//         _firestore
//             .collection('users')
//             .document(_currentUser.uid)
//             .updateData({'province': value});
//         Fluttertoast.showToast(msg: "Property has been updated");
//         Navigator.pushReplacement(
//           context,
//           reloadAfterSave(),
//         );
//       },
//       (value) async {
//         setState(() => education = value);
//         debugPrint(value);
//         _firestore
//             .collection('users')
//             .document(_currentUser.uid)
//             .updateData({'education': value});
//         Fluttertoast.showToast(msg: "Property has been updated");
//         Navigator.pushReplacement(
//           context,
//           reloadAfterSave(),
//         );
//       },
//       (value) async {
//         setState(() => marriageStatus = value);
//         debugPrint(value);
//         _firestore
//             .collection('users')
//             .document(_currentUser.uid)
//             .updateData({'marriageStatus': value});
//         Fluttertoast.showToast(msg: "Property has been updated");
//         Navigator.pushReplacement(
//           context,
//           reloadAfterSave(),
//         );
//       },
//       (value) async {
//         setState(() => haveKids = value);
//         debugPrint(value);
//         _firestore
//             .collection('users')
//             .document(_currentUser.uid)
//             .updateData({'haveKids': value});
//         Fluttertoast.showToast(msg: "Property has been updated");
//         Navigator.pushReplacement(
//           context,
//           reloadAfterSave(),
//         );
//       },
//       (value) async {
//         setState(() => childPreference = value);
//         debugPrint(value);
//         _firestore
//             .collection('users')
//             .document(_currentUser.uid)
//             .updateData({'childPreference': value});
//         Fluttertoast.showToast(msg: "Property has been updated");
//         Navigator.pushReplacement(
//           context,
//           reloadAfterSave(),
//         );
//       },
//       (value) async {
//         setState(() => salaryRange = value);
//         debugPrint(value);
//         _firestore
//             .collection('users')
//             .document(_currentUser.uid)
//             .updateData({'salaryRange': value});
//         Fluttertoast.showToast(msg: "Property has been updated");
//         Navigator.pushReplacement(
//           context,
//           reloadAfterSave(),
//         );
//       },
//       (value) async {
//         setState(() => financials = value);
//         debugPrint(value);
//         _firestore
//             .collection('users')
//             .document(_currentUser.uid)
//             .updateData({'financials': value});
//         Fluttertoast.showToast(msg: "Property has been updated");
//         Navigator.pushReplacement(
//           context,
//           reloadAfterSave(),
//         );
//       },
//     ];

//     // tab 4 values
//     final List perValues = [
//       personality,
//       pets,
//       smoke,
//       tattoo,
//       target,
//     ];
//     final List perItems = [
//       _dropdownList.personalityList.map((value) {
//         return DropdownMenuItem(
//           child: DescText(text: value, color: secondBlack),
//           value: value,
//         );
//       }).toList(),
//       _dropdownList.petsList.map((value) {
//         return DropdownMenuItem(
//           child: DescText(text: value, color: secondBlack),
//           value: value,
//         );
//       }).toList(),
//       _dropdownList.smokeList.map((value) {
//         return DropdownMenuItem(
//           child: DescText(text: value, color: secondBlack),
//           value: value,
//         );
//       }).toList(),
//       _dropdownList.tattooList.map((value) {
//         return DropdownMenuItem(
//           child: DescText(text: value, color: secondBlack),
//           value: value,
//         );
//       }).toList(),
//       _dropdownList.targetList.map((value) {
//         return DropdownMenuItem(
//           child: DescText(text: value, color: secondBlack),
//           value: value,
//         );
//       }).toList(),
//     ];
//     final List perOnChanged = [
//       (value) async {
//         setState(() => personality = value);
//         debugPrint(value);
//         _firestore
//             .collection('users')
//             .document(_currentUser.uid)
//             .updateData({'personality': value});
//         Fluttertoast.showToast(msg: "Property has been updated");
//         Navigator.pushReplacement(
//           context,
//           reloadAfterSave(),
//         );
//       },
//       (value) async {
//         setState(() => pets = value);
//         debugPrint(value);
//         _firestore
//             .collection('users')
//             .document(_currentUser.uid)
//             .updateData({'pets': value});
//         Fluttertoast.showToast(msg: "Property has been updated");
//         Navigator.pushReplacement(
//           context,
//           reloadAfterSave(),
//         );
//       },
//       (value) async {
//         setState(() => smoke = value);
//         debugPrint(value);
//         _firestore
//             .collection('users')
//             .document(_currentUser.uid)
//             .updateData({'smoke': value});
//         Fluttertoast.showToast(msg: "Property has been updated");
//         Navigator.pushReplacement(
//           context,
//           reloadAfterSave(),
//         );
//       },
//       (value) async {
//         setState(() => tattoo = value);
//         debugPrint(value);
//         _firestore
//             .collection('users')
//             .document(_currentUser.uid)
//             .updateData({'tattoo': value});
//         Fluttertoast.showToast(msg: "Property has been updated");
//         Navigator.pushReplacement(
//           context,
//           reloadAfterSave(),
//         );
//       },
//       (value) async {
//         setState(() => target = value);
//         debugPrint(value);
//         _firestore
//             .collection('users')
//             .document(_currentUser.uid)
//             .updateData({'target': value});
//         Fluttertoast.showToast(msg: "Property has been updated");
//         Navigator.pushReplacement(
//           context,
//           reloadAfterSave(),
//         );
//       },
//     ];

//     return Container(
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: [primary1, appBarColor],
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//         ),
//       ),
//       child: Scaffold(
//         backgroundColor: Colors.transparent,
//         appBar: AppBarSideButton(
//           appBarTitle: const Text("Edit Profile"),
//           appBarColor: primary1,
//         ),
//         body: BlocBuilder<ProfileBloc, ProfileState>(
//           bloc: _profileBloc,
//           builder: (context, state) {
//             if (state is ProfileInitialState) {
//               _profileBloc.add(ProfileLoadedEvent(userId: widget.userId));
//             }
//             if (state is ProfileLoadingState) {
//               return Center(child: CircularProgressIndicator(color: white));
//             }
//             if (state is ProfileLoadedState) {
//               _currentUser = state.currentUser;

//               // Tab 1
//               final List header = [
//                 "Nickname",
//                 "Company / Organization",
//                 "Job Position",
//                 "City (Province in Additional Details)",
//                 "Hobby",
//                 "About Me",
//               ];
//               final List hintText = [
//                 "nickname",
//                 "company",
//                 "position",
//                 "location",
//                 "hobby",
//                 "description about you",
//               ];
//               final List descText = [
//                 _currentUser.nickname,
//                 _currentUser.currentJob,
//                 _currentUser.jobPosition,
//                 _currentUser.location,
//                 _currentUser.hobby,
//                 "Describe a bit about yourself!"
//               ];
//               final List controller = [
//                 _nicknameController,
//                 _currentJobController,
//                 _jobPositionController,
//                 _locationController,
//                 _hobbyController,
//                 _aboutController,
//               ];
//               final List onSaved = [
//                 () {
//                   _nicknameController.text == null ||
//                           _nicknameController.text == ""
//                       ? Fluttertoast.showToast(
//                           msg: "Please input your nickname.")
//                       : setState(() {
//                           _firestore
//                               .collection('users')
//                               .document(_currentUser.uid)
//                               .updateData(
//                                   {'nickname': _nicknameController.text});
//                           Fluttertoast.showToast(
//                               msg: "Nickname has been updated");
//                           Navigator.pushReplacement(context, reloadAfterSave());
//                         });
//                 },
//                 () {
//                   _currentJobController.text == null ||
//                           _currentJobController.text == ""
//                       ? Fluttertoast.showToast(
//                           msg: "Please input your current company.")
//                       : setState(() {
//                           _firestore
//                               .collection('users')
//                               .document(_currentUser.uid)
//                               .updateData(
//                                   {'currentJob': _currentJobController.text});
//                           Fluttertoast.showToast(
//                               msg: "Current Job has been updated");
//                           Navigator.pushReplacement(context, reloadAfterSave());
//                         });
//                 },
//                 () {
//                   _jobPositionController.text == null ||
//                           _jobPositionController.text == ""
//                       ? Fluttertoast.showToast(
//                           msg: "Please input your job position.")
//                       : setState(() {
//                           _firestore
//                               .collection('users')
//                               .document(_currentUser.uid)
//                               .updateData(
//                                   {'jobPosition': _jobPositionController.text});
//                           Fluttertoast.showToast(
//                               msg: "Job Position has been updated");
//                           Navigator.pushReplacement(context, reloadAfterSave());
//                         });
//                 },
//                 () {
//                   _locationController.text == null ||
//                           _locationController.text == ""
//                       ? Fluttertoast.showToast(
//                           msg: "Please input your current city.")
//                       : setState(() {
//                           _firestore
//                               .collection('users')
//                               .document(_currentUser.uid)
//                               .updateData(
//                                   {'location': _locationController.text});
//                           Fluttertoast.showToast(msg: "City has been updated");
//                           Navigator.pushReplacement(context, reloadAfterSave());
//                         });
//                 },
//                 () {
//                   _hobbyController.text == null || _hobbyController.text == ""
//                       ? Fluttertoast.showToast(msg: "Please input your hobby.")
//                       : setState(() {
//                           _firestore
//                               .collection('users')
//                               .document(_currentUser.uid)
//                               .updateData({'hobby': _hobbyController.text});
//                           Fluttertoast.showToast(msg: "Hobby has been updated");
//                           Navigator.pushReplacement(context, reloadAfterSave());
//                         });
//                 },
//                 () {
//                   _aboutController.text == null || _aboutController.text == ""
//                       ? Fluttertoast.showToast(
//                           msg: "Please input your a little bit about yourself.")
//                       : setState(() {
//                           _firestore
//                               .collection('users')
//                               .document(_currentUser.uid)
//                               .updateData({'aboutMe': _aboutController.text});
//                           Fluttertoast.showToast(
//                               msg: "About Me has been updated");
//                           Navigator.pushReplacement(context, reloadAfterSave());
//                         });
//                 },
//               ];

//               // Tab 2 3 4
//               final List relHints = [
//                 _currentUser.sholat,
//                 _currentUser.sSunnah,
//                 _currentUser.fasting,
//                 _currentUser.fSunnah,
//                 _currentUser.pilgrimage,
//                 _currentUser.quranLevel,
//               ];
//               final List addHints = [
//                 _currentUser.province,
//                 _currentUser.education,
//                 _currentUser.marriageStatus,
//                 _currentUser.haveKids,
//                 _currentUser.childPreference,
//                 _currentUser.salaryRange,
//                 _currentUser.financials,
//               ];
//               final List perHints = [
//                 _currentUser.personality,
//                 _currentUser.pets,
//                 _currentUser.smoke,
//                 _currentUser.tattoo,
//                 _currentUser.target,
//               ];

//               return DefaultTabController(
//                 initialIndex: 0,
//                 animationDuration: Duration.zero,
//                 length: 4,
//                 child: Column(
//                   children: [
//                     Expanded(
//                       child: TabBarView(
//                         physics: const NeverScrollableScrollPhysics(),
//                         children: [
//                           // tab 1
//                           SingleChildScrollView(
//                             child: Padding(
//                               padding: EdgeInsets.symmetric(
//                                   horizontal: size.width * 0.05),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                                 children: [
//                                   const CompleteStepHeader(
//                                     stepNumber: 1,
//                                     header: "Basic Details",
//                                     description:
//                                         "We'd like to know you better while using this app.",
//                                   ),
//                                   Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Stack(
//                                         alignment: Alignment.bottomRight,
//                                         children: [
//                                           GestureDetector(
//                                             child: ClipRRect(
//                                               borderRadius:
//                                                   BorderRadius.circular(
//                                                       size.width * 0.03),
//                                               child: Container(
//                                                 color: white,
//                                                 width: size.width * 0.43,
//                                                 height: size.width * 0.43,
//                                                 child: CardPhotoWidget(
//                                                     photoLink:
//                                                         _currentUser.photo),
//                                               ),
//                                             ),
//                                             onTap: () async {
//                                               try {
//                                                 FilePickerResult getAvatar =
//                                                     await FilePicker.platform
//                                                         .pickFiles(
//                                                             type:
//                                                                 FileType.image);
//                                                 if (getAvatar != null) {
//                                                   File file = File(getAvatar
//                                                       .files.single.path);
//                                                   setState(
//                                                     () {
//                                                       photo = file;
//                                                       Fluttertoast.showToast(
//                                                           msg: "Uploading...",
//                                                           toastLength: Toast
//                                                               .LENGTH_LONG);
//                                                       StorageUploadTask
//                                                           storageUploadTask;
//                                                       storageUploadTask = FirebaseStorage
//                                                           .instance
//                                                           .ref()
//                                                           .child(
//                                                               'userPhotos') // create folder userPhotos
//                                                           .child(_currentUser
//                                                               .uid) // uid as the folder name
//                                                           .child(
//                                                               'avatar_${_currentUser.name}') // uid as the file name
//                                                           .putFile(photo);
//                                                       storageUploadTask
//                                                           .onComplete
//                                                           .then(
//                                                         (ref) async {
//                                                           await Fluttertoast.showToast(
//                                                               msg:
//                                                                   "Almost done...",
//                                                               toastLength: Toast
//                                                                   .LENGTH_LONG);
//                                                           ref.ref
//                                                               .getDownloadURL()
//                                                               .then(
//                                                                   (url) async {
//                                                             await _firestore
//                                                                 .collection(
//                                                                     'users')
//                                                                 .document(
//                                                                     _currentUser
//                                                                         .uid)
//                                                                 .updateData({
//                                                               'photoUrl': url
//                                                             });
//                                                             await Fluttertoast
//                                                                 .showToast(
//                                                                     msg:
//                                                                         "Profile picture updated successfully.");
//                                                             Navigator
//                                                                 .pushReplacement(
//                                                                     context,
//                                                                     reloadAfterSave());
//                                                           });
//                                                         },
//                                                       );
//                                                     },
//                                                   );
//                                                 }
//                                               } catch (e) {
//                                                 showModalBottomSheet(
//                                                   transitionAnimationController:
//                                                       _animationController,
//                                                   context: context,
//                                                   shape:
//                                                       const RoundedRectangleBorder(
//                                                     borderRadius:
//                                                         BorderRadius.only(
//                                                       topLeft:
//                                                           Radius.circular(10),
//                                                       topRight:
//                                                           Radius.circular(10),
//                                                     ),
//                                                   ),
//                                                   builder: (context) {
//                                                     return ModalPopupOneButton(
//                                                       size: size,
//                                                       title:
//                                                           "Storage Permission Denied",
//                                                       image:
//                                                           "assets/images/404.png",
//                                                       description:
//                                                           "To upload pictures and documents, please enable permission to read external storage.",
//                                                       onPressed: () =>
//                                                           AppSettings
//                                                               .openAppSettings(),
//                                                     );
//                                                   },
//                                                 );
//                                               }
//                                             },
//                                           ),
//                                           MiniPill(size: size, text: "Avatar"),
//                                         ],
//                                       ),
//                                       Container(
//                                         width: size.width * 0.43,
//                                         height: size.width * 0.43,
//                                         decoration: BoxDecoration(
//                                           color: white,
//                                           borderRadius: BorderRadius.circular(
//                                               size.width * 0.03),
//                                         ),
//                                         child: Column(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.center,
//                                           children: [
//                                             const UploadPlaceholder(
//                                               iconData:
//                                                   Icons.blur_circular_outlined,
//                                               text: "Blur avatar?",
//                                             ),
//                                             Switch(
//                                               value: _currentUser.blurAvatar,
//                                               onChanged: (value) {
//                                                 setState(() {
//                                                   _firestore
//                                                       .collection('users')
//                                                       .document(
//                                                           _currentUser.uid)
//                                                       .updateData({
//                                                     'blurAvatar': value,
//                                                   });
//                                                   Fluttertoast.showToast(
//                                                       msg:
//                                                           "Property has been updated");
//                                                   Navigator.pushReplacement(
//                                                       context,
//                                                       reloadAfterSave());
//                                                 });
//                                               },
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                   const SizedBox(height: 15),
//                                   PaddingDivider(color: white),
//                                   Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.stretch,
//                                     children: [
//                                       HeaderFourText(
//                                           text: "Full Legal Name",
//                                           color: white),
//                                       DescText(
//                                           text: _currentUser.name,
//                                           color: white),
//                                       SizedBox(height: size.width * 0.04),
//                                       ListView.builder(
//                                         physics:
//                                             const NeverScrollableScrollPhysics(),
//                                         scrollDirection: Axis.vertical,
//                                         shrinkWrap: true,
//                                         itemCount: header.length,
//                                         itemBuilder: (context, index) {
//                                           return ProfileEditableColumns(
//                                             header: header[index],
//                                             descText: descText[index],
//                                             hintText: hintText[index],
//                                             controller: controller[index],
//                                             onSaved: onSaved[index],
//                                             animationController:
//                                                 _animationController,
//                                           );
//                                         },
//                                       ),
//                                       PaddingDivider(color: white),
//                                       toProfile(context),
//                                       const SizedBox(height: 20),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           // Tab 2
//                           SingleChildScrollView(
//                             child: Padding(
//                               padding: EdgeInsets.symmetric(
//                                   horizontal: size.width * 0.05),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                                 children: [
//                                   const CompleteStepHeader(
//                                     stepNumber: 2,
//                                     header: "Religion Details",
//                                     description:
//                                         "We'd like to know you better while using this app.",
//                                   ),
//                                   ListView.builder(
//                                     physics:
//                                         const NeverScrollableScrollPhysics(),
//                                     scrollDirection: Axis.vertical,
//                                     shrinkWrap: true,
//                                     itemCount: _dropdownList.ddHeadersA.length,
//                                     itemBuilder: (context, index) {
//                                       return dropdownField(
//                                         _dropdownList.ddHeadersA[index],
//                                         _dropdownList.ddIconsA[index],
//                                         relHints[index],
//                                         relValues[index],
//                                         relItems[index],
//                                         relOnChanged[index],
//                                         white,
//                                       );
//                                     },
//                                   ),
//                                   toProfile(context),
//                                   const SizedBox(height: 20),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           // Tab 3
//                           SingleChildScrollView(
//                             child: Padding(
//                               padding: EdgeInsets.symmetric(
//                                   horizontal: size.width * 0.05),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                                 children: [
//                                   const CompleteStepHeader(
//                                     stepNumber: 3,
//                                     header: "Additional Details",
//                                     description:
//                                         "We'd like to know you better while using this app.",
//                                   ),
//                                   ListView.builder(
//                                     physics:
//                                         const NeverScrollableScrollPhysics(),
//                                     scrollDirection: Axis.vertical,
//                                     shrinkWrap: true,
//                                     itemCount: _dropdownList.ddHeadersB.length,
//                                     itemBuilder: (context, index) {
//                                       return dropdownField(
//                                         _dropdownList.ddHeadersB[index],
//                                         _dropdownList.ddIconsB[index],
//                                         addHints[index],
//                                         addValues[index],
//                                         addItems[index],
//                                         addOnChanged[index],
//                                         white,
//                                       );
//                                     },
//                                   ),
//                                   toProfile(context),
//                                   const SizedBox(height: 20),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           // Tab 4
//                           SingleChildScrollView(
//                             child: Padding(
//                               padding: EdgeInsets.symmetric(
//                                   horizontal: size.width * 0.05),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                                 children: [
//                                   const CompleteStepHeader(
//                                     stepNumber: 4,
//                                     header: "Personal Preferences",
//                                     description:
//                                         "We'd like to know you better while using this app.",
//                                   ),
//                                   ListView.builder(
//                                     physics:
//                                         const NeverScrollableScrollPhysics(),
//                                     scrollDirection: Axis.vertical,
//                                     shrinkWrap: true,
//                                     itemCount: _dropdownList.ddHeadersC.length,
//                                     itemBuilder: (context, index) {
//                                       return dropdownField(
//                                         _dropdownList.ddHeadersC[index],
//                                         _dropdownList.ddIconsC[index],
//                                         perHints[index],
//                                         perValues[index],
//                                         perItems[index],
//                                         perOnChanged[index],
//                                         white,
//                                       );
//                                     },
//                                   ),
//                                   toProfile(context),
//                                   const SizedBox(height: 20),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Container(
//                       color: primary1,
//                       child: TabBar(
//                         isScrollable: true,
//                         indicatorColor: gold,
//                         labelColor: gold,
//                         unselectedLabelColor: white,
//                         indicatorSize: TabBarIndicatorSize.tab,
//                         indicatorPadding: const EdgeInsets.all(5.0),
//                         tabs: const [
//                           Tab(text: "Basic Details"),
//                           Tab(text: "Religion Details"),
//                           Tab(text: "Additional Details"),
//                           Tab(text: "Personal Preferences"),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             } else {
//               return Container();
//             }
//           },
//         ),
//       ),
//     );
//   }

//   BigWideButton toProfile(BuildContext context) {
//     return BigWideButton(
//       labelText: "Back to Profile",
//       onPressedTo: () {
//         Navigator.pushAndRemoveUntil(
//           context,
//           PageRouteBuilder(
//             pageBuilder: (context, animation1, animation2) =>
//                 HomeTabs(userId: widget.userId, selectedPage: 4),
//             transitionDuration: Duration.zero,
//             reverseTransitionDuration: Duration.zero,
//           ),
//           (route) => false,
//         );
//       },
//       textColor: secondBlack,
//       btnColor: gold,
//     );
//   }

//   PageRouteBuilder<dynamic> reloadAfterSave() {
//     return PageRouteBuilder(
//       pageBuilder: (context, animation1, animation2) => widget,
//       transitionDuration: Duration.zero,
//       reverseTransitionDuration: Duration.zero,
//     );
//   }
// }

// class ProfileEditableColumns extends StatelessWidget {
//   const ProfileEditableColumns({
//     Key key,
//     @required this.header,
//     @required this.descText,
//     @required this.hintText,
//     @required this.controller,
//     @required this.animationController,
//     @required this.onSaved,
//   }) : super(key: key);

//   final String header;
//   final String descText;
//   final String hintText;
//   final TextEditingController controller;
//   final AnimationController animationController;
//   final Function() onSaved;

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Column(
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 HeaderFourText(text: header, color: white),
//                 DescText(
//                   text: descText,
//                   color: white,
//                   overflow: TextOverflow.ellipsis,
//                 ),
//               ],
//             ),
//             BigWideButtonIcon(
//               labelText: "",
//               textColor: secondBlack,
//               btnColor: gold,
//               iconData: Icons.edit_note_outlined,
//               onPressedTo: () {
//                 showModalBottomSheet(
//                   transitionAnimationController: animationController,
//                   context: context,
//                   shape: const RoundedRectangleBorder(
//                     borderRadius: BorderRadius.only(
//                         topLeft: Radius.circular(10),
//                         topRight: Radius.circular(10)),
//                   ),
//                   isScrollControlled: true,
//                   builder: (context) {
//                     return Padding(
//                       padding: const EdgeInsets.all(20),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           HeaderThreeText(
//                             text: "Input new $hintText:",
//                             color: secondBlack,
//                           ),
//                           const SizedBox(height: 10),
//                           Padding(
//                             padding: EdgeInsets.only(
//                                 bottom:
//                                     MediaQuery.of(context).viewInsets.bottom),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Flexible(
//                                   flex: 9,
//                                   child: TextFormField(
//                                     autofocus: true,
//                                     textCapitalization:
//                                         TextCapitalization.words,
//                                     controller: controller, // 2
//                                     decoration: InputDecoration(
//                                       hintText: "New $hintText",
//                                       isDense: true,
//                                       enabledBorder: OutlineInputBorder(
//                                         borderRadius: BorderRadius.circular(15),
//                                         borderSide: BorderSide(
//                                             width: 3, color: lightGrey2),
//                                       ),
//                                       focusedBorder: OutlineInputBorder(
//                                         borderRadius: BorderRadius.circular(15),
//                                         borderSide: BorderSide(
//                                             width: 3, color: lightGrey3),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 Flexible(
//                                   flex: 3,
//                                   child: BigWideButton(
//                                     labelText: "Save",
//                                     onPressedTo: onSaved,
//                                     textColor: white,
//                                     btnColor: primary1,
//                                   ),
//                                 )
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ],
//         ),
//         SizedBox(height: size.width * 0.05),
//       ],
//     );
//   }
// }
