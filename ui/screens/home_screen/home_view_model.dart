import 'package:flutter/material.dart';
import '../../../data/repositories/user_history_repository.dart';
import '../../../model/songs/song.dart';
import '../../../data/repositories/songs/song_repository.dart';
import '../../states/player_state.dart';

class HomeViewModel extends ChangeNotifier {
  final SongRepository songRepository;
  final UserHistoryRepository userHistoryRepository;
  final PlayerState playerState;

  List<Song> _recentSongs = [];
  List<Song> _recommendedSongs = [];

  HomeViewModel({
    required this.songRepository,
    required this.userHistoryRepository,
    required this.playerState,
  });

  void init() {
    /// get recent song IDs
    List<String> recentSongIds = userHistoryRepository.getRecentSongIds();

    /// convert IDs to Song objects
    _recentSongs = recentSongIds
        .map((id) => songRepository.fetchSongById(id))
        .whereType<Song>()
        .toList();

    /// simple recommendation logic
    /// (songs that are not in recent songs)
    List<Song> allSongs = songRepository.fetchSongs();

    _recommendedSongs = allSongs
        .where((song) => !_recentSongs.contains(song))
        .take(3)
        .toList();

    /// listen to player state
    playerState.addListener(() {
      notifyListeners();
    });
  }

  /// getters for UI

  List<Song> get recentSongs => _recentSongs;

  List<Song> get recommendedSongs => _recommendedSongs;

  Song? get currentSong => playerState.currentSong;

  /// actions

  void start(Song song) {
    playerState.start(song);

    userHistoryRepository.addSong(song.id);

    notifyListeners();
  }

  void stop() {
    playerState.stop();
    notifyListeners();
  }

  bool isPlaying(Song song) {
    return playerState.currentSong == song;
  }
}
