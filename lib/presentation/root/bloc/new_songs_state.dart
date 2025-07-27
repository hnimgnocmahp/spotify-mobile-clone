import '../../../domain/entities/song/song.dart';

abstract class NewSongState {}

class NewSongsLoading extends NewSongState{}

class NewSongsLoaded extends NewSongState{
  final List<SongEntity> songs;
  NewSongsLoaded({required this.songs});
}

class NewSongsLoadFailure extends NewSongState{}