// import 'package:finpro_max/bloc/taaruf/taaruf_bloc.dart';
// import 'package:finpro_max/bloc/taaruf/taaruf_event.dart';
// import 'package:finpro_max/bloc/taaruf/taaruf_state.dart';
// import 'package:finpro_max/custom_widgets/buttons/appbar_sidebutton.dart';
// import 'package:finpro_max/custom_widgets/divider.dart';
// import 'package:finpro_max/custom_widgets/empty_content.dart';
// import 'package:finpro_max/custom_widgets/modal_popup.dart';
// import 'package:finpro_max/custom_widgets/quran_verses.dart';
// import 'package:finpro_max/custom_widgets/text_styles.dart';
// import 'package:finpro_max/models/colors.dart';
// import 'package:finpro_max/models/user.dart';
// import 'package:finpro_max/repositories/taaruf_repository.dart';
// import 'package:finpro_max/ui/pages/taaruf_pages/checklist_2_page.dart';
// import 'package:finpro_max/ui/pages/taaruf_pages/checklist_3_page.dart';
// import 'package:finpro_max/ui/pages/taaruf_pages/checklist_4_page.dart';
// import 'package:finpro_max/ui/pages/taaruf_pages/checklist_5_page.dart';
// import 'package:finpro_max/ui/widgets/taaruf_widgets/taaruf_buttons.dart';
// import 'package:finpro_max/ui/widgets/taaruf_widgets/taaruf_calendar.dart';
// import 'package:finpro_max/ui/widgets/taaruf_widgets/taaruf_header.dart';
// import 'package:finpro_max/ui/widgets/tabs.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:group_button/group_button.dart';
// import 'package:quran/quran.dart' as quran;

// class ChecklistOne extends StatefulWidget {
//   final String currentUserId, selectedUserId;
//   const ChecklistOne({this.currentUserId, this.selectedUserId});

//   @override
//   State<ChecklistOne> createState() => _ChecklistOneState();
// }

// class _ChecklistOneState extends State<ChecklistOne>
//     with TickerProviderStateMixin {
//   AnimationController _animationController;
//   final TaarufRepository _taarufRepository = TaarufRepository();
//   TaarufBloc _taarufBloc;
//   User _selectedUser, _currentUser;
//   TaarufList _taarufList;

//   @override
//   void initState() {
//     _taarufBloc = TaarufBloc(taarufRepository: _taarufRepository);
//     _taarufList = TaarufList();
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
//     // DateTime now = DateTime.now();
//     Size size = MediaQuery.of(context).size;

//     return Scaffold(
//       backgroundColor: primary5,
//       appBar: AppBarSideButton(
//         appBarTitle: const Text("Taaruf Checklist - 1"),
//         appBarColor: primary1,
//         appBarIcon: Icons.home_outlined,
//         onPressed: () {
//           Navigator.pushAndRemoveUntil(
//             context,
//             PageRouteBuilder(
//               pageBuilder: (context, animation1, animation2) =>
//                   HomeTabs(userId: widget.currentUserId, selectedPage: 3),
//               transitionDuration: Duration.zero,
//               reverseTransitionDuration: Duration.zero,
//             ),
//             (route) => false,
//           );
//         },
//         tooltip: "Home",
//       ),
//       body: RefreshIndicator(
//         onRefresh: () => Navigator.pushReplacement(context, reloadAfterSave()),
//         child: BlocBuilder<TaarufBloc, TaarufState>(
//           bloc: _taarufBloc,
//           builder: (context, state) {
//             if (state is TaarufLoadingState) {
//               _taarufBloc.add(TaarufLoadUserEvent(
//                 currentUserId: widget.currentUserId,
//                 selectedUserId: widget.selectedUserId,
//               ));
//             }
//             if (state is TaarufLoadUserState) {
//               _selectedUser = state.selectedUser;
//               _currentUser = state.currentUser;
//               if (_currentUser.taarufWith == null ||
//                   _currentUser.taarufWith == _selectedUser.uid) {
//                 if (_currentUser.taarufChecklist ==
//                     _selectedUser.taarufChecklist) {
//                   if (_currentUser.taarufChecklist == 0 ||
//                       _currentUser.taarufChecklist == 1) {
//                     return SingleChildScrollView(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.stretch,
//                         children: [
//                           TaarufHeader(
//                             size: size,
//                             header: "Hello, ${_currentUser.nickname}!",
//                             description:
//                                 "Ready to start a new exciting journey with your new partner, ${_selectedUser.nickname}?",
//                             photoLink:
//                                 "https://media.giphy.com/media/3ohhwqXYQZKqvhVDuU/giphy-downsized.gif",
//                           ),
//                           const SizedBox(height: 10),
//                           Padding(
//                             padding: EdgeInsets.symmetric(
//                               vertical: 10,
//                               horizontal: size.width * 0.05,
//                             ),
//                             child: Column(
//                               children: [
//                                 HeaderTwoText(
//                                   text: quran.getVerse(49, 13,
//                                       verseEndSymbol: true),
//                                   color: white,
//                                   align: TextAlign.right,
//                                 ),
//                                 const SizedBox(height: 10),
//                                 const QuranOne(),
//                                 const SizedBox(height: 10),
//                                 PaddingDivider(color: white),
//                                 DescText(
//                                   text:
//                                       "In this application, taaruf is divided into five steps:",
//                                   color: white,
//                                 ),
//                               ],
//                             ),
//                           ),
//                           Padding(
//                             padding: EdgeInsets.symmetric(
//                               horizontal: size.width * 0.05,
//                               vertical: 5,
//                             ),
//                             child: ListView.builder(
//                                 physics: const NeverScrollableScrollPhysics(),
//                                 scrollDirection: Axis.vertical,
//                                 shrinkWrap: true,
//                                 itemCount: _taarufList.headersA.length,
//                                 itemBuilder: (context, index) {
//                                   return Column(
//                                     crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                     children: [
//                                       HeaderFourText(
//                                           text: _taarufList.headersA[index],
//                                           color: white),
//                                       const SizedBox(height: 5),
//                                       ChatText(
//                                         text: _taarufList.descriptionsA[index],
//                                         color: white,
//                                       ),
//                                       const SizedBox(height: 15),
//                                     ],
//                                   );
//                                 }),
//                           ),
//                           PaddingDivider(color: white),
//                           TaarufCalendar(
//                             size: size,
//                             header:
//                                 "Please set the time to visit the first parents:",
//                             dateText: _currentUser.marriageA != null
//                                 ? "Visit Date: ${_currentUser.marriageA.toDate().day}/${_currentUser.marriageA.toDate().month}/${_currentUser.marriageA.toDate().year}"
//                                 : "Visit Date: ",
//                             onCalendarTap: () {
//                               showDialog(
//                                 context: context,
//                                 builder: (BuildContext context) => AlertDialog(
//                                   title: const Text("Confirmation"),
//                                   content: Text(
//                                       "After setting the date, you cannot perform taaruf with the other users unless you cancel your current taaruf with ${_selectedUser.nickname}."),
//                                   actions: <Widget>[
//                                     TextButton(
//                                       onPressed: () => Navigator.pop(context),
//                                       child: const Text("Cancel"),
//                                     ),
//                                     TextButton(
//                                       child: const Text("OK"),
//                                       onPressed: () {
//                                         DatePicker.showDatePicker(context,
//                                             locale: LocaleType.id,
//                                             showTitleActions: true,
//                                             minTime: DateTime.now(),
//                                             // must be atleast 18 yo
//                                             maxTime: DateTime(2024, 12, 31),
//                                             onConfirm: (date) {
//                                           setState(() {
//                                             _taarufBloc.add(AddCalendarAEvent(
//                                               currentUserId:
//                                                   widget.currentUserId,
//                                               selectedUserId:
//                                                   widget.selectedUserId,
//                                               taarufWithCurrentUser:
//                                                   _selectedUser.uid,
//                                               taarufWithSelectedUser:
//                                                   _currentUser.uid,
//                                               taarufCheck: 1,
//                                               marriageA: date,
//                                             ));
//                                             Fluttertoast.showToast(
//                                                 msg: "Date has been updated");
//                                             Navigator.pushReplacement(
//                                                 context, reloadAfterSave());
//                                           });
//                                         });
//                                       },
//                                     ),
//                                   ],
//                                 ),
//                               );
//                             },
//                           ),
//                           PaddingDivider(color: white),
//                           Padding(
//                             padding: const EdgeInsets.fromLTRB(20, 0, 20, 25),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.stretch,
//                               children: [
//                                 HeaderFourText(
//                                   text:
//                                       "What do you expect for your first parents visit?",
//                                   color: white,
//                                 ),
//                                 const SizedBox(height: 10),
//                                 GroupButton.checkbox(
//                                   borderRadius: BorderRadius.circular(10),
//                                   selectedTextStyle:
//                                       TextStyle(color: primaryBlack),
//                                   selectedColor: gold,
//                                   unselectedColor: primary1,
//                                   unselectedTextStyle: TextStyle(color: white),
//                                   textPadding: const EdgeInsets.only(top: 3),
//                                   buttons: const [
//                                     "Humbled",
//                                     "Nervous",
//                                     "Terrified",
//                                     "Bored",
//                                     "Just Normal",
//                                     "Optimistic",
//                                     "Pessimistic",
//                                   ],
//                                   onSelected: (i, selected) =>
//                                       debugPrint("Button #$i is selected."),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           TaarufButtons(
//                             selectedUser: _selectedUser.nickname,
//                             size: size,
//                             onPressedTop: () {
//                               if (_currentUser.marriageA != null) {
//                                 if (DateTime.now()
//                                     .isAfter(_currentUser.marriageA.toDate())) {
//                                   return Navigator.pushReplacement(
//                                     context,
//                                     PageRouteBuilder(
//                                       pageBuilder:
//                                           (context, animation1, animation2) =>
//                                               ChecklistTwo(
//                                         currentUserId: widget.currentUserId,
//                                         selectedUserId: widget.selectedUserId,
//                                       ),
//                                       transitionDuration: Duration.zero,
//                                       reverseTransitionDuration: Duration.zero,
//                                     ),
//                                   );
//                                 } else if (DateTime.now().isBefore(
//                                     _currentUser.marriageA.toDate())) {
//                                   return Fluttertoast.showToast(
//                                       msg:
//                                           "Please wait until the specified date to go to the next step.");
//                                 }
//                               } else {
//                                 return Fluttertoast.showToast(
//                                     msg: "Please specify the date.");
//                               }
//                             },
//                             onPressedBottom: () {
//                               showModalBottomSheet(
//                                 transitionAnimationController:
//                                     _animationController,
//                                 context: context,
//                                 shape: const RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.only(
//                                     topLeft: Radius.circular(10),
//                                     topRight: Radius.circular(10),
//                                   ),
//                                 ),
//                                 isScrollControlled: true,
//                                 builder: (context) {
//                                   return SingleChildScrollView(
//                                     child: ModalPopupTwoButton(
//                                       size: size,
//                                       title:
//                                           "Cancel taaruf with ${_currentUser.nickname}?",
//                                       image: "assets/images/think.png",
//                                       description:
//                                           "If you feel unfit with this user, you may cancel this taaruf and find a new one to begin with.",
//                                       labelTop: "No",
//                                       labelBottom: "Yes",
//                                       textColorTop: white,
//                                       btnTop: primary1,
//                                       textColorBottom: white,
//                                       btnBottom: primary2,
//                                       onPressedTop: () =>
//                                           Navigator.pop(context),
//                                       onPressedBottom: () {
//                                         _taarufBloc.add(CancelTaarufEvent(
//                                           currentUserId: widget.currentUserId,
//                                           selectedUserId: widget.selectedUserId,
//                                         ));
//                                         Navigator.pushAndRemoveUntil(
//                                           context,
//                                           PageRouteBuilder(
//                                             pageBuilder: (context, animation1,
//                                                     animation2) =>
//                                                 HomeTabs(
//                                                     userId:
//                                                         widget.currentUserId,
//                                                     selectedPage: 2),
//                                             transitionDuration: Duration.zero,
//                                             reverseTransitionDuration:
//                                                 Duration.zero,
//                                           ),
//                                           (route) => false,
//                                         );
//                                       },
//                                     ),
//                                   );
//                                 },
//                               );
//                             },
//                           ),
//                         ],
//                       ),
//                     );
//                   } else if (_currentUser.taarufChecklist == 2) {
//                     WidgetsBinding.instance.addPostFrameCallback((_) {
//                       Navigator.pushReplacement(
//                         context,
//                         PageRouteBuilder(
//                           pageBuilder: (context, animation1, animation2) =>
//                               ChecklistTwo(
//                             currentUserId: widget.currentUserId,
//                             selectedUserId: widget.selectedUserId,
//                           ),
//                           transitionDuration: Duration.zero,
//                           reverseTransitionDuration: Duration.zero,
//                         ),
//                       );
//                     });
//                   } else if (_currentUser.taarufChecklist == 3) {
//                     WidgetsBinding.instance.addPostFrameCallback((_) {
//                       Navigator.pushReplacement(
//                         context,
//                         PageRouteBuilder(
//                           pageBuilder: (context, animation1, animation2) =>
//                               ChecklistThree(
//                             currentUserId: widget.currentUserId,
//                             selectedUserId: widget.selectedUserId,
//                           ),
//                           transitionDuration: Duration.zero,
//                           reverseTransitionDuration: Duration.zero,
//                         ),
//                       );
//                     });
//                   } else if (_currentUser.taarufChecklist == 4) {
//                     WidgetsBinding.instance.addPostFrameCallback((_) {
//                       Navigator.pushReplacement(
//                         context,
//                         PageRouteBuilder(
//                           pageBuilder: (context, animation1, animation2) =>
//                               ChecklistFour(
//                             currentUserId: widget.currentUserId,
//                             selectedUserId: widget.selectedUserId,
//                           ),
//                           transitionDuration: Duration.zero,
//                           reverseTransitionDuration: Duration.zero,
//                         ),
//                       );
//                     });
//                   } else if (_currentUser.taarufChecklist == 5) {
//                     WidgetsBinding.instance.addPostFrameCallback((_) {
//                       Navigator.pushReplacement(
//                         context,
//                         PageRouteBuilder(
//                           pageBuilder: (context, animation1, animation2) =>
//                               ChecklistFive(
//                             currentUserId: widget.currentUserId,
//                             selectedUserId: widget.selectedUserId,
//                           ),
//                           transitionDuration: Duration.zero,
//                           reverseTransitionDuration: Duration.zero,
//                         ),
//                       );
//                     });
//                   }
//                 } else {
//                   return Container(
//                     color: white,
//                     child: EmptyContent(
//                       size: size,
//                       asset: "assets/images/storm.png",
//                       header: "Whoa!",
//                       description:
//                           "Looks like ${_selectedUser.nickname} is currently having a taaruf with another user.\n\nYou can wait until ${_selectedUser.nickname} cancels the ongoing one, or maybe just find new matches.",
//                       buttonText: "Go to Home",
//                       onPressed: () {
//                         Navigator.pushAndRemoveUntil(
//                           context,
//                           PageRouteBuilder(
//                             pageBuilder: (context, animation1, animation2) =>
//                                 HomeTabs(
//                                     userId: widget.currentUserId,
//                                     selectedPage: 3),
//                             transitionDuration: Duration.zero,
//                             reverseTransitionDuration: Duration.zero,
//                           ),
//                           ((route) => false),
//                         );
//                       },
//                     ),
//                   );
//                 }
//               } else {
//                 return Container(
//                   color: white,
//                   child: EmptyContent(
//                     size: size,
//                     asset: "assets/images/stop.png",
//                     header: "Stop!",
//                     description:
//                         "You're currently having a taaruf with another user. If you changed your mind, you can cancel the ongoing taaruf at any time.",
//                     buttonText: "Go to Home",
//                     onPressed: () {
//                       Navigator.pushAndRemoveUntil(
//                         context,
//                         PageRouteBuilder(
//                           pageBuilder: (context, animation1, animation2) =>
//                               HomeTabs(
//                                   userId: widget.currentUserId,
//                                   selectedPage: 3),
//                           transitionDuration: Duration.zero,
//                           reverseTransitionDuration: Duration.zero,
//                         ),
//                         ((route) => false),
//                       );
//                     },
//                   ),
//                 );
//               }
//             }
//             return Container();
//           },
//         ),
//       ),
//     );
//   }

//   PageRouteBuilder<dynamic> reloadAfterSave() {
//     return PageRouteBuilder(
//       pageBuilder: (context, animation1, animation2) => super.widget,
//       transitionDuration: Duration.zero,
//       reverseTransitionDuration: Duration.zero,
//     );
//   }
// }
