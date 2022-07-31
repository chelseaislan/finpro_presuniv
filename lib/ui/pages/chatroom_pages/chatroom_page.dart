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
import 'package:finpro_max/custom_widgets/buttons/big_wide_button.dart';
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
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';

class ChatroomPage extends StatefulWidget {
  final User currentUser, selectedUser;

  const ChatroomPage({this.currentUser, this.selectedUser});

  @override
  State<ChatroomPage> createState() => _ChatroomPageState();
}

// 40/41 - completing the chatroom page
class _ChatroomPageState extends State<ChatroomPage>
    with TickerProviderStateMixin {
  AnimationController _animationController, _vnController;
  final ChatroomRepository _chatroomRepository = ChatroomRepository();
  ChatroomBloc _chatroomBloc;
  final TextEditingController _messageController = TextEditingController();
  bool isValid = false; // for text controller
  final recorder = FlutterSoundRecorder();
  bool isRecorderReady = false;
  File recordedAudio;

  Future record() async {
    if (!isRecorderReady) return;
    await recorder.startRecorder(toFile: 'audio');
  }

  Future stop() async {
    if (!isRecorderReady) return;
    final audioPath = await recorder.stopRecorder();
    final audioFile = File(audioPath);
    debugPrint("Recorded audio => $audioFile");
    setState(() => recordedAudio = audioFile);
  }

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
    _vnController = BottomSheet.createAnimationController(this);
    _vnController.duration = const Duration(seconds: 0);
    initRecorder();
  }

  // dispose the text controller after sending a text msg
  @override
  void dispose() {
    _messageController.dispose();
    _animationController.dispose();
    _vnController.dispose();
    recorder.closeAudioSession(); // closeRecorder
    super.dispose();
  }

  // Ask permission for microphone
  Future initRecorder() async {
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      return showModalBottomSheet(
        transitionAnimationController: _animationController,
        context: context,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        ),
        builder: (context) {
          return ModalPopupOneButton(
            size: MediaQuery.of(context).size,
            title: "Microphone Permission Denied",
            image: "assets/images/404.png",
            description:
                "To record and upload voicenotes, please enable permission to record audio.",
            onPressed: () => AppSettings.openAppSettings(),
          );
        },
      );
    }
    await recorder.openAudioSession(); // openRecorder
    isRecorderReady = true;
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
          voicenote: null,
        ),
      ),
    );
    _messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final List buttonIcons = [
      Icons.self_improvement_outlined,
      Icons.add_photo_alternate_outlined,
      Icons.note_add_outlined,
      Icons.record_voice_over_outlined,
    ];
    final List buttonTitles = [
      "Marry ${widget.selectedUser.nickname}?",
      "Upload a picture",
      "Upload a document",
      "Upload a voicenote",
    ];
    final List buttonSubs = [
      "This will bring you both into the Taaruf process.",
      "Accepted formats are JPG and PNG. Viewable for both users.",
      "It can be your marriage CV for ${widget.selectedUser.nickname} to view, or any other PDF documents.",
      "Record your own voice so that it can be heard by ${widget.selectedUser.nickname}!",
    ];
    final List buttonTap = [
      () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) =>
                // ChecklistOne(
                ChecklistZero(
              currentUserId: widget.currentUser.uid,
              selectedUserId: widget.selectedUser.uid,
            ),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ),
        );
      },
      () async {
        try {
          FilePickerResult photo =
              await FilePicker.platform.pickFiles(type: FileType.image);
          if (photo != null) {
            File file = File(photo.files.single.path);
            ScaffoldMessenger.of(context).showSnackBar(
              myLoadingSnackbar(
                text: "Uploading picture...",
                duration: 10,
                background: primaryBlack,
              ),
            );
            Navigator.pop(context);
            _chatroomBloc.add(
              SendMessageEvent(
                messageDetail: MessageDetail(
                  text: null,
                  marriageDoc: null,
                  senderId: widget.currentUser.uid,
                  senderNickname: widget.currentUser.nickname,
                  selectedUserId: widget.selectedUser.uid,
                  photo: file,
                  voicenote: null,
                ),
              ),
            );
          }
        } catch (e) {
          storageError(context, size);
        }
      },
      () async {
        try {
          FilePickerResult marriageDoc = await FilePicker.platform.pickFiles(
            type: FileType.custom,
            allowedExtensions: ['pdf'],
          );
          if (marriageDoc != null) {
            File file = File(marriageDoc.files.single.path);
            ScaffoldMessenger.of(context).showSnackBar(
              myLoadingSnackbar(
                text: "Uploading document...",
                duration: 10,
                background: primaryBlack,
              ),
            );
            Navigator.pop(context);
            _chatroomBloc.add(
              SendMessageEvent(
                messageDetail: MessageDetail(
                  text: null,
                  marriageDoc: file,
                  senderId: widget.currentUser.uid,
                  senderNickname: widget.currentUser.nickname,
                  selectedUserId: widget.selectedUser.uid,
                  photo: null,
                  voicenote: null,
                ),
              ),
            );
          }
        } catch (e) {
          storageError(context, size);
        }
      },
      () {
        showModalBottomSheet(
          transitionAnimationController: _vnController,
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          ),
          isScrollControlled: true,
          builder: (context) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 23, 20, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    HeaderThreeText(
                      text: "Tap the microphone to record.",
                      color: secondBlack,
                      align: TextAlign.center,
                    ),
                    const SizedBox(height: 15),
                    GestureDetector(
                      child: CircleAvatar(
                        maxRadius: 50,
                        backgroundColor: primaryBlack,
                        child: Icon(
                          Icons.mic_outlined,
                          color: pureWhite,
                          size: 40,
                        ),
                      ),
                      onTap: () async {
                        if (recorder.isRecording) {
                          Fluttertoast.showToast(
                            msg: "Finished recording, you can upload the file.",
                            toastLength: Toast.LENGTH_LONG,
                          );
                          await stop();
                        } else {
                          Fluttertoast.showToast(
                            msg: "Recording in progress.",
                            toastLength: Toast.LENGTH_LONG,
                          );
                          await record();
                        }
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: DescText(
                        text:
                            "If you are done, tap the microphone again and then upload it.",
                        color: secondBlack,
                        align: TextAlign.center,
                      ),
                    ),
                    BigWideButton(
                      labelText: "Upload Voicenote",
                      onPressedTo: () {
                        if (recordedAudio != null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            myLoadingSnackbar(
                              text: "Uploading voicenote...",
                              duration: 5,
                              background: primaryBlack,
                            ),
                          );
                          Navigator.pop(context);
                          Navigator.pop(context);
                          _chatroomBloc.add(
                            SendMessageEvent(
                              messageDetail: MessageDetail(
                                text: null,
                                marriageDoc: null,
                                senderId: widget.currentUser.uid,
                                senderNickname: widget.currentUser.nickname,
                                selectedUserId: widget.selectedUser.uid,
                                photo: null,
                                voicenote: recordedAudio,
                              ),
                            ),
                          );
                        } else {
                          Fluttertoast.showToast(
                            msg: "Please record your voice before uploading.",
                            toastLength: Toast.LENGTH_LONG,
                          );
                        }
                      },
                      textColor: pureWhite,
                      btnColor: primary1,
                    ),
                    const SizedBox(height: 15),
                    BigWideButton(
                      labelText: "Cancel",
                      onPressedTo: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      textColor: pureWhite,
                      btnColor: primary2,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    ];
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
                  color: pureWhite,
                ),
                MiniText(
                  text:
                      "${widget.selectedUser.jobPosition} at ${widget.selectedUser.currentJob}",
                  color: pureWhite,
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
              return Center(child: CircularProgressIndicator(color: pureWhite));
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
                          color: pureWhite,
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
                            color: pureWhite,
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
                        GestureDetector(
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: size.width * 0.04,
                              right: size.width * 0.03,
                            ),
                            child: Icon(
                              Icons.add_circle_outlined,
                              color: pureWhite,
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
                                  child: ListView.builder(
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: buttonTitles.length,
                                    itemBuilder: (context, index) {
                                      return ChatroomButtons(
                                        iconData: buttonIcons[index],
                                        title: buttonTitles[index],
                                        subtitle: buttonSubs[index],
                                        onTap: buttonTap[index],
                                      );
                                    },
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
                                  fillColor: pureWhite,
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
                        GestureDetector(
                          onTap: isValid ? _onFormSubmitted : null,
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: size.width * 0.03,
                              right: size.width * 0.04,
                            ),
                            child: Icon(
                              Icons.send_outlined,
                              color: isValid ? pureWhite : lightGrey3,
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
