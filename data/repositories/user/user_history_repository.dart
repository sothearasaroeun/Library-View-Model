abstract class UserHistoryRepository {

  List<String> getRecentSongIds();

  void addSong(String songId);
}
