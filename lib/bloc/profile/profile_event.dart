// @dart=2.9

import 'dart:io';

import 'package:equatable/equatable.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();
  @override
  List<Object> get props => [];
}

class ProfileLoadedEvent extends ProfileEvent {
  final String userId;
  const ProfileLoadedEvent({this.userId});
  @override
  List<Object> get props => [userId];
}

class ResetTaarufEvent extends ProfileEvent {
  final String userId;
  const ResetTaarufEvent({this.userId});
  @override
  List<Object> get props => [userId];
}

class SubmitRatingEvent extends ProfileEvent {
  final String userId;
  final int yAppRating;
  final int yExpRating;
  final String ySuggestionRating;
  const SubmitRatingEvent({
    this.userId,
    this.yAppRating,
    this.yExpRating,
    this.ySuggestionRating,
  });
  @override
  List<Object> get props => [
        userId,
        yAppRating,
        yExpRating,
        ySuggestionRating,
      ];
}

class UploadStoryEvent extends ProfileEvent {
  final String userId;
  final int counter;
  final File story; // atau List<File> ya
  const UploadStoryEvent({this.userId, this.counter, this.story});
  @override
  List<Object> get props => [userId, counter, story];
}
