class LyricSongPlayerState{}

class LyricSongPlayerLoading extends LyricSongPlayerState{}

class LyricSongPlayerLoaded extends LyricSongPlayerState{
  final bool isExpanded;
  LyricSongPlayerLoaded({required this.isExpanded});
}

class LyricSongPlayerLoadFailure extends LyricSongPlayerState{}
