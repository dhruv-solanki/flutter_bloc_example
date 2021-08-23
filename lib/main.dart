import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_example/bloc/music_player_bloc.dart';
import 'package:flutter_bloc_example/bloc/music_player_event.dart';
import 'package:flutter_bloc_example/bloc/music_player_state.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  final MusicPlayer musicPlayer = MusicPlayer();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music Player',
      theme: ThemeData(
        primarySwatch: Colors.green
      ),
      home: BlocProvider(
        create: (BuildContext context) => MusicPlayerBloc(MusicPlayer()),
        child: MainScreen(),
      ),
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<MusicPlayerBloc, MusicPlayerState>(builder: (_, state) {
          if(state is MusicPlayerPlaying) {
            return Text('Playing: ${state.musicTitle}');
          } else if(state is MusicPlayerPaused) {
            return Text('Paused');
          } else {
            return Text('Music Player');
          }
        },),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BlocBuilder<MusicPlayerBloc, MusicPlayerState>(builder: (context, state) {
              if(state is MusicPlayerIdle || state is MusicPlayerPaused) {
                return SimpleButton(
                  icon: Icons.play_arrow,
                  onPressed: () {
                    BlocProvider.of<MusicPlayerBloc>(context).add(PlayEvent(musicTitle: 'Sand Storm'));
                  }
                );
              } else {
                return SimpleButton(
                  icon: Icons.pause,
                  onPressed: () {
                    BlocProvider.of<MusicPlayerBloc>(context).add(PauseEvent());
                  }
                );
              }
            },),
            BlocBuilder<MusicPlayerBloc, MusicPlayerState>(builder: (_, state) {
              if (state is MusicPlayerPlaying || state is MusicPlayerPaused) {
                return SimpleButton(
                    icon: Icons.stop,
                    onPressed: () {
                      BlocProvider.of<MusicPlayerBloc>(context).add(StopEvent());
                    });
              } else {
                return Container(
                  width: 0,
                );
              }
            })
          ],
        ),
      ),
    );
  }
}

class SimpleButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;

  SimpleButton({required this.onPressed, required this.icon});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(icon),
      iconSize: 46,
    );
  }
}

