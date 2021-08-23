import 'package:flutter/foundation.dart';

@immutable
abstract class MusicPlayerState {
  const MusicPlayerState();
}

class MusicPlayerIdle extends MusicPlayerState {}

class MusicPlayerPlaying extends MusicPlayerState {
  final String musicTitle;

  const MusicPlayerPlaying({required this.musicTitle});
}

class MusicPlayerPaused extends MusicPlayerState {}