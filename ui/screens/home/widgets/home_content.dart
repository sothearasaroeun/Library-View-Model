import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../model/songs/song.dart';
import '../../../states/settings_state.dart';
import '../view_model/home_view_model.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    HomeViewModel viewModel = context.watch<HomeViewModel>();
    AppSettingsState settingsState = context.watch<AppSettingsState>();


    return Container(
      color: settingsState.theme.backgroundColor,
      child: Column(
        children: [
          const SizedBox(height: 20),
          const Text("Home", style: TextStyle(fontSize: 24)),

          const SizedBox(height: 30),
          const Text(
            "Your recent songs",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          ...viewModel.recentSongs.map(
            (song) => SongTile(
              song: song,
              isPlaying: viewModel.isPlaying(song),
              onTap: () => viewModel.start(song),
            ),
          ),
          const SizedBox(height: 30),

          const Text(
            "You might also like",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          ...viewModel.recommendedSongs.map(
            (song) => SongTile(
              song: song,
              isPlaying: viewModel.isPlaying(song),
              onTap: () => viewModel.start(song),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
      
    );
  }
}

class SongTile extends StatelessWidget {
  final Song song;
  final bool isPlaying;
  final VoidCallback onTap;

  const SongTile({
    super.key,
    required this.song,
    required this.isPlaying,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(song.title),
      trailing: isPlaying
          ? const Text("Playing", style: TextStyle(color: Colors.amber))
          : null,
      onTap: onTap,
    );
  }
}
