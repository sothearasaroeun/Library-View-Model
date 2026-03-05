class UserHistoryRepository {
  final List<String> _recentSongIds = [];

  List<String> getRecentSongIds() {
    return _recentSongIds;
  }

  void addSong(String songId) {
    _recentSongIds.remove(songId);

    _recentSongIds.insert(0, songId);

    if (_recentSongIds.length > 10) {
      _recentSongIds.removeLast();
    }
  }
}
