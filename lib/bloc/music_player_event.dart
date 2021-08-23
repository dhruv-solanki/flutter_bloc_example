import 'package:flutter/foundation.dart';

@immutable
abstract class MusicPlayerEvent {
  const MusicPlayerEvent();
}

class PlayEvent extends MusicPlayerEvent {
  final String musicTitle;

  const PlayEvent({required this.musicTitle});
}

class PauseEvent extends MusicPlayerEvent {}

class StopEvent extends MusicPlayerEvent {}