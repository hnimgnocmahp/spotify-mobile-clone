import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spotify/domain/entities/song/song.dart';
import '../bloc/lyric_song_player_cubit.dart';
import '../bloc/lyric_song_player_state.dart';

class LyricSheet extends StatelessWidget {
  const LyricSheet({super.key, required this.song});
  final SongEntity song;

  @override
  Widget build(BuildContext context) {
    print(song.artist);
    return BlocProvider(
      create: (_) => LyricSongPlayerCubit()..initListener(),
      child: BlocBuilder<LyricSongPlayerCubit, LyricSongPlayerState>(
        builder: (context, state) {
          if (state is LyricSongPlayerLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is LyricSongPlayerLoaded) {
            final isExpanded = state.isExpanded;
            final screenHeight = MediaQuery.of(context).size.height;
            return
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  height: isExpanded ? screenHeight - kToolbarHeight - 40 : screenHeight * 0.12,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: isExpanded ? BorderRadius.zero : BorderRadius.vertical(top: Radius.circular(25)),
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                context.read<LyricSongPlayerCubit>().toggleExpand();
                              },
                              child: Icon(
                                isExpanded ? Icons.keyboard_arrow_down_rounded : Icons.keyboard_arrow_up_rounded,
                                color: Colors.white70,
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 8),
                            if (!isExpanded) Text(
                              'Lyric',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),

                        if (isExpanded) const SizedBox(height: 10),

                        if (isExpanded)
                          Expanded(
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: song.lyric.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      song.lyric[index],
                                      style: const TextStyle(
                                        color: Colors.white70,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                      ],
                    )




                  ),
                );

          }

          return const Text("Something went wrong");
        },
      ),
    );
  }
}
