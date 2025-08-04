import 'package:flutter_bloc/flutter_bloc.dart';
import 'lyric_song_player_state.dart';

class LyricSongPlayerCubit extends Cubit<LyricSongPlayerState> {
  LyricSongPlayerCubit() : super(LyricSongPlayerLoading());

  void initListener() {
    emit(LyricSongPlayerLoaded(isExpanded: false));
  }

  void toggleExpand() {
    if (state is LyricSongPlayerLoaded) {
      final current = state as LyricSongPlayerLoaded;
      emit(LyricSongPlayerLoaded(isExpanded: !current.isExpanded));
    }
  }
}
