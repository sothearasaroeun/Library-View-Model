import 'package:flutter/material.dart';
import '../../../../data/repositories/user/user_history_repository.dart';
import '../../../../model/songs/song.dart';
import '../../../../data/repositories/songs/song_repository.dart';
import '../../../states/player_state.dart';

class HomeViewModel extends ChangeNotifier {
  final SongRepository songRepository;
  final UserHistoryRepository userHistoryRepository;
  final PlayerState playerState;

  List<Song> _recentSongs = [];
  List<Song> _recommendedSongs = [];

  HomeViewModel({required this.songRepository, required this.userHistoryRepository, required this.playerState });

  void init() {
    _loadRecentSongs();
    _loadRecommendedSongs();

    playerState.addListener(_onPlayerChanged);
  }

  void _onPlayerChanged() {
    notifyListeners();
  }

  void _loadRecentSongs() {
    List<String> recentSongIds = userHistoryRepository.getRecentSongIds();

    _recentSongs = recentSongIds
        .map((id) => songRepository.fetchSongById(id))
        .whereType<Song>()
        .toList();
  }

  void _loadRecommendedSongs() {
    List<Song> allSongs = songRepository.fetchSongs();
    _recommendedSongs = allSongs.where((song) => !_recentSongs.contains(song)).take(3).toList();
  }

  List<Song> get recentSongs => _recentSongs;

  List<Song> get recommendedSongs => _recommendedSongs;
 
  Song? get currentSong => playerState.currentSong;

  bool isPlaying(Song song) {
      return playerState.currentSong == song;
    }

    void start(Song song) {
    playerState.start(song);
    userHistoryRepository.addSong(song.id);

    _loadRecentSongs();
    _loadRecommendedSongs();

    notifyListeners();
  }

  void stop() {
    playerState.stop();
    notifyListeners();
  }

}
