// import 'package:flutter/widgets.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(

//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/repositories/songs/song_repository.dart';
import '../../../data/repositories/user_history_repository.dart';
import '../../states/player_state.dart';

import 'home_view_model.dart';
import 'home_content.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SongRepository songRepository = context.read<SongRepository>();
    UserHistoryRepository historyRepository = context.read<UserHistoryRepository>();
    PlayerState playerState = context.read<PlayerState>();

    return ChangeNotifierProvider(
      create: (_) {
        HomeViewModel viewModel = HomeViewModel(
          songRepository: songRepository,
          userHistoryRepository: historyRepository,
          playerState: playerState,
        );

        viewModel.init();

        return viewModel;
      },
      child: const HomeContent(),
    );
  }
}
