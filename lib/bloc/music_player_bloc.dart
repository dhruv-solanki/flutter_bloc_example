import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_example/bloc/music_player_event.dart';
import 'package:flutter_bloc_example/bloc/music_player_state.dart';

class MusicPlayerBloc extends Bloc<MusicPlayerEvent, MusicPlayerState> {
  final MusicPlayer _musicPlayer;

  MusicPlayerBloc(this._musicPlayer) : super(MusicPlayerIdle());

  @override
  Stream<MusicPlayerState> mapEventToState(MusicPlayerEvent event) async* {
    if(event is PlayEvent) {
      final musicTitle = event.musicTitle;

      _musicPlayer.play(musicTitle);
      yield MusicPlayerPlaying(musicTitle: musicTitle);

    } else if(event is PauseEvent) {
      _musicPlayer.pause();
      yield MusicPlayerPaused();

    } else if(event is StopEvent) {
      _musicPlayer.stop();
      yield MusicPlayerIdle();
    }
  }
}

class MusicPlayer {
  void play(String musicTitle) {
    print('Play: ' + musicTitle);
  }

  void pause() {
    print('Music Paused');
  }

  void stop() {
    print('Music Stopped');
  }
}