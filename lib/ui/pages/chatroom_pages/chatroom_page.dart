// @dart=2.9
// Start 31/41
import 'dart:io';

import 'package:app_settings/app_settings.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:finpro_max/bloc/chatroom/chatroom_bloc.dart';
import 'package:finpro_max/bloc/chatroom/chatroom_event.dart';
import 'package:finpro_max/bloc/chatroom/chatroom_state.dart';
import 'package:finpro_max/custom_widgets/buttons/appbar_sidebutton.dart';
import 'package:finpro_max/custom_widgets/modal_popup.dart';
import 'package:finpro_max/custom_widgets/my_snackbar.dart';
import 'package:finpro_max/custom_widgets/text_styles.dart';
import 'package:finpro_max/models/colors.dart';
import 'package:finpro_max/models/message_detail.dart';
import 'package:finpro_max/models/user.dart';
import 'package:finpro_max/repositories/chatroom_repository.dart';
import 'package:finpro_max/ui/pages/taaruf_pages/checklist_0_page.dart';
import 'package:finpro_max/ui/widgets/card_swipe_widgets/card_photo.dart';
import 'package:finpro_max/ui/widgets/chatroom_widgets/chatroom_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatroomPage extends StatefulWidget {
  final User currentUser, selectedUser;

  const ChatroomPage({this.currentUser, this.selectedUser});

  @override
  State<ChatroomPage> createState() => _ChatroomPageState();
}

// 40/41 - completing the chatroom page
class _ChatroomPageState extends State<ChatroomPage>
    with TickerProviderStateMixin {
  AnimationController _animationController;
  final ChatroomRepository _chatroomRepository = ChatroomRepository();
  ChatroomBloc _chatroomBloc;
  final TextEditingController _messageController = TextEditingController();
  bool isValid = false; // for text controller

  @override
  void initState() {
    super.initState();
    _chatroomBloc = ChatroomBloc(chatroomRepository: _chatroomRepository);
    _messageController.text = ''; // empty string when the activity launched
    _messageController.addListener(
      () {
        setState(() {
          // if the controller is empty, then it's not valid, else = valid
          isValid = (_messageController.text.isEmpty) ? false : true;
        });
      },
    );

    _animationController = BottomSheet.createAnimationController(this);
    _animationController.duration = const Duration(seconds: 0);
  }

  // dispose the text controller after sending a text msg
  @override
  void dispose() {
    _messageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _onFormSubmitted() {
    debugPrint("Message sent");
    _chatroomBloc.add(
      SendMessageEvent(
        messageDetail: MessageDetail(
          text: _messageController.text,
          senderId: widget.currentUser.uid,
          senderNickname: widget.currentUser.nickname,
          selectedUserId: widget.selectedUser.uid,
          photo: null,
          marriageDoc: null,
        ),
      ),
    );
    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBarSideButton(
        appBarTitle: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipOval(
              child: SizedBox(
                height: size.height * 0.05,
                width: size.height * 0.05,
                child: CardPhotoWidget(photoLink: widget.selectedUser.photo),
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeaderFourText(
                  text:
                      "${widget.selectedUser.nickname}, ${widget.selectedUser.age}",
                  color: white,
                ),
                MiniText(
                  text:
                      "${widget.selectedUser.jobPosition} at ${widget.selectedUser.currentJob}",
                  color: white,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          ],
        ),
        appBarColor: primary1,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/chat-bg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: BlocBuilder<ChatroomBloc, ChatroomState>(
          bloc: _chatroomBloc,
          builder: (BuildContext context, ChatroomState state) {
            if (state is ChatroomInitialState) {
              _chatroomBloc.add(
                MessageStreamEvent(
                  currentUserId: widget.currentUser.uid,
                  selectedUserId: widget.selectedUser.uid,
                ),
              );
            }
            if (state is ChatroomLoadingState) {
              return Center(child: CircularProgressIndicator(color: white));
            }
            if (state is ChatroomLoadedState) {
              Stream<QuerySnapshot> messageStream = state.messageStream;
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Middle section to display chats and whatnot
                  StreamBuilder<QuerySnapshot>(
                    stream: messageStream,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(
                            child: CircularProgressIndicator(
                          color: white,
                        ));
                      }
                      if (snapshot.data.documents.isNotEmpty) {
                        return Expanded(
                          child: Column(
                            children: [
                              Expanded(
                                child: ListView.builder(
                                  cacheExtent: 1000000,
                                  scrollDirection: Axis.vertical,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    // bubbles
                                    return ChatroomWidget(
                                      currentUserId: widget.currentUser.uid,
                                      messageId: snapshot
                                          .data.documents[index].documentID,
                                    );
                                  },
                                  itemCount: snapshot.data.documents.length,
                                ),
                              )
                            ],
                          ),
                        );
                      } else {
                        return Container(
                          margin: EdgeInsets.only(top: size.height * 0.05),
                          padding: const EdgeInsets.fromLTRB(20, 20, 20, 18),
                          decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              Image.asset(
                                "assets/images/tips.png",
                                width: size.width * 0.38,
                                height: size.width * 0.38,
                              ),
                              const SizedBox(height: 10),
                              ChatText(
                                text: "Would you like to say hi first?",
                                color: secondBlack,
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  ),
                  // Bottom section for send image, attachment, text, send 41/41
                  Container(
                    width: size.width,
                    height: size.height * 0.1,
                    decoration: BoxDecoration(
                      color: primary5,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                    ),
                    child: Row(
                      children: [
                        // upload image, cv, taaruf buttons
                        GestureDetector(
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: size.width * 0.04,
                              right: size.width * 0.03,
                            ),
                            child: Icon(
                              Icons.add_circle_outlined,
                              color: white,
                              size: size.height * 0.04,
                            ),
                          ),
                          onTap: () {
                            showModalBottomSheet(
                              transitionAnimationController:
                                  _animationController,
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
                                  child: SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        ChatroomButtons(
                                          iconData:
                                              Icons.self_improvement_outlined,
                                          title:
                                              "Marry ${widget.selectedUser.nickname}?",
                                          subtitle:
                                              "This will bring you both into the Taaruf process.",
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              PageRouteBuilder(
                                                pageBuilder: (context,
                                                        animation1,
                                                        animation2) =>
                                                    // ChecklistOne(
                                                    ChecklistZero(
                                                  currentUserId:
                                                      widget.currentUser.uid,
                                                  selectedUserId:
                                                      widget.selectedUser.uid,
                                                ),
                                                transitionDuration:
                                                    Duration.zero,
                                                reverseTransitionDuration:
                                                    Duration.zero,
                                              ),
                                            );
                                          },
                                        ),
                                        ChatroomButtons(
                                          iconData: Icons
                                              .add_photo_alternate_outlined,
                                          title: "Upload a picture",
                                          subtitle:
                                              "Accepted formats are JPG and PNG. Viewable for both users.",
                                          onTap: () async {
                                            try {
                                              // File photo =
                                              //     await FilePicker.getFile(
                                              //         type: FileType.image);
                                              // if (photo != null) {

                                              FilePickerResult photo =
                                                  await FilePicker.platform
                                                      .pickFiles(
                                                          type: FileType.image);
                                              if (photo != null) {
                                                File file = File(
                                                    photo.files.single.path);
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  myLoadingSnackbar(
                                                    text:
                                                        "Uploading picture...",
                                                    duration: 15,
                                                    background: primaryBlack,
                                                  ),
                                                );
                                                Navigator.pop(context);
                                                _chatroomBloc.add(
                                                  SendMessageEvent(
                                                    messageDetail:
                                                        MessageDetail(
                                                      text: null,
                                                      marriageDoc: null,
                                                      senderId: widget
                                                          .currentUser.uid,
                                                      senderNickname: widget
                                                          .currentUser.nickname,
                                                      selectedUserId: widget
                                                          .selectedUser.uid,
                                                      photo: file,
                                                    ),
                                                  ),
                                                );
                                              }
                                            } catch (e) {
                                              storageError(context, size);
                                            }
                                          },
                                        ),
                                        ChatroomButtons(
                                          iconData: Icons.note_add_outlined,
                                          title: "Upload a document",
                                          subtitle:
                                              "It can be your marriage CV for ${widget.currentUser.nickname} to view, or any other PDF documents.",
                                          onTap: () async {
                                            try {
                                              // File marriageDoc =
                                              //     await FilePicker.getFile(
                                              //         type: FileType.custom,
                                              //         allowedExtensions: [
                                              //       'pdf'
                                              //     ]);
                                              // if (marriageDoc != null) {
                                              FilePickerResult marriageDoc =
                                                  await FilePicker.platform
                                                      .pickFiles(
                                                type: FileType.custom,
                                                allowedExtensions: ['pdf'],
                                              );
                                              if (marriageDoc != null) {
                                                File file = File(marriageDoc
                                                    .files.single.path);
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  myLoadingSnackbar(
                                                    text:
                                                        "Uploading document...",
                                                    duration: 15,
                                                    background: primaryBlack,
                                                  ),
                                                );
                                                Navigator.pop(context);
                                                _chatroomBloc.add(
                                                  SendMessageEvent(
                                                    messageDetail:
                                                        MessageDetail(
                                                      text: null,
                                                      marriageDoc: file,
                                                      senderId: widget
                                                          .currentUser.uid,
                                                      senderNickname: widget
                                                          .currentUser.nickname,
                                                      selectedUserId: widget
                                                          .selectedUser.uid,
                                                      photo: null,
                                                    ),
                                                  ),
                                                );
                                              }
                                            } catch (e) {
                                              storageError(context, size);
                                            }
                                          },
                                        ),
                                        ChatroomButtons(
                                          iconData:
                                              Icons.record_voice_over_outlined,
                                          title: "New feature?",
                                          subtitle: "What will it be...?",
                                          onTap: () {},
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                        // Text Field
                        Expanded(
                          // to stretch between left & right widgets
                          child: Container(
                            height: size.height * 0.08,
                            padding: EdgeInsets.all(size.height * 0.01),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                size.height * 0.04,
                              ),
                            ),
                            child: Center(
                              child: TextFormField(
                                textCapitalization:
                                    TextCapitalization.sentences,
                                controller: _messageController,
                                textInputAction: TextInputAction.done,
                                cursorColor: primary1,
                                keyboardType: TextInputType.text,
                                style: TextStyle(
                                    color: secondBlack,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w200),
                                decoration: InputDecoration(
                                  contentPadding:
                                      const EdgeInsets.fromLTRB(16, 4, 6, 4),
                                  hintText: "Input anything here...",
                                  fillColor: white,
                                  filled: true,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide:
                                        BorderSide(width: 3, color: lightGrey2),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                    borderSide:
                                        BorderSide(width: 3, color: lightGrey3),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Send text button, if no text then grayed
                        InkWell(
                          onTap: isValid ? _onFormSubmitted : null,
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: size.width * 0.03,
                              right: size.width * 0.04,
                            ),
                            child: Icon(
                              Icons.send_outlined,
                              color: isValid ? white : lightGrey3,
                              size: size.height * 0.03,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
            return Container();
          },
        ),
      ),
    );
  }

  Future<dynamic> storageError(BuildContext context, Size size) {
    return showModalBottomSheet(
      transitionAnimationController: _animationController,
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
      ),
      builder: (context) {
        return ModalPopupOneButton(
          size: size,
          title: "Storage Permission Denied",
          image: "assets/images/404.png",
          description:
              "To upload pictures and documents, please enable permission to read external storage.",
          onPressed: () => AppSettings.openAppSettings(),
        );
      },
    );
  }
}

class ChatroomButtons extends StatelessWidget {
  const ChatroomButtons({
    Key key,
    @required this.iconData,
    @required this.title,
    @required this.subtitle,
    @required this.onTap,
  }) : super(key: key);

  final IconData iconData;
  final String title, subtitle;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: ListTile(
        leading: Icon(
          iconData,
          color: primary1,
          size: 30,
        ),
        title: HeaderFourText(
          text: title,
          color: secondBlack,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 5),
            SmallText(
              text: subtitle,
              color: thirdBlack,
            ),
            const SizedBox(height: 5),
          ],
        ),
      ),
      onTap: onTap,
    );
  }
}
