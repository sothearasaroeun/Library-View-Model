import 'package:flutter/material.dart';
import '../../../../data/repositories/songs/song_repository.dart';
import '../../../../model/songs/song.dart';
import '../../../states/player_state.dart';

class LibraryViewModel extends ChangeNotifier {
  final SongRepository songRepository;
  final PlayerState playerState;

  List<Song> _songs = [];

  LibraryViewModel({required this.songRepository, required this.playerState});

  void init() {
    _songs = songRepository.fetchSongs();

    playerState.addListener(() {
      notifyListeners();
    });
  }

  List<Song> get songs => _songs;

  bool isPlaying(Song song) {
    return playerState.currentSong == song;
  }

  void start(Song song) {
    playerState.start(song);
  }

  void stop() {
    playerState.stop();
  }
}
