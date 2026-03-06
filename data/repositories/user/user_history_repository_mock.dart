import 'user_history_repository.dart';

class UserHistoryRepositoryMock implements UserHistoryRepository {
  final List<String> _recentSongIds = [];

  @override
  List<String> getRecentSongIds() {
    return _recentSongIds;
  }

  @override
  void addSong(String songId) {
    _recentSongIds.remove(songId);

    _recentSongIds.insert(0, songId);

    if (_recentSongIds.length > 10) {
      _recentSongIds.removeLast();
    }
  }
}
