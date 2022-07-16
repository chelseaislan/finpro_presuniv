// @dart=2.9
// Start 35/41

import 'dart:async';
import 'dart:developer' as developer;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:finpro_max/bloc/message/bloc.dart';
import 'package:finpro_max/custom_widgets/buttons/appbar_sidebutton.dart';
import 'package:finpro_max/custom_widgets/empty_content.dart';
import 'package:finpro_max/models/colors.dart';
import 'package:finpro_max/repositories/message_repository.dart';
import 'package:finpro_max/ui/widgets/message_widgets/message_widget.dart';
import 'package:finpro_max/ui/widgets/tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessagesPage extends StatefulWidget {
  final String userId;
  MessagesPage({this.userId});

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  MessageRepository _messageRepository = MessageRepository();
  MessageBloc _messageBloc;
  // check internet connection
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    _messageBloc = MessageBloc(messageRepository: _messageRepository);
    super.initState();
    // check internet in initial state
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  // initialize connectivity async method
  Future<void> initConnectivity() async {
    ConnectivityResult result;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      developer.log('Couldn\'t check connectivity status', error: e);
      return;
    }
    if (!mounted) {
      return Future.value(null);
    }
    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() => _connectionStatus = result);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBarSideButton(
        appBarTitle: const Text("Messages"),
        appBarColor: primary1,
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation1, animation2) =>
                  HomeTabs(userId: widget.userId, selectedPage: 3),
              transitionDuration: Duration.zero,
              reverseTransitionDuration: Duration.zero,
            ),
          );
        },
        child: BlocBuilder<MessageBloc, MessageState>(
          bloc: _messageBloc,
          builder: (BuildContext context, MessageState state) {
            // check connection
            if (_connectionStatus == ConnectivityResult.mobile ||
                _connectionStatus == ConnectivityResult.wifi) {
              if (state is MessageInitialState) {
                _messageBloc.add(ChatStreamEvent(currentUserId: widget.userId));
              }
              if (state is ChatLoadingState) {
                return Center(
                  child: CircularProgressIndicator(color: primary1),
                );
              }
              if (state is ChatLoadedState) {
                Stream<QuerySnapshot> chatStream = state.chatStream;
                return StreamBuilder<QuerySnapshot>(
                  stream: chatStream,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Container();
                    }
                    if (snapshot.data.documents.isNotEmpty) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                            child: CircularProgressIndicator(color: primary1));
                      } else {
                        return Stack(
                          children: [
                            Align(
                              alignment: Alignment.topCenter,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child:
                                    CircularProgressIndicator(color: primary1),
                              ),
                            ),
                            ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: snapshot.data.documents.length,
                              itemBuilder: (BuildContext context, int index) {
                                return MessageWidget(
                                  creationTime: snapshot
                                      .data.documents[index].data['timestamp'],
                                  userId: widget.userId,
                                  selectedUserId:
                                      snapshot.data.documents[index].documentID,
                                );
                              },
                            ),
                          ],
                        );
                      }
                    } else {
                      return EmptyContent(
                        size: size,
                        asset: "assets/images/messages-tab.png",
                        header: "Wait a second...",
                        description:
                            "You don't have any conversations. Discover and match with other users to start chatting!",
                        buttonText: "Refresh",
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation1, animation2) =>
                                  HomeTabs(
                                      userId: widget.userId, selectedPage: 3),
                              transitionDuration: Duration.zero,
                              reverseTransitionDuration: Duration.zero,
                            ),
                          );
                        },
                      );
                    }
                  },
                );
              }
              return Center(
                child: CircularProgressIndicator(color: primary1),
              );
            } else {
              return EmptyContent(
                size: size,
                asset: "assets/images/empty-container.png",
                header: "Oops...",
                description:
                    "Looks like the Internet is down or something else happened. Please try again later.",
                buttonText: "Refresh",
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) =>
                          HomeTabs(userId: widget.userId, selectedPage: 3),
                      transitionDuration: Duration.zero,
                      reverseTransitionDuration: Duration.zero,
                    ),
                    ((route) => false),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
